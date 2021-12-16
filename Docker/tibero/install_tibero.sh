#!/bin/bash

# 이미지 저장소: https://github.com/SELabInc/tibero-docker
# 설치영상 참고: https://store.dimensigon.com/deploy-tibero-with-docker/

GIT_SHA=7b7da55

git clone git@github.com:SELabInc/tibero-docker.git
cd tibero-docker
git reset --hard ${GIT_SHA}

docker build . -t tibero:${GIT_SHA}

docker volume create tibero_db

# tibero 라이센스 파일 발급: https://technet.tmaxsoft.com
# 라이센스 발급시 hostname을 dummy로 신청
# 발급 받은 라이센스 파일은 /docker_data/tibero/license에 복사
docker run --name tibero \
           --privileged=true \
           --hostname dummy \
           -v tibero_db:/home/tibero/tibero6/database \
           -v /docker_data/tibero/license:/home/tibero/tibero6/license \
           -it \
           -p 8629:8629 tibero:${GIT_SHA}
