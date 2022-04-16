// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

/// @title Defines the NFT Music Marketplace
/// @author Zeuslawyer
/// @notice Sets up the functionality for the NFT Marketplace contract. The deployer lists the
/// initial NFTS on the marketplace and needs to include ether required to cover those fees.
/// @dev Must be initialised with royalty fee, artist address and _prices of music NFTs.
contract MusicNFTMarketplace is ERC721, Ownable {
	string constant _tokenName = "zub-toon";
	string constant _tokenSymbol = "Z-TOON";

	string public baseURI =
		"https://bafybeidhjjbjonyqcahuzlpt7sznmh4xrlbspa3gstop5o47l6gsiaffee.ipfs.nftstorage.link/";

	string public baseFileExtension = ".json";
	address public artist;
	uint256 public royaltyFee;
	MarketItem[] public marketItems;

	struct MarketItem {
		uint256 tokenId;
		address seller;
		uint256 price;
	}

	// MusicNFTMarketplace also must instantiate the ERC721 superclass.
	// Deployer can also include ether required to cover feels to list the NFTs on
	// the marketplace here.
	constructor(
		uint256 _royaltyFee,
		address _artist,
		uint256[] memory _prices
	) payable ERC721(_tokenName, _tokenSymbol) {
		// Ensure sufficient ether to cover listing costs of all NFTs included.
		require(
			msg.value >= _prices.length * _royaltyFee,
			"Contract funding is insuffiient to pay the royalty fees for the number of NFTs included."
		);

		royaltyFee = _royaltyFee;
		artist = _artist;

		for (uint8 i = 0; i < _prices.length; i++) {
			// Check price is a positive integer.
			require(_prices[i] > 0, "Price must be greater than 0");

			// Mint NFT and transfer it to this marketplace contract.
			_mint(address(this), i);

			MarketItem memory item = MarketItem({
				tokenId: i,
				seller: payable(msg.sender),
				price: _prices[i]
			});

			marketItems.push(item);
		}
	}
}
