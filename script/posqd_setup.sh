#!/bin/bash
# Download latest node and install.
posqlink=`curl -s https://api.github.com/repos/sicXnull/POSQ/releases/latest | grep browser_download_url | grep linux64 | cut -d '"' -f 4`
mkdir -p /tmp/posq
cd /tmp/posq
curl -Lo posq.tar.gz $posqlink
tar -xzf posq.tar.gz
sudo mv ./bin/* /usr/local/bin
cd
rm -rf /tmp/posq
mkdir ~/.posq

# Setup configuration for node.
rpcuser=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 13 ; echo '')
rpcpassword=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 ; echo '')
cat >~/.posq/posq.conf <<EOL
rpcuser=$rpcuser
rpcpassword=$rpcpassword
daemon=1
txindex=1
EOL

# Start node.
posqd
