#!/bin/bash

# su계정으로 실행해야
useradd -m -s /bin/bash -G sudo selabdev
usermod -aG wheel selabdev

# copy ssh key
su - selabdev
scp selabdev@192.168.100.2:/.ssh .
scp selabdev@192.168.100.2:~/.ssh/* ~/.ssh

