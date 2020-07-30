#!/bin/bash

sudo rpm -Uvh https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm
sudo yum install -y dotnet-sdk-3.1
sudo yum install -y dotnet-sdk-2.1
