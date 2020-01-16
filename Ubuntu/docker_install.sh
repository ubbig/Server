#!/usr/bin/env bash

##
## Install docker ce on Ubuntu that version over 14.04
##


# remove old version docker
sudo apt-get -y remove docker docker-engine docker.io
sudo apt -y autoremove


# install dependency packages
sudo apt-get -y update && sudo apt-get -y install \
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
sudo apt-get -y update && sudo apt-cache search docker-ce
# print; docker-ce - Docker: the open-source application container engine

# install docker-ce
sudo apt-get -y update && sudo apt-get -y install docker-ce

# add group to user
sudo usermod -aG docker $USER

