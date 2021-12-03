#!/bin/bash
# https://hub.docker.com/r/jupyter/all-spark-notebook

# docker volume create all-spark-notebook

docker run -d --restart unless-stopped --name jupyter \
-e TZ=Asia/Seoul \
-p 50081:8888 \
-v all-spark-notebook:/home/jovyan/work \
-v /data/etri_sensor_data:/home/jovyan/work/etri_sensor_data \
192.168.100.7:5000/jupyter/all-spark-notebook

# docker restart jupyter; docker logs -f jupyter