//SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

// Layout of the contract file:
// version
// imports
// errors
// interfaces, libraries, contract
// Inside Contract:
// Type declarations
// State variables
// Events
// Modifiers
// Functions
// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// within function:
// payable
// non - payable
// view
// pure
import {Test, console} from "forge-std/Test.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

error MoodNFT_CantFlipMoodIfNotOwnerOrApproved();

contract MoodNFT is ERC721 {
    uint256 private s_tokenNumber;
    string private s_sadSVGImageURI;
    string private s_happySVGImageURI;

    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(
        string memory sadSVGImageURI,
        string memory happySVGImageURI
    ) ERC721("MoodNFT", "MNFT") {
        s_tokenNumber = 0;
        s_sadSVGImageURI = sadSVGImageURI;
        s_happySVGImageURI = happySVGImageURI;
    }

    function mintNFT() public {
        _safeMint(msg.sender, s_tokenNumber);
        s_tokenIdToMood[s_tokenNumber] = Mood.HAPPY;
        s_tokenNumber += 1;
    }

    function flipMood(uint256 tokenId) public {
        if (
            msg.sender != _ownerOf(tokenId) &&
            msg.sender != _getApproved(tokenId)
        ) {
            revert MoodNFT_CantFlipMoodIfNotOwnerOrApproved();
        }

        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory baseURI = _baseURI();
        string memory metadata = generateMetadata(tokenId);

        return
            string.concat(baseURI, Base64.encode(abi.encodePacked(metadata)));
    }

    function generateMetadata(
        uint256 tokenId
    ) internal view returns (string memory) {
        bytes memory metadata = abi.encodePacked(
            "{",
            '"name": "',
            name(),
            '",',
            '"description": "An NFT that reflects the mood of the owner, 100% on Chain!",',
            '"attributes": [{"trait_type": "moodiness", "value": 100}],',
            '"image": "',
            getImageURI(tokenId),
            '"',
            "}"
        );
        return string(metadata);
    }

    function getImageURI(uint256 tokenId) public view returns (string memory) {
        return
            s_tokenIdToMood[tokenId] == Mood.HAPPY
                ? s_happySVGImageURI
                : s_sadSVGImageURI;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }
}
