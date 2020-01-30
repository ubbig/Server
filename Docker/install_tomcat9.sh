#!/usr/bin/env bash

docker pull tomcat:9.0-jdk11-adoptopenjdk-hotspot

docker run -dit --name tomcat9 -p 8080:8080 tomcat:9.0-jdk11-adoptopenjdk-hotspot