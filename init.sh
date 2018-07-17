#!/bin/bash

cp node.clean aut_node/node.toml


./chain_init.sh

cd aut_node

parity --config node.toml --force-ui --gasprice=0 --gas-price-percentile=0 --price-update-period="365000 days" --no-persistent-txqueue --jsonrpc-cors='*' --jsonrpc-interface="0.0.0.0" --ui-interface="0.0.0.0" --ws-interface="0.0.0.0" --ws-origins='*' &>parity.log &
parityid=$!

cd ..

./account_init.sh
./keys.sh

kill $parityid

./clean.sh

