#!/bin/bash

docker run -dit --restart unless-stopped \
  -e TZ=Asia/Seoul \
  --name redis --cpus=1 \
  -p 6379:6379 \
  redis:5.0.8 redis-server --appendonly yes

firewall-cmd --permanent --zone=public --add-port=6379/tcp
firewall-cmd --reload