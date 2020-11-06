#!/bin/bash

# v1.15.3
wget https://golang.org/dl/go1.15.3.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.15.3.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
