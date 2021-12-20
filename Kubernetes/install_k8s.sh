#!/bin/sh

# kubernetes v1.23

# 최소 사양: 2cpu 2gb, 유일한 hostname

# docker 가 설치되어 있다고 가정하여 진행

# master, worker node 모두 설치하는 스크립트


# swap disable
sudo swapoff -a && sed -i '/swap/s/^/#/' /etc/fstab

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
sudo apt-get install -y kubelet kubeadm kubectl
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


source <(kubectl completion bash) # setup autocomplete in bash into the current shell, bash-completion package should be installed first.
source <(kubeadm completion bash)
echo "source <(kubectl completion bash)" >> ~/.bashrc # add autocomplete permanently to your bash shell.
echo "source <(kubeadm completion bash)" >> ~/.bashrc # add autocomplete permanently to your bash shell.


# 설치 이후에..
# 0) ssh-key 설정(masters, workers)


# 1) master node에 kubeadm init 수행
# sudo kubeadm init


# 2) master node에 CNI 설치
## Installing a Pod network add-on
## Calico Networks: https://projectcalico.docs.tigera.io/getting-started/kubernetes/self-managed-onprem/onpremises
# curl https://docs.projectcalico.org/manifests/calico.yaml -O
# kubectl apply -f calico.yaml


# 3) Join worker node


# 4) HA 구성
# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/
