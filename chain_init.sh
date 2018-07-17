#!/bin/bash

read -p "Entrez le nom de la chaine (pas d' espace ni caractères spéciaux): " chainname
read -p "Entrez l'id de la chaine (caractères hexadécimaux précédés de 0x - par exemple 0x12983: " networkid
cp chain.clean aut_node/chain.json
sed -i -e "s/\"chainname\"/\"$chainname\"/g" aut_node/chain.json
sed -i -e "s/\"0x1\"/\"$networkid\"/g" aut_node/chain.json


