#!/bin/bash

# https://hub.docker.com/_/postgres
docker pull postgres:13.0

# prometheus exporter를 사용하려면 네트워크 브리지 해줘야 한다.
#docker network create --driver=bridge postgres-net

docker run -i --rm postgres cat /usr/share/postgresql/postgresql.conf.sample > my-postgres.conf

sudo mkdir -p /docker_data/postgresql/config
sudo mv my-postgres.conf /docker_data/postgresql/config

# 	--network postgres-net \
docker run -d --restart unless-stopped --name postgresql -p 5432:5432 \
  -e TZ=Asia/Seoul \
	-v /docker_data/postgresql/data:/var/lib/postgresql/data \
	-v /docker_data/postgresql/config:/etc/postgresql/config \
	-e POSTGRES_USER=selabdev \
	-e POSTGRES_PASSWORD=qhdkscjfwj\!@ \
	postgres:13.0 -c 'config_file=/etc/postgresql/config/my-postgres.conf'


#docker run -d --restart unless-stopped --name prometheus_exporter_pgsql \
#  -e TZ=Asia/Seoul \
#	-p 9187:9187 \
# 	--network postgres-net \
#  -e DATA_SOURCE_NAME="postgresql://selabdev:qhdkscjfwj\!@@192.168.100.4:5432/SensorDB?sslmode=disable" \
#  quay.io/prometheuscommunity/postgres-exporter

#sudo firewall-cmd --permanent --zone=public --add-port=5432/tcp
#sudo firewall-cmd --reload
