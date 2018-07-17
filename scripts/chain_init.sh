#!/bin/bash

read -p "Entrez le nom de la chaine (pas d' espace ni caractères spéciaux - par défaut 'testPOA'): " chainname
[[ -z "$chainname" ]] && chainname="testPOA"
read -p "Entrez l'id de la chaine (caractères hexadécimaux précédés de 0x - par defaut '0x12983': " networkid
[[ -z "$networkid" ]] && networkid="0x12983"
cp $scriptpath/chain.clean $autpath/chain.json
sed -i -e "s/\"chainname\"/\"$chainname\"/g" $autpath/chain.json
sed -i -e "s/\"0x1\"/\"$networkid\"/g" $autpath/chain.json


