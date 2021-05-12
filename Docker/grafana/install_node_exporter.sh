#!/bin/bash

docker pull prom/node-exporter:v0.18.0

docker run -d --name node_exporter --link prometheus:node_exporter -p 9100:9100 prom/node-exporter:v0.18.0