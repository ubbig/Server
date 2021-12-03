#!/bin/bash

sudo mkdir -p /docker_data/minio/data

docker pull minio/minio:RELEASE.2021-10-08T23-58-24Z

docker volume create minio-volume

docker run -d --restart unless-stopped -p 9000:9000 -p 9001:9001 \
  --name minio-server
  -e TZ=Asia/Seoul \
  -e MINIO_PROMETHEUS_AUTH_TYPE=public
  -e MINIO_ROOT_USER={ACCOUNT} \
  -e MINIO_ROOT_PASSWORD={PASSWORD} \
  -v minio-volume:/data  \
  minio/minio:RELEASE.2021-10-08T23-58-24Z server /data --console-address ":9001"
