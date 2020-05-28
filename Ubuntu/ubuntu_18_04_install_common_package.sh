#!/usr/bin/env bash

sudo apt update -y
sudo apt upgrade -y

sudo apt install -y openssh-server
#sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
#sudo sed -i 's/prohibit\-password/yes/' /etc/ssh/sshd_config
#sudo service sshd restart

sudo apt install -y net-tools
sudo apt install -y vim curl wget
sudo apt install -y htop sysstat
sudo apt install -y subversion git
sudo apt install -y sshpass
sudo apt install -y unzip
sudo apt install -y ntp
sudo systemctl enable ntp

sudo bash -c "sudo cat >> /etc/sysctl.conf << EOF
fs.file-max = 65535
fs.inotify.max_user_watches=524288
EOF"

sudo sysctl -w fs.file-max=65535
sudo sysctl -w fs.inotify.max_user_watches=524288

sudo bash -c "sudo cat >> /etc/security/limits.conf << EOF
*          hard    core            unlimited
*          soft    core            unlimited
*          soft     nproc          65535
*          hard     nproc          65535
*          soft     nofile         65535
*          hard     nofile         65535
EOF"

git config --global user.name "selabdev"
git config --global user.email selabdev.selab@gmail.com

sudo apt autoremove -y


