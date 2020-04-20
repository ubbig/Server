#!/usr/bin/env bash

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.35.3/install.sh | bash
source ~/.profile

#nvm ls-remote

# last LTS version
nvm install 12.16.2
