#! /usr/bin/env bash
NAME=thpark

wget https://github.com/prometheus/prometheus/releases/download/v2.8.1/prometheus-2.8.1.linux-amd64.tar.gz
sudo tar -xvzf prometheus-2.8.1.linux-amd64.tar.gz
sudo mv ./prometheus-2.8.1.linux-amd64 prometheus
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
sudo chown $NAME:$NAME /etc/prometheus
sudo chown $NAME:$NAME /var/lib/prometheus
sudo cp ./prometheus/prometheus /usr/local/bin/
sudo cp ./prometheus/promtool /usr/local/bin/
sudo chown $NAME:$NAME /usr/local/bin/prometheus
sudo chown $NAME:$NAME /usr/local/bin/promtool
sudo cp -r ./prometheus/consoles /etc/prometheus
sudo cp -r ./prometheus/console_libraries /etc/prometheus
sudo chown -R $NAME:$NAME /etc/prometheus/consoles
sudo chown -R $NAME:$NAME /etc/prometheus/console_libraries
#sudo cp ./prometheus/prometheus.yml /etc/prometheus/prometheus.yml

sudo bash -c ' echo "global:
  scrape_interval: 15s
  evaluation_interval: 15s

alerting:
  alertimanagers:
  - static_configs:
    -targets:

rule_files:

scrape_configs:
  - job_name: prometheus_master
  
    static_configs:
        - targets: [localhost:9091]" >> /etc/prometheus/prometheus.yml'


sudo chown -R prometheus:prometheus /etc/prometheus/prometheus.yml
sudo bash -c 'echo "[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=$NAME
Group=$NAME
Type=simple
ExecStart=/usr/local/bin/prometheus \
--config.file=/etc/prometheus/prometheus.yml \
--web.listen-address=:9091 \
--storage.tsdb.path=/var/lib/prometheus/ \
--web.console.templates=/etc/prometheus/consoles \
--web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target" >> /etc/systemd/system/prometheus.service'

echo "Daemon Reload..."
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus
sudo systemctl status prometheus
sudo firewall-cmd --zone=public --add-port=9091/tcp --permanent
sudo systemctl reload firewalld

