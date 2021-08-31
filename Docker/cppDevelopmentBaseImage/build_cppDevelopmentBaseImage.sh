#!/bin/bash

docker build . -f Dockerfile_cppDevelopmentBaseImage -t ubuntu1804-cppbuild-baseimage
docker tag ubuntu1804-cppbuild-baseimage 192.168.100.7:5000/ubuntu1804-cppbuild-baseimage
docker push 192.168.100.7:5000/ubuntu1804-cppbuild-baseimage