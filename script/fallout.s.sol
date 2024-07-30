// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import {Script, console} from "forge-std/Script.sol";
import {Fallout} from "../src/Fallout.sol";

contract FalloutScript is Script {

    Fallout public fallout;

    constructor() public {
        fallout = Fallout(vm.envAddress("FALLOUT_INSTANCE"));
    }

    function setUp() public {}

    function run() public {
        uint256 pk = vm.envUint("PK");
        vm.startBroadcast(pk);
        fallout.Fal1out{value: 1}();
        vm.stopBroadcast();
    }

    // forge script script/fallout.s.sol:FalloutScript --broadcast
}
