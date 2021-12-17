#!/bin/bash

docker pull mysql:8.0.18

docker run -d --restart unless-stopped \
  -e TZ=Asia/Seoul \
  --name docker_mysql \
  -p 3306:3306 \
  -v /docker_data/docker_mysql:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=selab mysql:8.0.18

# TODO : 외부 asscess 설정 추가

sudo firewall-cmd --permanent --zone=public --add-port=3306/tcp
sudo firewall-cmd --reload