#!/bin/bash
# https://hub.docker.com/_/influxdb

docker volume create influxdb

# TODO yjkim : 설정파일 연결 추가할 것
docker run -p 8086:8086 \
  -e TZ=Asia/Seoul \
  -v influxdb:/var/lib/influxdb \
  -e DOCKER_INFLUXDB_INIT_USERNAME=selabdev \
  -e DOCKER_INFLUXDB_INIT_PASSWORD='${_selabdev_password}' \
  -e DOCKER_INFLUXDB_INIT_ORG=selab \
  -e DOCKER_INFLUXDB_INIT_BUCKET=test-bucket \
  influxdb:2.0.7
