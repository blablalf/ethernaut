// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";

contract ForceScript is Script {

    Force public force;

    constructor() {
        force = Force(vm.envAddress("FORCE_INSTANCE"));
    }

    function run() public {
        uint256 pk = vm.envUint("PK");

        // test
        Level level = Level(vm.envAddress("LEVEL_ADDRESS"));
        address levelOwner = level.owner();
        vm.startPrank(levelOwner);
        address levelInstance = level.createInstance(vm.addr(pk));
        console.log("Futur address of the level instance", levelInstance);
        vm.stopPrank();
        vm.startBroadcast(pk);
        levelInstance.call{value:1}("");
        vm.stopBroadcast();
        console.log("Balance: ", address(force).balance);
    }

    // forge script script/force.s.sol:ForceScript --broadcast
}

abstract contract Level is Ownable {
    function createInstance(address _player) virtual public payable returns (address);
    function validateInstance(address payable _instance, address _player) virtual public returns (bool);
}


