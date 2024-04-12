// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Force} from "../src/Force.sol";
import {Ownable} from "@open/Ownable.sol";

contract ForceScript is Script {

    Force public force;

    constructor() {
        force = Force(vm.envAddress("FORCE_INSTANCE"));
    }

    function run() public {
        uint256 pk = vm.envUint("PK");
        vm.startBroadcast(pk);
        new ForceExecutor{value:1}(force);
        vm.stopBroadcast();
        console.log("Balance: ", address(force).balance);
    }

    // forge script script/force.s.sol:ForceScript --broadcast
}

contract ForceExecutor {
    Force public force;

    constructor(Force _force) payable {
        force = _force;
        address(force).call{value:msg.value}("");
    }
}

abstract contract Level is Ownable {
    function createInstance(address _player) virtual public payable returns (address);
    function validateInstance(address payable _instance, address _player) virtual public returns (bool);
}


