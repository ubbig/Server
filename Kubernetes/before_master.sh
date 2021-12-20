#!/bin/sh

# 방화벽
# https://kubernetes.io/docs/reference/ports-and-protocols/

## control plane
sudo ufw enable
sudo ufw allow 6443/tcp 
sudo ufw allow 2379:2380/tcp
sudo ufw allow 10250/tcp
sudo ufw allow 10259/tcp
sudo ufw allow 10257/tcp
