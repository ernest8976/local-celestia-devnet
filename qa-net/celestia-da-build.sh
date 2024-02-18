#!/bin/bash

## download celestia-da and build docker image
git clone git@github.com:ernest8976/celestia-da.git
cd celestia-da

git checkout ernest/da-chain
docker build . -t ernest/celestia-da:v0.12.9

cd ..
