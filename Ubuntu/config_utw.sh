#!/bin/bash

sudo ufw default deny
sudo ufw allow ssh
sudo ufw logging on
sudo ufw enable