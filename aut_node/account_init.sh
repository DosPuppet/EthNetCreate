#!/bin/bash

read -p "Entrez la seed phrase de génération de la clé (plus long = plus sécurisé) d'autorité: " seed
read -sp "Entrez un mot de passe pour le compte: " spassword
echo "$spassword" &> node.pwds 
echo ""
read -p "Entrez la seed phrase de génération de la clé (plus long = plus sécurisé) de réserve: " vault
read -sp "Entrez un mot de passe pour le compte: " vpassword 
echo ""

cp keys.clean keys.sh

sed -i -e "s/\"seed1\"/\"$seed\"/g" keys.sh 
sed -i -e "s/\"password1\"/\"$spassword\"/g" keys.sh
sed -i -e "s/\"seed2\"/\"$vault\"/g" keys.sh 
sed -i -e "s/\"password2\"/\"$vpassword\"/g" keys.sh


