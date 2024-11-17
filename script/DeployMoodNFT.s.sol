// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {Script} from "forge-std/Script.sol";
import {MoodNFT} from "../src/MoodNFT.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNFT is Script {
    MoodNFT public moodNFT;

    function run() external returns (MoodNFT) {
        string memory sadSVG = vm.readFile("./images/sad.svg");
        string memory happySVG = vm.readFile("./images/happy.svg");

        string memory sadSVGImageURI = svgToImageURI(sadSVG);
        string memory happySVGImageURI = svgToImageURI(happySVG);

        vm.startBroadcast();
        moodNFT = new MoodNFT(sadSVGImageURI, happySVGImageURI);
        vm.stopBroadcast();

        return moodNFT;
    }

    function svgToImageURI(
        string memory svg
    ) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(abi.encodePacked(svg));

        return string.concat(baseURL, svgBase64Encoded);
    }
}
