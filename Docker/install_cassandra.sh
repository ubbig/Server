#!/bin/bash


docker run --name cassandra-dev1 -d \
  -p 7000:7000 \
  -v /docker_data/cassandra/datadir:/var/lib/cassandra \
  -e CASSANDRA_CLUSTER_NAME=testcluster \
  -e CASSANDRA_BROADCAST_ADDRESS=192.168.1.165 \
  cassandra:3.11.8


docker run --name cassandra-dev2 -d \
  -p 7000:7000 \
  -v /docker_data/cassandra/datadir:/var/lib/cassandra \
  -e CASSANDRA_CLUSTER_NAME=testcluster \
  -e CASSANDRA_BROADCAST_ADDRESS=192.168.1.166 \
  -e CASSANDRA_SEEDS=192.168.1.165 \
  cassandra:3.11.8


docker run --name cassandra-dev3 -d \
  -p 7000:7000 \
  -v /docker_data/cassandra/datadir:/var/lib/cassandra \
  -e CASSANDRA_CLUSTER_NAME=testcluster \
  -e CASSANDRA_BROADCAST_ADDRESS=192.168.1.167 \
  -e CASSANDRA_SEEDS=192.168.1.165,192.168.1.166 \
  cassandra:3.11.8
