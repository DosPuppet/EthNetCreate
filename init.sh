#!/bin/bash

export autpath="$(echo "$(pwd)")"/aut_node
export scriptpath="$(echo "$(pwd)")"/scripts
mkdir $autpath

cp $scriptpath/node.clean $autpath/node.toml
cp $scriptpath/conf.sh $autpath/
cp $scriptpath/start_node.sh $autpath/
cp $scriptpath/node.pwds $autpath/

$scriptpath/chain_init.sh

cd $autpath

parity --config node.toml --force-ui --gasprice=0 --gas-price-percentile=0 --price-update-period="365000 days" --no-persistent-txqueue --jsonrpc-cors='*' --jsonrpc-interface="0.0.0.0" --ui-interface="0.0.0.0" --ws-interface="0.0.0.0" --ws-origins='*' &>parity.log &
parityid=$!

$scriptpath/account_init.sh
#$scriptpath/keys.sh

kill $parityid

$scriptpath/clean.sh

