#!/bin/bash

sudo mkdir -p /docker_data/nginx-minio/conf/
sudo mkdir -p /docker_data/nginx-minio/conf/conf.d
sudo mkdir -p /docker_data/nginx-minio/logs/

sudo cp -f ./nginx.conf /docker_data/nginx-minio/conf/nginx.conf
sudo cp -f ./nginx-minio.conf /docker_data/nginx-minio/conf/conf.d/nginx-minio.conf

docker run -d --name nginx-minio \
  -e TZ=Asia/Seoul \
  -v /docker_data/nginx-minio/conf/nginx.conf:/etc/nginx/nginx.conf \
  -v /docker_data/nginx-minio/conf/conf.d:/etc/nginx/conf.d \
  -v /docker_data/nginx-minio/logs:/var/log/nginx \
  nginx:1.19.3
