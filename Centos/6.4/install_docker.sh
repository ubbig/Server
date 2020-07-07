#!/bin/bash

# root계정
yum clean all
wget https://get.docker.com/rpm/1.7.1/centos-6/RPMS/x86_64/docker-engine-1.7.1-1.el6.x86_64.rpm
yum install -y docker-engine-1.7.1-1.el6.x86_64.rpm
service docker restart


systemctl start docker
systemctl enable docker

groupadd docker
# 지자기 실행 계정
usermod -aG docker mod_oper
newgrp docker

# 지자기 서버 설치
docker pull mariadb:10.0
docker run -d --name docker_mariadb -p 3307:3306 -v /home/geomag/mariadb-data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=GM1q2w3e4r% mariadb:10.0