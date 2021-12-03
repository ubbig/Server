#!/bin/bash

docker volume create sftpgo_data
docker volume create sftpgo_home

docker run -d --restart unless-stopped \
    --name sftpgo \
    -e TZ=Asia/Seoul \
    -e SFTPGO_HTTPD__BINDINGS__0__PORT=8000 \
    -p 8000:8000 \
    -p 2022:2022 \
    -v sftpgo_data:/srv/sftpgo \
    -v sftpgo_home:/var/lib/sftpgo \
    drakkan/sftpgo:latest


-- nfs볼륨 생성은 좀더 테스트 해봐야 함

#docker volume create --driver local \
#    --opt type=nfs \
#    --opt o=addr=192.168.100.40,rw \
#    --opt device=:/volume1/ServerSharedDrive/docker_data/sftpgo/data \
#    sftpgo_data
#
#docker volume create --driver local \
#    --opt type=nfs \
#    --opt o=addr=192.168.100.40,rw \
#    --opt device=:/volume1/ServerSharedDrive/docker_data/sftpgo/home \
#    sftpgo_home

#docker service create --name sftpgo \
#    --constraint node.hostname==gitlab  \
#    --network sftpgo \
#    -e TZ=Asia/Seoul \
#    -e SFTPGO_HTTPD__BINDINGS__0__PORT=8000 \
#    -p 8000:8000 \
#    -p 2022:2022 \
#    --mount 'type=volume,src=sftpgo_data,dst=/srv/sftpgo' \
#    --mount 'type=volume,src=sftpgo_home,dst=/var/lib/sftpgo' \
#    drakkan/sftpgo:latest
#
#    --publish published=8000,target=8000  \
#    --publish published=2022,target=2022  \
