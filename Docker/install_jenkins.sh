#!/usr/bin/env bash

# https://github.com/jenkinsci/docker/blob/master/README.md 참고

docker pull jenkins/jenkins:lts

docker run -d -v /docker_data/jenkins:/var/jenkins_home -p 8080:8080 -p 50000:50000 --name jenkins-master jenkins/jenkins:lts

sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
sudo firewall-cmd --permanent --zone=public --add-port=50000/tcp
sudo firewall-cmd --reload
