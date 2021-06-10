#!/bin/bash
# sudo sh install_prometheus.sh 192.168.100.2 /home/geomag/test1' '/home/geomag/test2'



#=============prometheus========================
echo "centos7 or later"


echo "enter you want installation prometheus location : ex) /test/example "
#prometheus_Location="/home/shelltest"
read prometheus_Location
sudo mkdir -p "$prometheus_Location"

sudo bash -c "sudo cat >> $prometheus_Location/prometheus.yml << EOF

# my global config
global:
  scrape_interval:     15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
  # scrape_timeout is set to the global default (10s).

# Alertmanager configuration
alerting:
  alertmanagers:
  - static_configs:
    - targets:
      # - alertmanager:9093

# Load rules once and periodically evaluate them according to the global evaluation_interval.
rule_files:
  # - "first_rules.yml"
  # - "second_rules.yml"

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label job=<job_name> to any timeseries scraped from this config.
  - job_name: 'prometheus'

    # metrics_path defaults to /metrics
     # scheme defaults to http.

    static_configs:
    - targets: ['localhost:9090']
  - job_name: 'node_exporter'
    scrape_interval : 10s
    static_configs:
      - targets: ['localhost:9100']

EOF"


docker pull prom/prometheus:v2.22.2
docker pull prom/node-exporter:v0.18.0
docker pull grafana/grafana:6.5.0-ubuntu


#============= docker run script =======================

docker volume create grafana-storage

docker run -d --restart unless-stopped --name prometheus_node_exporter -p 9100:9100 -e TZ=Asia/Seoul prom/node-exporter:v0.18.0
docker run -d -p 9090:9090 --name prometheus -v $prometheus_Location/prometheus.yml:/etc/prometheus/prometheus.yml -e TZ=Asia/Seoul prom/prometheus:v2.22.2
docker run -d --restart unless-stopped -p 3000:3000 -v grafana-storage:/var/lib/grafana --name grafana -e TZ=Asia/Seoul grafana/grafana:6.6.0-ubuntu