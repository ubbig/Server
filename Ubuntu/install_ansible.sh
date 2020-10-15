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

# knownhost추가
# ~/hosts 파일에 호스트 추가


