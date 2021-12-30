#!/bin/bash

sudo kubeadm reset -f
sudo apt-get purge -y kubeadm kubectl kubelet kubernetes-cni kube*   
sudo apt-get autoremove -y
sudo rm -rf ~/.kube

