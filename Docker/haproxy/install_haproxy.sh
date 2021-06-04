#!/bin/bash
# https://github.com/prometheus/haproxy_exporter
# ACL설정 - https://sleeplessbeastie.eu/2018/03/26/how-to-block-defined-ip-addresses-on-haproxy/


global
    log 127.0.0.1 local0 notice
    user haproxy
    group haproxy

defaults
    log global
    retries 2
    timeout connect 3000
    timeout server 5000
    timeout client 5000

frontend stats
    bind *:8404
    mode http
    option http-use-htx
    http-request use-service prometheus-exporter if { path /metrics }
    stats enable
    stats uri /stats
    stats refresh 10s

listen pgsql-space
        bind *:5432
        mode tcp
        option pgsql-check user haproxy_check
        balance roundrobin
        server pgsql-1 192.168.100.4:5432 check

docker run -d --restart unless-stopped --name haproxy_pgsql_etri \
-e TZ=Asia/Seoul \
-p 5432:5432 \
-p 5433:5433 \
-p 8404:8404 \
-e TZ=Asia/Seoul \
--hostname haproxy_pgsql_etri \
--sysctl net.ipv4.ip_unprivileged_port_start=0 \
-v /docker_data/haproxy_etri_pgsql:/usr/local/etc/haproxy:ro \
haproxy:2.3