#!/bin/bash

read -p "indiquez le port de synchronisation (default 30300): " syncport
[[ -z "$syncport" ]] && syncport=30300
read -p "indiquer le port RPC (default 8545): " rpcport
[[ -z "$rpcport" ]] && rpcport=8545
read -p "indiquez le port du client parity (default 8180): " parityport
[[ -z "$parityport" ]] && parityport=8180
read -p "indiquez le port du websocket parity (default 8450): " socketport
[[ -z "$socketport" ]] && socketport=8450


sed -i -e "s/port = 30300/port = $syncport/g" node.toml
sed -i -e "s/port = 8545/port = $rpcport/g" node.toml
sed -i -e "s/port = 8180/port = $parityport/g" node.toml
sed -i -e "s/port = 8450/port = $socketport/g" node.toml

rm *-e


