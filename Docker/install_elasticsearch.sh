#!/bin/bash

# 공식 도커 이미지 리스트 : https://www.docker.elastic.co/#

docker pull docker.elastic.co/elasticsearch/elasticsearch:7.7.0
docker pull docker.elastic.co/kibana/kibana:7.7.0
docker pull docker.elastic.co/beats/filebeat:7.7.0
docker pull docker.elastic.co/logstash/logstash:7.7.0

docker run -d --restart unless-stopped --name elasticsearch -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.7.0
docker run -d --restart unless-stopped --name kibana --link elasticsearch:elasticsearch -p 5601:5601 docker.elastic.co/kibana/kibana:7.7.0
#  -e elasticsearch.username=selabdev \
#  -e elasticsearch.password=qhdkscjfwj\!@ \

docker run -dit --restart unless-stopped --name logstash -v /docker_data/logstash/pipeline/:/usr/share/logstash/pipeline/ docker.elastic.co/logstash/logstash:7.7.0

#docker run -d --restart unless-stopped --name filebeat-qi4a \
#  --link elasticsearch:elasticsearch \
#  --link kibana:kibana \
#  --volume="/docker_data/filebeat-qi4a/filebeat.docker.yml:/usr/share/filebeat/filebeat.yml:ro" \
#  --volume="/var/lib/docker/containers:/var/lib/docker/containers:ro" \
#  --volume="/var/run/docker.sock:/var/run/docker.sock:ro" \
#docker.elastic.co/beats/filebeat:7.7.0 -e -strict.perms=false \
#setup -E setup.kibana.host=kibana:5601 \
#-E output.elasticsearch.hosts=elasticsearch:9200

docker run -dit --restart unless-stopped --name filebeat-qi4a \
  --link elasticsearch:elasticsearch --link kibana:kibana --link logstash:logstash \
  --volume="/docker_data/filebeat-qi4a/filebeat.docker.yml:/usr/share/filebeat/filebeat.yml:ro" \
docker.elastic.co/beats/filebeat:7.7.0 -e -strict.perms=false \
setup -E setup.kibana.host=kibana:5601 \
-E output.elasticsearch.hosts=elasticsearch:9200 \
-E output.logstash.hosts=logstash:5044

