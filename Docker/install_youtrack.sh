#!/bin/bash

docker pull jetbrains/youtrack:2020.2.6881

docker run -dit --restart unless-stopped --name youtrack \
  -v /docker_data/youtrack/data:/opt/youtrack/data \
  -v /docker_data/youtrack/conf:/opt/youtrack/conf \
  -v /docker_data/youtrack/logs:/opt/youtrack/logs \
  -v /docker_data/youtrack/backups:/opt/youtrack/backups \
  -p 18080:8080 \
  jetbrains/youtrack:2020.2.6881

# docker run -dit --restart unless-stopped --name youtrack -v c:\docker_data\youtrack\data:/opt/youtrack/data   -v c:\docker_data\youtrack\conf:/opt/youtrack/conf   -v c:\docker_data\youtrack\logs:/opt/youtrack/logs   -v c:\docker_data\youtrack\backups:/opt/youtrack/backups   -p 18081:8080  jetbrains/youtrack:2020.2.6881