#!/bin/bash

## download celestia-app and build docker images
git clone git@github.com:ernest8976/celestia-app.git
cd celestia-app

git checkout ernest/da-chain
docker build . -t ernest/celestia-app:v1.6.0

cd ..
