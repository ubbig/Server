#!/bin/bash
# note: swarm클러스터가 구성되어 있어야 한다.

# 추후 로그인시 사용하는 key
echo "AKIAIOSFODNN7EXAMPLE" | docker secret create access_key -
echo "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY" | docker secret create secret_key -

# 설치하려는 docker node 이름을 입력 : data-archive-2
docker node update --label-add minio1=true data-archive-2
docker node update --label-add minio2=true data-archive-2
docker node update --label-add minio3=true data-archive-2
docker node update --label-add minio4=true data-archive-2

docker stack deploy --compose-file=docker-swarm-etri.yaml minio_stack