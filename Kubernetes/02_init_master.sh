#!/bin/bash

#####################################################################
## 사용자 설정 값
# https://github.com/kubernetes/kubeadm/blob/main/docs/ha-considerations.md#options-for-software-load-balancing
#
# 사용하고자  하는  MASTER들의  HOSTNAME을  변경하고자  한다면, 아래  HOST1_ID ...를  수정
# 기본  설정은  master1, master2, master3

HOSTNAME=`hostname -s`
HOSTNAME="master2"

# keepalived 설정
# INTERFACE:            네트워크 인터페이스 이름 (예: eth0)
# APISERVER_VIP:        로드밸런서 역할을 할 VIP 대표 IP
# APISERVER_SRC_PORT:   APISERVER PORT (default 6443)

INTERFACE="eth0"  # 네트워크 인터페이스 이름
APISERVER_VIP="192.168.100.24"  # VIP 대표 IP

# haproxy
HOST1_ID="master1"; HOST1_ADDRESS="192.168.100.21"
HOST2_ID="master2"; HOST2_ADDRESS="192.168.100.22"
HOST3_ID="master3"; HOST3_ADDRESS="192.168.100.23"
APISERVER_SRC_PORT="6443"

if [ $HOSTNAME = $HOST1_ID ]
then
    PRIORITY="100"
    STATE="MASTER"
    UNICAST_SRC_IP="${HOST1_ADDRESS}"
    UNICAST_PEER="${HOST2_ADDRESS}
        ${HOST3_ADDRESS}"
    echo UNICAST_PEER
elif [ $HOSTNAME = $HOST2_ID ]
then
    PRIORITY="99"
    STATE="BACKUP"
    UNICAST_SRC_IP="${HOST2_ADDRESS}"
    UNICAST_PEER="${HOST1_ADDRESS}
        ${HOST3_ADDRESS}"
elif [ $HOSTNAME = $HOST3_ID ]
then
    PRIORITY="98"
    STATE="BACKUP"
    UNICAST_SRC_IP="${HOST3_ADDRESS}"
    UNICAST_PEER="${HOST1_ADDRESS}
        ${HOST2_ADDRESS}"
else
    echo "The hostname does not match."
    echo "check your hostname! hostname should be [${HOST1_ID}|${HOST2_ID}|${HOST3_ID}]"
    exit 1
fi

#####################################################################

######### keepalived
sudo mkdir -p /etc/keepalived
sudo mkdir -p /etc/kubernetes/manifests
sudo cp ./config/check_apiserver.sh /etc/keepalived
echo "#############################################"
echo "#### /etc/keepalived/keepalived.conf"
echo "#############################################"
cat <<EOF | sudo tee /etc/keepalived/keepalived.conf
! /etc/keepalived/keepalived.conf
! Configuration File for keepalived
global_defs {
    router_id LVS_DEVEL
}
vrrp_script check_apiserver {
  script "/etc/keepalived/check_apiserver.sh"
  interval 3
  weight -2
  fall 10
  rise 2
}

vrrp_instance VI_1 {
    state ${STATE}
    interface ${INTERFACE}
    virtual_router_id 55
    priority ${PRIORITY}
    unicast_src_ip ${UNICAST_SRC_IP}
    unicast_peer {
      ${UNICAST_PEER}
    }
    authentication {
        auth_type PASS
        auth_pass 1122
    }
    virtual_ipaddress {
        ${APISERVER_VIP}
    }
    track_script {
        check_apiserver
    }
}
EOF

echo;echo
echo "#############################################"
echo "#### /etc/keepalived/check_apiserver.sh"
echo "#############################################"
cat <<EOF | sudo tee /etc/keepalived/check_apiserver.sh
#!/bin/sh

errorExit() {
    echo "*** $*" 1>&2
    exit 1
}

curl --silent --max-time 2 --insecure https://localhost:${APISERVER_DEST_PORT}/ -o /dev/null || errorExit "Error GET https://localhost:${APISERVER_DEST_PORT}/"
if ip addr | grep -q ${APISERVER_VIP}; then
    curl --silent --max-time 2 --insecure https://${APISERVER_VIP}:${APISERVER_DEST_PORT}/ -o /dev/null || errorExit "Error GET https://${APISERVER_VIP}:${APISERVER_DEST_PORT}/"
fi
EOF

echo;echo
echo "#############################################"
echo "#### /etc/kubernetes/manifests/keepalived.yaml"
echo "#############################################"
cat <<EOF | sudo tee /etc/kubernetes/manifests/keepalived.yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  name: keepalived
  namespace: kube-system
spec:
  containers:
  - image: osixia/keepalived:2.0.17
    name: keepalived
    resources: {}
    securityContext:
      capabilities:
        add:
        - NET_ADMIN
        - NET_BROADCAST
        - NET_RAW
    volumeMounts:
    - mountPath: /usr/local/etc/keepalived/keepalived.conf
      name: config
    - mountPath: /etc/keepalived/check_apiserver.sh
      name: check
  hostNetwork: true
  volumes:
  - hostPath:
      path: /etc/keepalived/keepalived.conf
    name: config
  - hostPath:
      path: /etc/keepalived/check_apiserver.sh
    name: check
status: {}
EOF


######### haproxy
echo;echo
echo "#############################################"
echo "#### /etc/haproxy/haproxy.cfg"
echo "#############################################"
sudo mkdir -p /etc/haproxy
cat <<EOF | sudo tee /etc/haproxy/haproxy.cfg
# /etc/haproxy/haproxy.cfg
#---------------------------------------------------------------------
# Global settings
#---------------------------------------------------------------------
global
    log /dev/log local0
    log /dev/log local1 notice
    daemon

#---------------------------------------------------------------------
# common defaults that all the 'listen' and 'backend' sections will
# use if not designated in their block
#---------------------------------------------------------------------
defaults
    mode                    http
    log                     global
    option                  httplog
    option                  dontlognull
    option http-server-close
    option forwardfor       except 127.0.0.0/8
    option                  redispatch
    retries                 1
    timeout http-request    10s
    timeout queue           20s
    timeout connect         5s
    timeout client          20s
    timeout server          20s
    timeout http-keep-alive 10s
    timeout check           10s

#---------------------------------------------------------------------
# apiserver frontend which proxys to the control plane nodes
#---------------------------------------------------------------------
frontend apiserver
    bind *:6444
    mode tcp
    option tcplog
    default_backend apiserver

#---------------------------------------------------------------------
# round robin balancing for apiserver
#---------------------------------------------------------------------
backend apiserver
    option httpchk GET /healthz
    http-check expect status 200
    mode tcp
    option ssl-hello-chk
    balance     roundrobin
        server ${HOST1_ID} ${HOST1_ADDRESS}:6443 check
        server ${HOST2_ID} ${HOST2_ADDRESS}:6443 check
        server ${HOST3_ID} ${HOST3_ADDRESS}:6443 check
EOF

echo;echo
echo "#############################################"
echo "#### /etc/kubernetes/manifests/haproxy.yaml"
echo "#############################################"
cat <<EOF | sudo tee /etc/kubernetes/manifests/haproxy.yaml
apiVersion: v1
kind: Pod
metadata:
  name: haproxy
  namespace: kube-system
spec:
  containers:
  - image: haproxy:2.1.4
    name: haproxy
    livenessProbe:
      failureThreshold: 8
      httpGet:
        host: localhost
        path: /healthz
        port: 6444
        scheme: HTTPS
    volumeMounts:
    - mountPath: /usr/local/etc/haproxy/haproxy.cfg
      name: haproxyconf
      readOnly: true
  hostNetwork: true
  volumes:
  - hostPath:
      path: /etc/haproxy/haproxy.cfg
      type: FileOrCreate
    name: haproxyconf
status: {}
EOF

# check generated files
echo;echo
function print_exist_file() {
    local FILE=$1
    [ -f ${FILE} ] && echo "[OK] $FILE exists." || echo "[FAIL] $FILE does not exist."
}

print_exist_file "/etc/keepalived/check_apiserver.sh"
print_exist_file "/etc/keepalived/keepalived.conf"
print_exist_file "/etc/haproxy/haproxy.cfg"
print_exist_file "/etc/kubernetes/manifests/keepalived.yaml"
print_exist_file "/etc/kubernetes/manifests/haproxy.yaml"

###

if [ $HOSTNAME = $HOST1_ID ] 
then
    sudo kubeadm init --control-plane-endpoint "${APISERVER_VIP}:6444" --upload-certs && \

    mkdir -p $HOME/.kube && \
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config && \
    sudo chown $(id -u):$(id -g) $HOME/.kube/config && \

    ## Calico Networks (CNI):
    # https://projectcalico.docs.tigera.io/getting-started/kubernetes/self-managed-onprem/onpremises
    curl https://docs.projectcalico.org/manifests/calico.yaml -O && \
    kubectl apply -f calico.yaml
else
    echo "After executing 02_init_master.sh on ${HOST1_ID}, register the control-plane with the example command below in the remaining masters."
    echo "##### EXAPLE (** NOTE: NEVER EXCUTE THE COMMAND BELLOW AS IT IS. **) ######"
    echo "sudo kubeadm join ${APISERVER_VIP} --token XXXXXX \\
      --discovery-token-ca-cert-hash sha256:XXXXXXXX \\
      --control-plane --certificate-key XXXXXXXXX" \\
fi
