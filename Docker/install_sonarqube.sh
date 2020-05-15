#!/bin/bash

sudo sysctl -w vm.max_map_count=262144
sudo sysctl -w fs.file-max=65536
sudo ulimit -n 65536
sudo ulimit -u 4096

docker pull sonarqube:7.9.3-community

docker run -d --restart unless-stopped --name sonarqube -p 9000:9000 sonarqube:7.9.3-community

