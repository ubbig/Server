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


# nas에 설치한 버전
#docker run -d --restart unless-stopped -p 9000:9000 -p 9001:9001 \
#  --name minio-server \
#  -e TZ=Asia/Seoul \
#  -e MINIO_PROMETHEUS_AUTH_TYPE=public \
#  -e MINIO_ROOT_USER=selabdev \
#  -e MINIO_ROOT_PASSWORD=qhdkscjfwj\!@ \
#  -v /volume1/ServerSharedDrive/minio_data:/data \
#  --network=c235dca734a6 \
#  minio/minio:RELEASE.2021-11-24T23-19-33Z server /data --console-address ":9001"

# volume 연결 안됨, 개발도 중단되고, k8s나 스웜에서 공식지원되지 않음
#docker volume create -d minio/minfs \
#--name bucket-test \
#-o endpoint=http://192.168.100.40:9000 \
#-o access-key=8PMXRRJUARYIJ6G8HZ6D \
#-o secret-key=t0EepS54Xgcbj4QePWx3Z+HKRq0LWXJrdaEK3gfa \
#-o bucket=test
#
#docker volume ls