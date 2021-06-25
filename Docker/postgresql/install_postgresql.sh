#!/bin/bash

# https://hub.docker.com/_/postgres
# 튜닝파라메터 설정 - https://wiki.postgresql.org/wiki/Tuning_Your_PostgreSQL_Server

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
	postgres:13.0 \
	-c 'config_file=/etc/postgresql/config/my-postgres.conf' \
  -c shared_buffers=10240MB \
  -c max_connections=2096 \
  -c wal_buffers=512MB \
  -c effective_cache_size=20480MB


#docker run -d --restart unless-stopped --name prometheus_exporter_pgsql \
#  -e TZ=Asia/Seoul \
#	-p 9187:9187 \
# 	--network postgres-net \
#  -e DATA_SOURCE_NAME="postgresql://selabdev:qhdkscjfwj\!@@192.168.100.4:5432/SensorDB?sslmode=disable" \
#  quay.io/prometheuscommunity/postgres-exporter

#pgbench --host=192.168.100.2 --username=selabdev --client=100 --jobs=7 --log --time=30 SensorDB
