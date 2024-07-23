// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {NaughtCoin} from "../src/NaughtCoin.sol";

contract NaughtCoinScript is Script {
    function run() public {
        uint256 pk = vm.envUint("PK");

        vm.startBroadcast(pk);
        
        vm.stopBroadcast();
    }

    // forge script script/GatekeeperTwoScript.s.sol:GatekeeperTwoScript --broadcast
}

contract NaughtCoinExecutor { // validate the gate two
    constructor(NaughtCoinScript naughtCoinScript, bytes8 key) {}
}
