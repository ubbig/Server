#!/bin/bash

#sudo apt install -y openjdk-11-jdk
#sudo apt install -y maven gradle

wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-21.2.0/graalvm-ce-java11-linux-amd64-21.2.0.tar.gz
tar -xvzf graalvm-ce-java11-linux-amd64-21.2.0.tar.gz
sudo mv graalvm-ce-java11-21.2.0/ /usr/lib/jvm
cd /usr/lib/jvm
sudo ln -s graalvm-ce-java11-21.2.0 graalvm

#sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/graalvm/bin/java
#sudo update-alternatives --config java

