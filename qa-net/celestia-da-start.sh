#!/bin/bash

celestia-da bridge init --node.store /home/celestia/bridge

celestia-da bridge start \
--node.store /home/celestia/bridge --gateway --core.ip 192.167.0.2 \
--keyring.accname validator --gateway.addr 0.0.0.0 --rpc.addr 0.0.0.0 \
--da.grpc.namespace 0000d832b53576dd9ef4 --da.grpc.listen "0.0.0.0:26650"
