#!/bin/bash

# open file limits
sudo bash -c "sudo cat >> /etc/sysctl.conf << EOF
fs.file-max = 65535
fs.inotify.max_user_watches=524288
EOF"

sudo sysctl -w fs.file-max=65535
sudo sysctl -w fs.inotify.max_user_watches=524288

sudo bash -c "sudo cat >> /etc/security/limits.conf << EOF
*          hard    core            unlimited
*          soft     nproc          65535
*          hard     nproc          65535
*          soft     nofile         65535
*          hard     nofile         65535
EOF"

# x window
sudo yum groupinstall -y "Server with GUI"
sudo systemctl set-default graphical
sudo yum install -y telnet

sudo yum install -y xrdp

# monitoring
sudo yum install -y epel-release
sudo yum update -y
sudo yum install -y htop sysstat

# development
sudo yum install -y git svn
sudo yum install -y java-1.8.0-openjdk-demo.x86_64 java-11-openjdk-demo.x86_64

sudo yum install -y ntp
sudo systemctl enable ntp
#if No such file or directory
# ntp -> ntpd
sudo systemctl restart ntp
