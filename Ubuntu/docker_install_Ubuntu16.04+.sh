#!/usr/bin/env bash

##
## Docker 인스톨
## Ubuntu 16.04 이상 버전에서 설치
## 16.04 또는 18.04
## 

# remove old version docker
sudo apt -y remove docker docker-engine docker.io
sudo apt -y autoremove


# install dependency packages
sudo apt -y update && sudo apt -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common


# add docker repository
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
     $(lsb_release -cs) \
     stable"

# search docker at repository
sudo apt -y update && sudo apt-cache search docker-ce
# print; docker-ce - Docker: the open-source application container engine

# install docker-ce
sudo apt -y update && sudo apt -y install docker-ce

# add group to user
sudo usermod -aG docker $USER

sudo chmod 666 /var/run/docker.sock

sudo systemctl restart docker

