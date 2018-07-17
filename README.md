# EthNetCreate
Create a local and/or distibuted Ethereum Network with Parity (PoA).
This is a pack of shell scripts to create Genesis, configuration file and necessary keys.

The network is created with a POA consensus model : first an authority node is created (validates block insted of traditional PoW mining). 

This networks Ether is premined, 21.000.000 Eth is allocated to a specified account (Vault).

Default gas price is 0, so you can immediately test smart contracts and transaction even without Eth in your account.

You can then create standard nodes as you want. It's an ideal way to test Ethereum network and it's possibilities.

## Installation 

First install [parity](https://github.com/paritytech/parity):

```bash
$ curl https://sh.rustup.rs -sSf | sh
```

Clone this repo :
```bash
$ git clone https://github.com/DosPuppet/EthNetCreate
```

## Authority Node creation

```bash
$ cd EthNetCreate
$ ./init.sh
```

The prompt will ask you parameters. Remember passphrases and passwords when asked. Those will be the keys of the Authority node block validation and Vault key to distribute Eth as you want.

The Authority node is created

```bash
$ cd aut_node
$ ./start_node.sh
```

See your node running and validating blocks

#### Advanced 

Before launching your node, you can configure ports (be sure your node is stopped), with ```bash $ conf.sh```

#### Access Point

You can access Parity-UI localy - http://localhost:8180 to acces your accounts, build smart-contracts and send Eth.

RPC endpoint is on standard port - http://localhost:8545, you can use metamask and play with all dapps ecosystem (remix and ethereum wallet are good to go)

#### /!\ --> The configuration is to test network, all APIs are open, and the Autority Node and Vault secret keys are on the server. Please see [parity doc](https://wiki.parity.io/) to harden your node and don't go live/production with this node as is.

## Adding a normal Node

Once your Autority Node is runnning, you can create a local node. 
In the EthNetCreate directory :

```bash
$ make_node.sh
```
The prompt will ask for a directory to install your new node.
Go to the directory you gave :

```bash
$ cd <your node directory>
````

if you want to run your node on a different server, just copy the directory wherever you want on your new server (make sur parity is installed and that the two server are on the same network and can see each other).

#### Bootnodes

Bootnodes are the nodes that will be accessed by your new node to sync to other. You must add at least one bootnode to your other nodes to sync. A node is identified by an enode.




If you copied your standard node on a new server, go to your copied directory :
```bash
$ cd norm_node
$ ./start_node.sh
```
Your new node is synced.
You can access it like the Autority Node (parity UI, metamask, ...).

#### Running multiple nodes localy 

```bash
$ cd norm_node
$ ./start_node.sh
```

## Adding another Autority Node

## Remove and clean-up

## Notes

This is a starting point to try decentralized ethereum ecosystem. Don't stop here, real stuff in crypto/blockchain/decentralisation is way further...


#### Tip for Beer :

Eth : 0x1C8F99295433921EbDC6E37951AF074014003D06

BTC : 1GkEPZ4nQUYycSm9JB1Nvozf2hAKkmLwaa

XMR : 432fU3BV4vA9ptxEEoVUpsabBWjRkYcTQDq68n33qCaZakpNfjFGPs3LuexUsqTop69sEej7Unr4qh18j1hpVkn8BTUwcDH








