#!/bin/bash

# root계정
yum clean all
wget https://get.docker.com/rpm/1.7.1/centos-6/RPMS/x86_64/docker-engine-1.7.1-1.el6.x86_64.rpm
yum install -y docker-engine-1.7.1-1.el6.x86_64.rpm
service docker restart