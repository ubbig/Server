#!/bin/bash

docker pull mariadb:10.4

docker run -d --restart unless-stopped --name docker_mariadb \
  -p 3306:3306 \
  -e TZ=Asia/Seoul \
  -e MYSQL_ROOT_PASSWORD=selab \
  -v /docker_data/docker_mariadb:/var/lib/mysql \
  mariadb:10.4

sudo firewall-cmd --permanent --zone=public --add-port=3306/tcp
sudo firewall-cmd --reload