#!/bin/bash

# rook-ceph 를 사용하여 ceph cluster 설치
# 대부분은 rook-ceph의 example yaml 사용
# 상세 설정은 yaml 을 수정하여 설정
# https://rook.io/docs/rook/v1.2/ceph-storage.html

# 준비물
# https://rook.io/docs/rook/v1.8/quickstart.html#prerequisites
# https://rook.io/docs/rook/v1.8/quickstart.html#cluster-environments

# 0. worker node(이하 노드)
    # 최소 3개 이상의 노드
    # 최소 3개 이상의 원시 장치(파티션 또는 포맷된 파일 시스템 없음)
        # lsblk -f  로 확인
# 1. 노드에 lvm 설치
    # sudo apt-get install -y lvm2

# Ceph Cluster 설치
# git clone --single-branch --branch v1.8.1 https://github.com/rook/rook.git
# cd rook/deploy/examples

kubectl apply -f crds.yaml -f common.yaml -f operator.yaml
kubectl apply -f cluster.yaml

# Block Devices
# kubectl apply -f storageclass.yaml

# Shared Filesystem
## cephfs 이름으로 CephFilesystem을 생성
kubectl apply -f filesystem.yaml

# Object Storage
kubectl apply -f object.yaml

# Object Storage User
#kubectl apply -f object-user.yaml

# Ceph Cluster 상태 확인 툴 설치
kubectl -n rook-ceph apply -f toolbox.yaml
# kubectl exec -it -n rook-ceph <pod name> -- bash
# pod 안에서 `ceph status` 명령으로 상태확인 (아래와 같이 상태확인 가능)

#   cluster:
#     id:     9ee0d18b-7dde-4300-948a-e155924b8710
#     health: HEALTH_WARN
#             clock skew detected on mon.c
#
#   services:
#     mon: 3 daemons, quorum a,b,c (age 31m)
#     mgr: a(active, since 30m)
#     mds: 1/1 daemons up, 1 hot standby
#     osd: 3 osds: 3 up (since 25m), 3 in (since 31m)
#     rgw: 1 daemon active (1 hosts, 1 zones)
#
#   data:
#     volumes: 1/1 healthy
#     pools:   10 pools, 145 pgs
#     objects: 229 objects, 11 KiB
#     usage:   23 MiB used, 150 GiB / 150 GiB avail
#     pgs:     145 active+clean
#
#   io:
#     client:   1.2 KiB/s rd, 2 op/s rd, 0 op/s wr


# verify the rook-ceph-operator is in the `Running` state before proceeding
kubectl -n rook-ceph get pod

# Create CephFilesystem StorageClass
kubectl apply -f cephfs-storageclass.yaml

# Create CephBlockStorage StorageClass
kubectl apply -f block-storageclass.yaml
