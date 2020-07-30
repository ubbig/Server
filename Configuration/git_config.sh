#!/bin/bash

# TODO yjkim : 이름, email입력받기

git config --global user.name "$name"
git config --global user.email "$email"
git config --global core.autocrlf true
git config --global color.ui auto
git config --global color.branch auto
git config --global color.status auto
