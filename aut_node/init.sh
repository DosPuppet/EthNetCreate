#!/bin/bash

cp node.clean node.toml


./chain_init.sh
parity --config node.toml --force-ui --gasprice=0 --gas-price-percentile=0 --price-update-period="365000 days" --no-persistent-txqueue --jsonrpc-cors='*' --jsonrpc-interface="0.0.0.0" --ui-interface="0.0.0.0" --ws-interface="0.0.0.0" --ws-origins='*' &>parity.log &
parityid=$!
./account_init.sh
./keys.sh

kill $parityid

./clean.sh

