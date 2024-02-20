#!/bin/bash
# Try to get the genesis hash. Usually first request returns an empty string (port is not open, curl fails), later attempts
# returns "null" if block was not yet produced.
GENESIS=
CNT=0
MAX=30
while [ "${#GENESIS}" -le 4 -a $CNT -ne $MAX ]; do
	GENESIS=$(curl -s http://192.167.0.2:26657/block?height=1 | jq '.result.block_id.hash' | tr -d '"')
	((CNT++))
	sleep 1
done


NODEID=
while [ "${#NODEID}" -le 4 ]; do
  NODEID=$(curl -s http://192.167.0.6:8080/nodeID | jq '.nodeID' | tr -d '"')
  sleep 1
done

# https://docs.celestia.org/nodes/celestia-node-custom-networks
export BRIDGE="/ip4/192.167.0.6/tcp/2121/p2p/$NODEID"
export CELESTIA_CUSTOM=test:$GENESIS:$BRIDGE
echo "$CELESTIA_CUSTOM"


celestia-da light init --node.store /home/celestia/light

#celestia-da full start \
#--node.store /home/celestia/full --gateway --core.ip 192.167.0.2 \
#--keyring.accname my_celes_key --gateway.addr 0.0.0.0 --rpc.addr 0.0.0.0 \
# --da.grpc.namespace 0000d832b53576dd9ef4 --da.grpc.listen "0.0.0.0:26650"

celestia-da light start \
--node.store /home/celestia/light --gateway \
--keyring.accname my_celes_key --gateway.addr 0.0.0.0 --rpc.addr 0.0.0.0 \
--da.grpc.namespace 0000d832b53576dd9ef4  --da.grpc.listen "0.0.0.0:26650"