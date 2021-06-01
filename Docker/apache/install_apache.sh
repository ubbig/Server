#!/bin/bash

# 설정파일 얻기 위해 임시 컨테이너 생성
docker run -dit --restart unless-stopped --name apache-temp \
  -e TZ=Asia/Seoul \
  -p 8085:80 \
  httpd:2.4

sudo mkdir -p /docker_data/apache/conf

sudo docker cp apache-temp:/usr/local/apache2/conf/ /docker_data/apache/conf

docker rm -f apache-temp





docker run -dit --restart unless-stopped --name my-running-app \
  -e TZ=Asia/Seoul \
  -p 8080:80 \
  -v /docker_data/apache/conf/:/usr/local/apache2/conf/ \
  httpd:2.4

