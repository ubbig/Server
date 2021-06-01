#!/bin/bash
# NOTE: 큐브리드 도커 동작안하기 때문에 아래 스크립트는 무시한다.

docker pull cubrid/cubrid:10.2

docker run -d --restart unless-stopped --memory=4096m \
  -e TZ=Asia/Seoul \
  --name cubrid \
  -p 8001:8001 \
  -v /docker_data/cubrid/data:/var/lib/cubrid \
  -e 'CUBRID_COMPONENTS=SERVER' \
  -e "CUBRID_DB=dbname"
  cubrid/cubrid:10.2


docker run -d --name container-name -e "CUBRID_DB=dbname" cubrid:tag


docker run --memory=4096m \
  -e TZ=Asia/Seoul \
  --name cubrid \
  -e "CUBRID_DB=dbname" \
  -p 8001:8001 -p 33000:33000 -p 30000:30000 \
  cubrid/cubrid:10.2
