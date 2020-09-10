#!/bin/bash
# sudo sh install_prometheus.sh 192.168.100.2 '/docker_data/prometheus'

if [ "$#" -ne 2 ]; then
    echo 'USAGE: ./install_prometheus.sh <MasterNode IP addr> <configuration_file_path>'
    exit 0
else
    master_ip_addr=$1
    configuration_file_path=$2
fi

#docker pull prom/prometheus:v2.19.2

sudo mkdir -p $configuration_file_path

sudo bash -c "sudo cat >> $configuration_file_path/prometheus.yml << EOF

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

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  # - \"first_rules.yml\"
  # - \"second_rules.yml\"

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label \"job=<job_name>\" to any timeseries scraped from this config.
  - job_name: 'prometheus'

    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.

    static_configs:
    - targets: ['$master_ip_addr:9090']

EOF"

docker run -d \
    -p 9090:9090 \
    --name prometheus \
    -v /docker_data/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml \
    prom/prometheus
