// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {Script} from "forge-std/Script.sol";
import {MoodNFT} from "../src/MoodNFT.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";

contract MintMoodNFT is Script {
    MoodNFT public moodNFT;

    function run() external {
        moodNFT = MoodNFT(
            DevOpsTools.get_most_recent_deployment("MoodNFT", block.chainid)
        );
        mintNFT();
    }

    function mintNFT() public {
        vm.startBroadcast();
        moodNFT.mintNFT();
        vm.stopBroadcast();
    }
}

contract FlipMoodNFT is Script {
    MoodNFT public moodNFT;
    uint256 public constant TOKEN_ID_TO_FLIP = 0;

    function run() external {
        moodNFT = MoodNFT(
            DevOpsTools.get_most_recent_deployment("MoodNFT", block.chainid)
        );

        flipMoodNFT();
    }

    function flipMoodNFT() public {
        vm.startBroadcast();
        moodNFT.flipMood(TOKEN_ID_TO_FLIP);
        vm.stopBroadcast();
    }
}
