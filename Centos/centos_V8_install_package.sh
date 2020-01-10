#!/usr/bin/env bash

sudo yum groupinstall -y "Server with GUI"

sudo systemctl set-default graphical

sudo dnf isntall -y telnet
