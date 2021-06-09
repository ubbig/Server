#!/bin/bash
# https://github.com/prometheus/haproxy_exporter

docker run -d --restart unless-stopped --name haproxy_pgsql_etri \
-e TZ=Asia/Seoul \
-p 20:20 -p 21:21 -p 21100-21110:21100-21110 \
-p 5432:5432 \
-p 5433:5433 \
-p 8404:8404 \
-e TZ=Asia/Seoul \
--hostname haproxy_pgsql_etri \
--sysctl net.ipv4.ip_unprivileged_port_start=0 \
-v /docker_data/haproxy_etri_pgsql:/usr/local/etc/haproxy:ro \
haproxy:2.3