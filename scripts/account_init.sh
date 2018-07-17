#!/bin/bash

read -p "Entrez la seed phrase de génération de la clé (plus long = plus sécurisé) d'autorité: " seed
read -sp "Entrez un mot de passe pour le compte: " spassword
echo "$spassword" &> $autpath/node.pwds 
echo ""
read -p "Entrez la seed phrase de génération de la clé (plus long = plus sécurisé) de réserve: " vault
read -sp "Entrez un mot de passe pour le compte: " vpassword 
echo ""

autKey="$(curl --data "{\"jsonrpc\":\"2.0\",\"method\":\"parity_newAccountFromPhrase\",\"params\":[\"$seed\", \"$spassword\"],\"id\":0}" -H "Content-Type: application/json" -X POST localhost:8545)"
echo "${autKey}"
chainValidator=${autKey:27:42}

vaultKey="$(curl --data "{\"jsonrpc\":\"2.0\",\"method\":\"parity_newAccountFromPhrase\",\"params\":[\"$vault\", \"$vpassword\"],\"id\":0}" -H "Content-Type: application/json" -X POST localhost:8545)"
echo "${vaultKey}"
vault=${vaultKey:27:42}


sed -i -e "s/\"0x0000000000000000000000000000000000000000\"/\"$chainValidator\"/g" $autpath/chain.json
sed -i -e "s/\"0x0000000000000000000000000000000000000000\"/\"$chainValidator\"/g" $autpath/node.toml
sed -i -e "s/\"0x0000000000000000000000000000000000000005\"/\"$vault\"/g" $autpath/chain.json



