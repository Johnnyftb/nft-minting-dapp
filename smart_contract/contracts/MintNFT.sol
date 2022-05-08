// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract mintnft is ERC721, Ownable {

    using Strings for uint256;

    // Constructor
    constructor (
        string memory _baseURI,
        string memory _baseExtension
    ) ERC721("Baker Boys", "BB") {
        tokenCounter = 0;
        baseURI = _baseURI;
        baseExtension = _baseExtension;
    }

    // Minted NFTs
    uint256 public tokenCounter;
    // Mint Price
    uint256 public mintPrice = 0.05 ether;
    // Max Mint Amount
    uint256 public maxMintAmount = 1;
    // Collection Size
    uint256 public collectionSize = 8;
    // Base URI
    string baseURI;
    // Base Extension
    string public baseExtension;

    // TokenID to Token URI
    mapping(uint256 => string) tokenIdToTokenURI;
    // Token ID to Owner
    mapping(uint256 => address) tokenIdToOwner;
    

    // Mint NFT
    function mintNFT(uint256 _mintAmount) public payable {
        // Require ETH Sent >= Mint Price * _mintAmount
        require(msg.value >= mintPrice * _mintAmount, "Not Enough ETH");
        // Require tokenCounter < Collection Size
        require(tokenCounter < collectionSize, "All NFTs minted");
        // Require Mint Amount to be <= Max Mint Amount
        require(_mintAmount <= maxMintAmount, "Max Mint Amount is 1");
        // Require Mint Amount + Token Counter <= Collection Size
        require(_mintAmount + tokenCounter <= collectionSize, "Minting Too Many");

        for (uint256 i = 0; i < _mintAmount; i++) {
            // Add to Token Counter
            tokenCounter += 1;
            // Call _safeMint function from OZ Contract
            _safeMint(msg.sender, tokenCounter);
            // Add Data to Token ID to Owner Mapping
            tokenIdToOwner[tokenCounter] = msg.sender;
        }
    }

    // Return TokenURI
    function tokenURI(uint256 _tokenId) public view override returns (string memory) {
        require(_exists(_tokenId), "ERC721Metadata: URI query for nonexistent token");

        return string(abi.encodePacked(baseURI, _tokenId.toString(), baseExtension));
    }

    // Find Token Owner
    function getTokenOwner(uint256 _tokenId) public view returns (address) {
        require(_exists(_tokenId), "ERC721Metadata: URI query for nonexistent token");

        return tokenIdToOwner[_tokenId];
    }

    // Withdraw funds from Contract
    function withdraw() public payable onlyOwner {
        (bool os, ) = payable(owner()).call{value: address(this).balance}("");
        require(os);
    }
} 