# DESCRIPTION

A DApp for music NFT storage, listing, sale and purchase.

### STACK

- ReactJS
- NPM
- Hardhat
- IPFS
- Ethereum

### QUICKSTART COMMANDS

`npm run start` to fire up the React f/e app.

`npx hardhat node` to start the local hardhat network at http://127.0.0.1:8545/, and the HTTP + WebSocket JSON-RPC server at atop it. Note the 20 "canned" accounts created by Hardhat.

`npm run local:deploy` to deploy contracts onto the local hardhat node. Note the contract address.

From another terminal connect to hardhat console with `npx hardhat console --network localhost`

In the console prompt run the following:

```
const c = await ethers.getContractAt("<<CONTRACT_NAME>>"","<<CONTRACT_ADDRESS>>")

# call methods on the contract, such as:
await c.owner()
await c.baseURI() # public state variable declared in the contract
await c.name() # returns the token name as per ERC721 constructor args
await c.symbol() # returns the symbol name as per ERC721 constructor args

```
