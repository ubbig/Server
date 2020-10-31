#!/bin/bash
# https://hub.docker.com/_/cassandra

docker run --name cassandra-dev1 -d \
  -p 7000-7001:7000-7001 -p 7199:7199 -p 9042:9042 -p 9160:9160 -p 9142:9142 \
  -v /docker_data/cassandra/datadir:/var/lib/cassandra \
  -e CASSANDRA_CLUSTER_NAME=testcluster \
  -e CASSANDRA_BROADCAST_ADDRESS=192.168.1.165 \
  -e CASSANDRA_SEEDS=192.168.1.165,192.168.1.166,,192.168.1.167 \
  cassandra:3.11.8

docker run --name cassandra-dev2 -d \
  -p 7000-7001:7000-7001 -p 7199:7199 -p 9042:9042 -p 9160:9160 -p 9142:9142 \
  -v /docker_data/cassandra/datadir:/var/lib/cassandra \
  -e CASSANDRA_CLUSTER_NAME=testcluster \
  -e CASSANDRA_BROADCAST_ADDRESS=192.168.1.166 \
  -e CASSANDRA_SEEDS=192.168.1.165,192.168.1.166,,192.168.1.167 \
  cassandra:3.11.8

docker run --name cassandra-dev3 -d \
  -p 7000-7001:7000-7001 -p 7199:7199 -p 9042:9042 -p 9160:9160 -p 9142:9142 \
  -v /docker_data/cassandra/datadir:/var/lib/cassandra \
  -e CASSANDRA_CLUSTER_NAME=testcluster \
  -e CASSANDRA_BROADCAST_ADDRESS=192.168.1.167 \
  -e CASSANDRA_SEEDS=192.168.1.165,192.168.1.166,,192.168.1.167 \
  cassandra:3.11.8

# cqsql 실행
# docker run -it --rm cassandra cqlsh cassandra-dev1