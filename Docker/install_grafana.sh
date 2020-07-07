docker pull prom/prometheus:v2.19.2

#docker run -p 9090:9090 prom/prometheus

docker run \
    -p 9090:9090 \
    -v /tmp/prometheus.yml:/etc/prometheus/prometheus.yml \
    prom/prometheus

docker pull grafana/grafana:6.5.0-ubuntu

docker run -d -p 3000:3000 --name grafana grafana/grafana:6.5.0-ubuntu