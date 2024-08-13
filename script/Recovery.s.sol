// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Recovery} from "./../src/Recovery.sol";

contract RecoveryScript is Script {
    function run() public {
        uint256 pk = vm.envUint("PK");
        vm.stopBroadcast();
    }

    // forge script script/RecoveryScript.s.sol:RecoveryScript --broadcast
}

contract RecoveryExecutor {
}
