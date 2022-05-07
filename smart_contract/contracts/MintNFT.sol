// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract mintnft is ERC721 {

    // Constructor
    constructor (
        uint256 _mintPrice,
        uint256 _maxMintAmount,
        uint256 _collectionSize,
        string _baseURI,
        string _baseExtension
    ) public ERC721("Baker Boys", "BB") {
        tokenCounter = 0;
        mintPrice = _mintPrice;
        maxMintAmount = _maxMintAmount;
        collectionSize = _collectionSize;
        baseURI = _baseURI,
        baseExtension = _baseExtension;
    }

    // Minted NFTs
    uint256 public tokenCounter;
    // Mint Price
    uint256 public mintPrice;
    // Max Mint Amount
    uint256 public maxMintAmount;
    // Collection Size
    uint256 public collectionSize;
    // Base URI
    string baseURI;
    // Base Extension
    string public baseExtension;

    // TokenID to Token URI
    mapping(uint256 => string) tokenIdToTokenURI;
    // Token ID to Owner
    mapping(uint256 => address) tokenIdToOwner;
    

    // Mint NFT
    function mintNFT(string memory _tokenURI, uint256 _mintAmount) public payable {
        // Require ETH Sent >= Mint Price * _mintAmount
        require(msg.value >= mintPrice * _mintAmount);
        // Require tokenCounter < Collection Size
        require(tokenCounter < collectionSize);
        // Require Mint Amount to be <= Max Mint Amount
        require(_mintAmount <= maxMintAmount);
        // Require Mint Amount + Token Counter <= Collection Size
        require(_mintAmount + tokenCounter <= collectionSize);

        for (uint256 i = 0; i < _mintAmount; i++) {
            // Add to Token Counter
            tokenCounter += 1;
            // Call _safeMint function from OZ Contract
            _safeMint(msg.sender, tokenCounter);
            // Add Data to Token ID to Owner Mapping
            tokenIdToOwner[tokenCounter] = msg.sender;
        }
    }

    // Set Token URI
    function setTokenURI(uint256 _tokenId, string memory _tokenURI) public {
        // Require Function Caller to be Approved or the Owner of the NFT
        require(
            _isApprovedOrOwner(_msgSender(), tokenId),
            "ERC721: Caller is not owner nor approved"
        );

        // Set Token URI
        _setTokenURI(_tokenId, _tokenURI);
    }
}