#!/usr/bin/env bash

# shell에서 도커를 빌드해야 하기 때문에 docker설치를 안하고 직접설치함
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key

sudo yum install -y jenkins

sudo systemctl start jenkins
sudo systemctl enable jenkins

sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
sudo firewall-cmd --reload