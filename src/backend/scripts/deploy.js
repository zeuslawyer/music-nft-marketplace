const { ethers } = require("hardhat");

async function main() {
  const signers = await ethers.getSigners();
  const [deployer] = signers; // Deploy with the first of 20 accounts created.

  console.log("Contract deployed by account:", deployer.address);
  console.log("Account balance:", (await deployer.getBalance()).toString());

  // deploy contracts here:
  const CONTRACT_NAME = "MusicNFTMarketplace";
  const MusicNFTMarketplaceFactory = await ethers.getContractFactory(
    CONTRACT_NAME
  );
  const nftMarketplace = await MusicNFTMarketplaceFactory.deploy();

  console.log(
    `Deployed contract at address ${
      nftMarketplace.address
    } and with token name ${await nftMarketplace.functions.name()} and symbol ${await nftMarketplace.functions.symbol()}`
  );

  // For each contract, pass the deployed contract and name to this function to save a copy of the contract ABI and address to the front end.
  saveABItoFrontend(nftMarketplace, CONTRACT_NAME);
}

function saveABItoFrontend(contract, name) {
  const fs = require("fs");
  const contractsDir = __dirname + "/../../frontend/contractsData";

  if (!fs.existsSync(contractsDir)) {
    fs.mkdirSync(contractsDir);
  }

  fs.writeFileSync(
    contractsDir + `/${name}-address.json`,
    JSON.stringify({ address: contract.address }, undefined, 2)
  );

  const contractArtifact = artifacts.readArtifactSync(name);

  fs.writeFileSync(
    contractsDir + `/${name}.json`,
    JSON.stringify(contractArtifact, null, 2)
  );
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
