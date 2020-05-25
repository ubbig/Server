#!/bin/bash
# 도커는 이미 설치되어 있다고 가정함

if [ -z "$1"]
  then
    echo 'USAGE: ./install_kubeadm.sh <MasterNode IP addr>'
    exit 0
else
    master_ip_addr=$1
fi

# kubeadm 설치안내 : https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/
# 권장사양 : 2cpu, ram 2GB이상

# 중요: 노드에서 swap 파티션을 종료해야 클러스터가 정상동작한다.
sudo swapoff -a
sudo sed -e '/swap/ s/^#*/#/' -i /etc/fstab

# docker daemon Cgroup 드라이버 설정 - 참고 : https://kubernetes.io/docs/setup/production-environment/container-runtimes/
sudo cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker



# Letting iptables see bridged traffic
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables=1
net.bridge.bridge-nf-call-iptables=1
EOF
sudo sysctl --system


# install
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt -y update
sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
sudo systemctl daemon-reload
sudo systemctl restart kubelet


# 클러스터에 노드 추가
sudo kubeadm init --apiserver-advertise-address=$master_ip_addr
# 멀티 마스터 설정 옵션
# sudo kubeadm init --apiserver-advertise-address=192.168.1.180 --control-plane-endpoint


mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
cat ~/.kube/config

# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/
# 인증서 이슈
# master node failover 테스트
  # api LB적용
# worker node failover  테스트
# 리부팅하면 자동 연결되야 함

# (ELK) 로그 중앙화 되지 않으면 로그파일이 남지 않는다.
# (grfana or zabbix) 모니터링
#

# UI를 구성해서 이미지 업로드, 서버 생성, 구성하는 화면을 구현해야함
# 과금 구현