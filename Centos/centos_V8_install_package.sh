#!/usr/bin/env bash

# open file limits
bash -c "sudo cat >> /etc/sysctl.conf << EOF
fs.file-max = 65535
fs.inotify.max_user_watches=524288
EOF"

sysctl -w fs.file-max=65535
sysctl -w fs.inotify.max_user_watches=524288

bash -c "sudo cat >> /etc/security/limits.conf << EOF
*          hard    core            unlimited
*          soft     nproc          65535
*          hard     nproc          65535
*          soft     nofile         65535
*          hard     nofile         65535
EOF"

# x window
sudo yum groupinstall -y "Server with GUI"
sudo systemctl set-default graphical
sudo dnf install -y telnet

sudo dnf install -y xrdp

# monitoring
sudo dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
sudo dnf update -y
sudo dnf install -y htop sysstat

# development
sudo dnf install -y git svn
sudo dnf install -y java-1.8.0-openjdk-demo.x86_64 java-11-openjdk-demo.x86_64

# ntp가 centos8에서 chrony로 변경됨
sudo dnf install -y chrony
sudo systemctl enable chronyd
sudo systemctl restart chronyd