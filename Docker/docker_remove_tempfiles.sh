#!/bin/bash
# docker build시 temp이미지와 컨테이너들이 생성되는 것을 모두 삭제하는 스크립트

#docker system prune -a -f
/dev/null 2> docker rmi $(docker images -f "dangling=true" -q)