#!/bin/bash

sudo apt update
sudo apt install -y software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible

# knownhost추가
# ~/hosts 파일에 호스트 추가