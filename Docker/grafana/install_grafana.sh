#!/bin/bash

docker pull grafana/grafana:6.6.0-ubuntu

docker volume create grafana-storage

# 로그 레벨을 debug로 설정
#docker run -d -p 3000:3000 --name grafana -v grafana-storage:/var/lib/grafana \
#  -e TZ=Asia/Seoul \
#  -e "GF_LOG_LEVEL=debug" \
#  grafana/grafana:6.5.0-ubuntu

docker run -d --restart unless-stopped -p 3000:3000 --name grafana \
-v grafana-storage:/var/lib/grafana \
-v /docker_data/grafana/grafana.ini:/etc/grafana/grafana.ini \
-e TZ=Asia/Seoul \
grafana/grafana:8.0.3-ubuntu

