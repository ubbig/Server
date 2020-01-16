#!/usr/bin/env bash

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
