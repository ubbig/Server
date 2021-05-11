#!/bin/bash

sudo apt install -y python3-pip
sudo apt install -y python3-distutils
sudo apt install -y python3-venv

curl -O https://repo.anaconda.com/archive/Anaconda3-2020.11-Linux-x86_64.sh

source ~/.bashrc

python3 -m venv rwp-env
source rwp-env/bin/activate