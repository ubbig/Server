#!/bin/bash
# https://hub.docker.com/r/ngrinder/controller/

docker pull ngrinder/controller:3.5.5-p1
docker pull ngrinder/agent:3.5.5-p1

docker run -d --restart unless-stopped --name ngrinder-controller \
    -e TZ=Asia/Seoul \
    -v /docker_data/ngrinder-controller:/opt/ngrinder-controller \
    -p 80:80 -p 16001:16001 -p 12000-12029:12000-12029 -p 9010-9019 \
    ngrinder/controller:3.5.5-p1

docker run -d --restart unless-stopped --name ngrinder-agent \
  -e TZ=Asia/Seoul \
  --link ngrinder-controller:controller \
  ngrinder/agent:3.5.5-p1