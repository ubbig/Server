#NAME=thpark

wget https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz
sudo tar -xvzf node_exporter-0.18.1.linux-amd64.tar.gz
sudo mv ./node_exporter-0.18.1.linux-amd64 node_exporter
sudo cp ./node_exporter/node_exporter /usr/local/bin/node_exporter
sudo rm -rf /etc/systemd/system/node_exporter.service

sudo bash -c ' echo "[Unit]
Description=Node Exporter
After=network.target

[Service]
User=thpark
Grop=thpark
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target" >> /etc/systemd/system/node_exporter.service'

sudo bash -c ' echo "
  - job_name: node_exporter 
    static_configs:
        - targets: [localhost:9100]" >> /etc/prometheus/prometheus.yml'

sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter
sudo systemctl status node_exporter
