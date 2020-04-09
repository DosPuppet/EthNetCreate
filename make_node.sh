#!/bin/bash

export autpath="$(echo "$(pwd)")"/aut_node
export scriptpath="$(echo "$(pwd)")"/scripts

read -p "entrez le répertoire de création du nouveau noeud: " nodepath
mkdir $nodepath/norm_node 
cp $autpath/chain.json $nodepath/norm_node
cp $scriptpath/node.norm $nodepath/norm_node/node.toml
cp $scriptpath/start_node.sh $nodepath/norm_node
cp $scriptpath/conf.sh $nodepath/norm_node

read -p "entrez le port RPC de l'autority node (default 8545): " rpcport
[[ -z "$rpcport" ]] && rpcport=8545
enode="$(curl --data '{"method": "parity_enode", "params": [], "id": 1, "jsonrpc": "2.0"}' -H "Content-Type: application/json" -X POST localhost:$rpcport)"
enodeSize="$(echo $enode | wc -c)"
enodeSize="$(echo $(($enodeSize-37)))"
enodeName=${enode:27:$enodeSize}
tmpvar=${enodeName:0:6}
tmpvar="$tmpvar\/\/"
enodeFull=$tmpvar${enodeName:8:$(($enodeSize-8))}
echo "${enodeName}"

sed -i -e "s/bootnodes = \[\]/bootnodes = \[\"$enodeFull\"\]/g" $nodepath/norm_node/node.toml
rm $nodepath/norm_node/*-e


