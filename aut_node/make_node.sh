#!/bin/bash

read -p "entrez le répertoire de création du nouveau noeud: " nodepath
mkdir $nodepath/norm_node 
cp chain.json $nodepath/norm_node
cp node.norm $nodepath/norm_node/node.toml
cp start_node.sh $nodepath/norm_node


