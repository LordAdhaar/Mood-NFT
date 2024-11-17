// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {MoodNFT} from "../src/MoodNFT.sol";
import {Test, console} from "forge-std/Test.sol";
import {DeployMoodNFT} from "../script/DeployMoodNFT.s.sol";

contract MoodNFTTest is Test {
    MoodNFT public moodNFT;
    DeployMoodNFT public deployMoodNFT;
    address public bob = makeAddr("BOB");
    address public alice = makeAddr("ALICE");

    string public constant SAD_URI =
        "data:application/json;base64,eyJuYW1lIjogIk1vb2RORlQiLCJkZXNjcmlwdGlvbiI6ICJBbiBORlQgdGhhdCByZWZsZWN0cyB0aGUgbW9vZCBvZiB0aGUgb3duZXIsIDEwMCUgb24gQ2hhaW4hIiwiYXR0cmlidXRlcyI6IFt7InRyYWl0X3R5cGUiOiAibW9vZGluZXNzIiwgInZhbHVlIjogMTAwfV0sImltYWdlIjogImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEhOMlp5QjRiV3h1Y3owaWFIUjBjRG92TDNkM2R5NTNNeTV2Y21jdk1qQXdNQzl6ZG1jaUlIWnBaWGRDYjNnOUlqQWdNQ0F4TURBZ01UQXdJaUIzYVdSMGFEMGlNVEF3SWlCb1pXbG5hSFE5SWpFd01DSStDaUFnUEdOcGNtTnNaU0JqZUQwaU5UQWlJR041UFNJMU1DSWdjajBpTkRVaUlHWnBiR3c5SWlOR1JrTkRORVFpSUM4K0NpQWdQR05wY21Oc1pTQmplRDBpTXpVaUlHTjVQU0kwTUNJZ2NqMGlOU0lnWm1sc2JEMGlJelkyTkRVd01DSWdMejRLSUNBOFkybHlZMnhsSUdONFBTSTJOU0lnWTNrOUlqUXdJaUJ5UFNJMUlpQm1hV3hzUFNJak5qWTBOVEF3SWlBdlBnb2dJRHh3WVhSb0lHUTlJazB6TUNBM01DQkROREFnTlRBc0lEWXdJRFV3TENBM01DQTNNQ0lnYzNSeWIydGxQU0lqTmpZME5UQXdJaUJ6ZEhKdmEyVXRkMmxrZEdnOUlqVWlJR1pwYkd3OUltNXZibVVpSUM4K0Nqd3ZjM1puUGdvPSJ9";

    string public constant HAPPY_URI =
        "data:application/json;base64,eyJuYW1lIjogIk1vb2RORlQiLCJkZXNjcmlwdGlvbiI6ICJBbiBORlQgdGhhdCByZWZsZWN0cyB0aGUgbW9vZCBvZiB0aGUgb3duZXIsIDEwMCUgb24gQ2hhaW4hIiwiYXR0cmlidXRlcyI6IFt7InRyYWl0X3R5cGUiOiAibW9vZGluZXNzIiwgInZhbHVlIjogMTAwfV0sImltYWdlIjogImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEhOMlp5QjRiV3h1Y3owaWFIUjBjRG92TDNkM2R5NTNNeTV2Y21jdk1qQXdNQzl6ZG1jaUlIWnBaWGRDYjNnOUlqQWdNQ0F4TURBZ01UQXdJaUIzYVdSMGFEMGlNVEF3SWlCb1pXbG5hSFE5SWpFd01DSStDaUFnUEdOcGNtTnNaU0JqZUQwaU5UQWlJR041UFNJMU1DSWdjajBpTkRVaUlHWnBiR3c5SWlOR1JrTkRORVFpSUM4K0NpQWdQR05wY21Oc1pTQmplRDBpTXpVaUlHTjVQU0kwTUNJZ2NqMGlOU0lnWm1sc2JEMGlJelkyTkRVd01DSWdMejRLSUNBOFkybHlZMnhsSUdONFBTSTJOU0lnWTNrOUlqUXdJaUJ5UFNJMUlpQm1hV3hzUFNJak5qWTBOVEF3SWlBdlBnb2dJRHh3WVhSb0lHUTlJazB6TUNBMk1DQkROREFnT0RBc0lEWXdJRGd3TENBM01DQTJNQ0lnYzNSeWIydGxQU0lqTmpZME5UQXdJaUJ6ZEhKdmEyVXRkMmxrZEdnOUlqVWlJR1pwYkd3OUltNXZibVVpSUM4K0Nqd3ZjM1puUGdvPSJ9";

    function setUp() public {
        deployMoodNFT = new DeployMoodNFT();
        moodNFT = deployMoodNFT.run();
    }

    function testViewTokenURI() public {
        vm.prank(bob);
        moodNFT.mintNFT();
    }

    function testFlipMood() public {
        vm.startPrank(bob);
        moodNFT.mintNFT();
        moodNFT.approve(alice, 0);
        moodNFT.flipMood(0);
        vm.stopPrank();

        assertEq(moodNFT.tokenURI(0), SAD_URI);

        vm.prank(alice);
        moodNFT.flipMood(0);

        assertEq(moodNFT.tokenURI(0), HAPPY_URI);
    }
}
