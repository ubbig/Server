#!/bin/bash

# kubernetes v1.23
# 최소 사양: 2cpu 2gb, 유일한 hostname
# docker 가 설치되어 있다고 가정하여 진행
# master, worker node 모두 설치

# 방화벽 포트 해제 (master, worker)
# https://kubernetes.io/docs/reference/ports-and-protocols/
K8S_VERSION="1.23.1-00"

sudo ufw allow ssh
sudo ufw allow 6444/tcp  # keepalived
sudo ufw allow 6443/tcp  # apiserver
sudo ufw allow 2379:2380/tcp  # etcd
sudo ufw allow 10250/tcp  # kubelet
sudo ufw allow 10259/tcp  # scheduler
sudo ufw allow 10257/tcp  # controller-manager
sudo ufw allow 30000:32767/tcp  # NodePort services
sudo ufw allow 8080:8081/tcp # ceph
sudo ufw allow 9283/tcp # ceph
sudo ufw allow 8443/tcp # ceph
sudo ufw allow 6789/tcp # ceph
sudo ufw allow 3300/tcp # ceph
sudo ufw allow 7946/tcp # MetalLB
sudo ufw --force enable


# swap disable
sudo swapoff -a && sudo sed -i '/swap/s/^/#/' /etc/fstab

# Letting iptables see bridged traffic 
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system

# Installing kubeadm, kubelet and kubectl

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl

sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubelet=${K8S_VERSION} kubeadm=${K8S_VERSION} kubectl=${K8S_VERSION}
sudo apt-mark hold kubelet kubeadm kubectl


# kubeadm init trouble shooting
# 오류내용: [kubelet-check] It seems like the kubelet isn't running or healthy.
# https://stackoverflow.com/a/68722458/11537591

cat <<EOF | sudo tee /etc/docker/daemon.json
{
    "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF

sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl restart kubelet

echo "source <(kubectl completion bash)" >> ~/.bashrc
echo "source <(kubeadm completion bash)" >> ~/.bashrc

# for Ceph
sudo apt-get install -y lvm2

# for IPVS (MetalLB)
sudo apt-get install -y ipvsadm

# Install Helm binary
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh