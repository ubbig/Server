#!/bin/bash

if [ -z "$1"]
  then
    echo 'USAGE: ./install_kubeadm.sh <MasterNode IP addr>'
    exit 0
else
    hostname=$1
fi

sudo mv /etc/hostname /etc/hostname.bak
sudo /etc/hostname << $hostname

sudo /etc/hosts << 127.0.0.1 $1

