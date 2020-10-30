#!/bin/bash

sudo apt install -y software-properties-common
curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | sudo bash
curl -O https://downloads.mariadb.com/MariaDB/mariadb_repo_setup
sudo apt update -y
sudo apt install -y mariadb-client-core-10.5
