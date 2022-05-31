# Starknet node
Quick installer A StarkNet full node giving you a safe view into StarkNet.

# Features
- access the full StarkNet state history
  - includes contract code and storage, and transactions
- verifies state using L1
    - calculates the StarkNet state's Patricia-Merkle Trie root on a block-by-block basis and confirms it against L1
    - this means the contract code and storage are now locally verified
- Ethereum-like RPC API
    - run StarkNet functions without requiring a StarkNet transaction
    - executed against the local state

# Requirement
## For running a production grade FullNode:
- CPU    : 4 cores
- Memory : 4GiB RAM
- Storage: 300GB SSD

## For running the FullNode for development or testing:
- CPU    : 2 cores
- Memory : 1GiB RAM
- Storage: 300GB SSD

# Installation
## Prerequisites

To run starknet we will use the nodes provided by the Alchemy service, so register at alchemy.com and create endpoints in your personal account.  
https://www.alchemy.com/

## install
```bash
wget -O starknet-fullnode.sh https://raw.githubusercontent.com/qyeah98/starknet-node/main/starknet-fullnode.sh
chmod +x starknet-fullnode.sh
./starknet-fullnode.sh
```

and then input your node info

```bash
INPUT HTTP ADDRESS: 

# Example
INPUT HTTP ADDRESS: https://eth-goerli.alchemyapi.io/v2/cbhdshi42sauBbjss7c62wyebshaks
```

## Info
### View docker logs
```bash
docker logs -f (IMAGE-NAME) --tail 100

# Example:
docker logs -f starknet-fullnode --tail 100
```

### Stop node
```bash
docker stop (IMAGE-NAME)

# Example:
docker stop starknet-fullnode
```

### Update node
```bash
docker pull eqlabs/pathfinder

docker run \
  --detach \
  --name (IMAGE-NAME) \
  -p 9545:9545 \
  -e RUST_LOG=info \
  -e PATHFINDER_ETHEREUM_API_URL=$ADDRESS \
  -v $HOME/pathfinder \
  eqlabs/pathfinder
  
 
 # Example:
 docker pull eqlabs/pathfinder
 
 docker run \
  --detach \
  --name starknet-fullnode-0.1.11-alpha \
  -p 9545:9545 \
  -e RUST_LOG=info \
  -e PATHFINDER_ETHEREUM_API_URL=$ADDRESS \
  -v $HOME/pathfinder \
  eqlabs/pathfinder
```

# Reference
https://github.com/eqlabs/pathfinder#readme
