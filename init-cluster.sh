#!/bin/bash

rm -rf ./da-network

CHAINID="test"
coins="1000000000000000utia"

NODE1_PATH="./da-network/node1"
for ((i = 1; i <= 4; i++))
do
  APP_PATH="./da-network/node$i"
  celestia-appd init $CHAINID --chain-id $CHAINID --home $APP_PATH
  celestia-appd keys add validator$i --keyring-backend="test"  --home $APP_PATH
  cp ./da-network/node$i/keyring-test/* ./da-network/node1/keyring-test/
  celestia-appd add-genesis-account $(celestia-appd keys show validator$i -a --keyring-backend="test" --home $NODE1_PATH) $coins --home $NODE1_PATH

  cp -f ./da-network/node1/config/genesis.json $APP_PATH/config
  celestia-appd gentx validator$i 5000000000utia \
    --keyring-backend="test" \
    --chain-id $CHAINID  --home $APP_PATH

  if test "$i" -eq 1; then
      cp ./da-network/node$i/config/gentx/* ./da-network
  fi

  cp ./da-network/node$i/config/gentx/* ./da-network/node1/config/gentx
done

celestia-appd collect-gentxs --home $NODE1_PATH

for ((i = 1; i <= 4; i++))
do
  APP_PATH="./da-network/node$i"
  cp -f ./da-network/node1/config/genesis.json $APP_PATH/config

  sed -i '' 's/127.0.0.1/0.0.0.0/g' $APP_PATH/config/config.toml
  sed -i '' 's/timeout_commit = "11s"/timeout_commit = "2s"/g' $APP_PATH/config/config.toml

  name=$(jq -r --argjson index "$i" '.app_state.genutil.gen_txs[$index-1].body.memo' $APP_PATH/config/genesis.json)
  echo "$name"
done

# we temp ignore the specific qgb tx

# extract the persist address
directory="./da-network"
files=$(find "$directory" -maxdepth 1 -type f -name 'gentx*')
filename=$(basename "$files")
extracted_string=$(echo "$filename" | cut -d'-' -f2 | cut -d'.' -f1)

# replace the persist peers
for ((i = 2; i <= 4; i++))
do
  APP_PATH="./da-network/node$i"
  sed -i '' "s/persistent_peers = \"\"/persistent_peers = \"$extracted_string@192.167.0.2:26656\"/g" "$APP_PATH/config/config.toml"
done


