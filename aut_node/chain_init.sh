#!/bin/bash

read -p "Entrez le nom de la chaine (pas d' espace ni caractères spéciaux): " chainname
read -p "Entrez l'id de la chaine (caractères hexadécimaux précédés de 0x - par exemple 0x12983: " networkid
cp chain.clean chain.json
sed -i -e "s/\"chainname\"/\"$chainname\"/g" chain.json
sed -i -e "s/\"0x1\"/\"$networkid\"/g" chain.json


