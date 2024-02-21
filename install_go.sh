#!/usr/bin/bash
set -e
set -x

mkdir -p $HOME/local/src
pushd $HOME/local/src
curl -L -O https://go.dev/dl/go1.22.0.linux-amd64.tar.gz

sudo rm -rf /usr/local/go 
sudo tar -C /usr/local -xzf go1.22.0.linux-amd64.tar.gz
popd

echo "export PATH=$PATH:/usr/local/go/bin"
