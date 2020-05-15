#!/bin/bash

# 공식 도커 이미지 리스트 : https://www.docker.elastic.co/#

docker pull docker.elastic.co/elasticsearch/elasticsearch:7.7.0
docker pull docker.elastic.co/kibana/kibana:7.7.0
docker pull docker.elastic.co/beats/auditbeat:7.7.0

docker run -d --restart unless-stopped --name elasticsearch -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.7.0
docker run -d --restart unless-stopped --name kibana --link elasticsearch:elasticsearch -p 5601:5601 docker.elastic.co/kibana/kibana:7.7.0
#  -e elasticsearch.username=selabdev \
#  -e elasticsearch.password=qhdkscjfwj\!@ \


