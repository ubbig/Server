#!/bin/bash

sudo sysctl -w vm.max_map_count=262144  # linux vm memory limit
sudo sysctl -w fs.file-max=65536  # max file descriptor
sudo ulimit -n 65536  # open file descriptor
sudo ulimit -u 4096   # user process count limit

docker pull sonarqube:7.9.3-community

docker run -d --restart unless-stopped --name sonarqube -p 19000:9000 sonarqube:7.9.3-community




