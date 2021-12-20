#!/bin/sh

# 방화벽
# https://kubernetes.io/docs/reference/ports-and-protocols/

## worker node
sudo ufw enable
sudo ufw allow 10250/tcp
sudo ufw allow 30000:32767/tcp
