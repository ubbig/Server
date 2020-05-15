#!/bin/bash

# su계정으로 실행해야
useradd -m -s /bin/bash -G sudo selabdev
usermod -aG wheel selabdev

# copy ssh key
su - selabdev
scp selabdev@203.236.196.189:/.ssh .
scp selabdev@203.236.196.189:~/.ssh/* ~/.ssh

