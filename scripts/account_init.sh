#!/bin/bash

read -p "Entrez la seed phrase de génération de la clé (plus long = plus sécurisé) d'autorité: " seed
read -sp "Entrez un mot de passe pour le compte: " spassword
echo "$spassword" &> $autpath/node.pwds 
echo ""
read -p "Entrez la seed phrase de génération de la clé (plus long = plus sécurisé) de réserve: " vault
read -sp "Entrez un mot de passe pour le compte: " vpassword 
echo ""

cp $scriptpath/keys.clean $scriptpath/keys.sh
chmod +x $scriptpath/keys.sh

sed -i -e "s/\"seed1\"/\"$seed\"/g" $scriptpath/keys.sh 
sed -i -e "s/\"password1\"/\"$spassword\"/g" $scriptpath/keys.sh
sed -i -e "s/\"seed2\"/\"$vault\"/g" $scriptpath/keys.sh 
sed -i -e "s/\"password2\"/\"$vpassword\"/g" $scriptpath/keys.sh


