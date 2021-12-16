#!/bin/bash


# cifs 마운트를 위해서는 cifs-utils 패키지 설치가 필요함
# yum install -y cifs-utils

mkdir /mnt/kma_image_upload_share_drive

sudo mount -t cifs //192.168.100.3/kma_image_upload_share_drive /mnt/kma_image_upload_share_drive \
           -o username=selabdev,password='qhdkscjfwj!@'
