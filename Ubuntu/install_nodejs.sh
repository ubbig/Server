#!/bin/bash

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.35.3/install.sh | bash
source ~/.profile

#nvm ls-remote

# last LTS version
nvm install 12.16.2


# yarn package manager
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install yarn -y