#!/bin/bash

is_ubuntu=false

if [ -f /etc/lsb-release ]; then
  is_ubuntu=true
fi

if [ "$is_ubuntu" = true ]; then
  sudo apt update
  sudo apt install -y software-properties-common
  sudo apt-add-repository --yes --update ppa:ansible/ansible
  sudo apt install -y ansible
else
  sudo yum install -y epel-release
  sudo yum install -y ansible
fi

# 인증서 복사

sudo bash -c "sudo cat >> /etc/ansible/hosts << EOF
192.168.100.2
EOF"
