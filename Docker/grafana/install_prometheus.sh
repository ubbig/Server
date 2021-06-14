#!/bin/bash
# sudo sh install_prometheus.sh 192.168.1.101 '/docker_data/prometheus'
#docker pull prom/prometheus:v2.22.2

if [ "$#" -ne 2 ]; then
    echo 'USAGE: ./install_prometheus.sh <MasterNode IP addr> <configuration_file_path>'
    exit 0
else
    master_ip_addr=$1
    configuration_file_path=$2
fi

sudo mkdir -p $configuration_file_path

docker run -d \
    -p 9090:9090 \
    --name prometheus_temp \
    -e TZ=Asia/Seoul \
    prom/prometheus:v2.22.2

docker cp prometheus_temp:/etc/prometheus/prometheus.yml .
sed -i s/localhost:9090/$master_ip_addr:9090/ prometheus.yml
sudo mv prometheus.yml $configuration_file_path/prometheus.yml
docker rm -f prometheus_temp

docker run -d --restart unless-stopped --name prometheus \
    -e TZ=Asia/Seoul \
    -p 9090:9090 \
    -v $configuration_file_path/prometheus.yml:/etc/prometheus/prometheus.yml \
    prom/prometheus:v2.22.2
