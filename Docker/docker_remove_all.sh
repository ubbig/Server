#!/bin/bash
# 모든 이미지 삭제
#docker rmi $(docker images -q)

docker stop $(docker ps -a -q)
docker rm -f $(docker ps -a -q)