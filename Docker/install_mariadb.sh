#!/usr/bin/env bash

docker pull mariadb:10.4

docker run -di --name docker_mariadb -p 3306:3306 -v /docker_data/docker_mariadb:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=selab mariadb:10.4

sudo firewall-cmd --permanent --zone=public --add-port=3306/tcp
