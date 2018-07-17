#!/bin/bash

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
echo "$spassword" &> $autpath/node.pwds 
echo ""
read -p "Entrez la seed phrase de génération de la clé (plus long = plus sécurisé) de réserve: " vault
if [ -z "$vault" ]
then
      echo "passphrase vide, merci de recommencer."
      exit $?
fi
read -sp "Entrez un mot de passe pour le compte: " vpassword
if [ -z "$vpassword" ]
then
      echo "passphrase vide, merci de recommencer."
      exit $?
fi
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



