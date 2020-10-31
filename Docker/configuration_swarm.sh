#!/bin/bash

# swarm master 노드에서 실행
docker swarm init --advertise-addr 192.168.100.2

# 나머지 node들에서 실행하여 swarm 클러스터에 가입
docker swarm join --token SWMTKN-1-1wbgvcuc05rqwv96g94bows3t00htd50s4aqaczeq0ga0zbbsr-0cw9hpy1s68meubhlaqnva83r 192.168.100.2:2377

# 노드 목록 조회(스웜명령어는 마스터에서 사용)
docker node ls
