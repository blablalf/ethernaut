// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Vault} from "../src/Vault.sol";
import {stdStorage, StdStorage} from "forge-std/Test.sol";              


contract VaultScript is Script {
using stdStorage for StdStorage;

    Vault public vault;

    constructor() {
        vault = Vault(vm.envAddress("VAULT_INSTANCE"));
    }

    function run() public {
        uint256 pk = vm.envUint("PK");
        bytes32 passwd = vm.load(address(vault), bytes32(uint256(1))); // passwsord is stored at slot 1

        vm.startBroadcast(pk);
        vault.unlock(passwd);
        vm.stopBroadcast();

        console.log("Password", uint256(passwd));
    }

    // forge script script/vault.s.sol:VaultScript --broadcast
}



