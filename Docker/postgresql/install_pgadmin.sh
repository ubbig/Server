#!/bin/bash

docker volume create pgadmin4

docker run -d --restart unless-stopped --name pgadmin \
  -e TZ=Asia/Seoul \
  -p 82:80 \
  -e 'PGADMIN_DEFAULT_EMAIL=selabdev.selab@selab.co.kr' \
  -e 'PGADMIN_DEFAULT_PASSWORD=qhdkscjfwj!@' \
  -v pgadmin4:/var/lib/pgadmin \
  dpage/pgadmin4:4.27
