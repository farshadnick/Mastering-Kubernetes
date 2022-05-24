#!/bin/bash
VERSION=3.9.0
wget https://get.helm.sh/helm-v$VERSION-linux-amd64.tar.gz
tar -xzf helm-v$VERSION-linux-amd64.tar.gz
cp ./linux-amd64/helm /usr/local/bin/ && rm -rf ./linux-amd64
