#!/bin/bash

echo "qhdkscjfwj\!@" | docker secret create access_key -
echo "qhdkscjfwj\!@bPxRfiCYEXAMPLEKEY" | docker secret create secret_key -

docker node update --label-add minio1=true durian-dev
docker node update --label-add minio2=true docker-desktop
docker node update --label-add minio3=true durian-dev2
docker node update --label-add minio4=true ewrg

wget https://raw.githubusercontent.com/minio/minio/master/docs/orchestration/docker-swarm/docker-compose-secrets.yaml

docker stack deploy --compose-file=docker-compose-secrets.yaml minio_stack