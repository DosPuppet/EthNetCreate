#!/bin/bash

export actualpath="$(echo "$(pwd)")"
export autpath="$(echo "$(pwd)")"/aut_node
export scriptpath="$(echo "$(pwd)")"/scripts

read -p "entrez le répertoire de création du nouveau noeud: " nodepath

if [ ! -d $nodepath ]; then 
mkdir $nodepath
fi

mkdir $nodepath/aut_node 
cp $autpath/chain.json $nodepath/aut_node
cp $scriptpath/node.norm $nodepath/aut_node/node.toml
cp $scriptpath/start_node.sh $nodepath/aut_node
cp $scriptpath/conf.sh $nodepath/aut_node
cp $scriptpath/node.pwds $nodepath/aut_node

read -p "Entrez la seed phrase de génération de la clé (plus long = plus sécurisé) d'autorité: " seed
if [ -z "$seed" ]
then
      echo "passphrase vide, merci de recommencer."
      exit $?
fi
read -sp "Entrez un mot de passe pour le compte: " spassword
if [ -z "$spassword" ]
then
      echo "password vide, merci de recommencer."
      exit $?
fi
echo ""
echo "$spassword" &> $nodepath/aut_node/node.pwds 

read -p "indiquez le port de synchronisation (default 30300): " syncport
[[ -z "$syncport" ]] && syncport=30300
read -p "indiquer le port RPC (default 8545): " rpcport
[[ -z "$rpcport" ]] && rpcport=8545
read -p "indiquez le port du client parity (default 8180): " parityport
[[ -z "$parityport" ]] && parityport=8180
read -p "indiquez le port du websocket parity (default 8450): " socketport
[[ -z "$socketport" ]] && socketport=8450


sed -i -e "s/port = 30300/port = $syncport/g" $nodepath/aut_node/node.toml
sed -i -e "s/port = 8545/port = $rpcport/g" $nodepath/aut_node/node.toml
sed -i -e "s/port = 8180/port = $parityport/g" $nodepath/aut_node/node.toml
sed -i -e "s/port = 8450/port = $socketport/g" $nodepath/aut_node/node.toml

cd $nodepath/aut_node

parity --config node.toml --force-ui --gasprice=0 --gas-price-percentile=0 --price-update-period="365000 days" --no-persistent-txqueue --jsonrpc-cors='*' --jsonrpc-interface="0.0.0.0" --ui-interface="0.0.0.0" --ws-interface="0.0.0.0" --ws-origins='*' &>parity.log &

parityid=$!

cd $actualpath
echo "Creating Authority Keys"
sleep 5

autKey="$(curl --data "{\"jsonrpc\":\"2.0\",\"method\":\"parity_newAccountFromPhrase\",\"params\":[\"$seed\", \"$spassword\"],\"id\":0}" -H "Content-Type: application/json" -X POST localhost:$rpcport)"
echo "${autKey}"
chainValidator=${autKey:27:42}

actualPubkey="$(cat "$autpath/keys/autority.pubkey")"

echo "$actualPubkey"

kill $parityid

sed -i -e "s/\"0x0000000000000000000000000000000000000000\"/\"$chainValidator\", \"0x0000000000000000000000000000000000000000\"/g" $autpath/chain.json
sed -i -e "s/\"0x0000000000000000000000000000000000000000\"/\"$chainValidator\", \"0x0000000000000000000000000000000000000000\"/g" $nodepath/aut_node/chain.json
sed -i -e "s/\"$actualPubkey\"/\"$chainValidator\"/g" $nodepath/aut_node/node.toml

read -p "entrez le port RPC de l'autority node (default 8545): " rpcport
[[ -z "$rpcport" ]] && rpcport="8545"
enode="$(curl --data '{"method": "parity_enode", "params": [], "id": 1, "jsonrpc": "2.0"}' -H "Content-Type: application/json" -X POST localhost:$rpcport)"
enodeSize="$(echo $enode | wc -c)"
enodeSize="$(echo $(($enodeSize-37)))"
enodeName=${enode:27:$enodeSize}
tmpvar=${enodeName:0:6}
tmpvar="$tmpvar\/\/"
enodeFull=$tmpvar${enodeName:8:$(($enodeSize-8))}
echo "${enodeName}"

sed -i -e "s/bootnodes = \[\]/bootnodes = \[\"$enodeFull\"\]/g" $nodepath/aut_node/node.toml

rm $autpath/*-e
rm $nodepath/aut_node
rm -rf $nodepath/aut_node/node/chains/*
rm $nodepath/aut_node/parity.log
rm $nodepath/aut_node/*-e



