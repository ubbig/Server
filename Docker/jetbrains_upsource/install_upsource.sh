#!/bin/bash

sudo mkdir /docker/jetbrains_upsource
cd /docker/jetbrains_upsource
mkdir -p -m 750 data config logs backups
sudo chown -R 13001:13001 data config logs backups

# 8080외에 포트로 연결하는 것 테스트 실패함
docker run -dit --restart unless-stopped --name jetbrains_upsource \
-e TZ=Asia/Seoul \
-v /docker/jetbrains_upsource/data:/opt/upsource/data \
-v /docker/jetbrains_upsource/config:/opt/upsource/conf \
-v /docker/jetbrains_upsource/logs:/opt/upsource/logs \
-v /docker/jetbrains_upsource/backups:/opt/upsource/backups \
-p 8080:8080 \
jetbrains/upsource:2020.1.1956

