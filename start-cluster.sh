#!/bin/bash
rm -rf da-network
cp -r da-network-bak da-network
docker-compose up -d