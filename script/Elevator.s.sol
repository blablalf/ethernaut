// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {Elevator, Building} from "../src/Elevator.sol";             


contract ElevatorScript is Script {

    Elevator internal elevator;

    constructor() {
        elevator = Elevator(vm.envAddress("ELEVATOR_INSTANCE"));
    }

    function run() public {
        uint256 pk = vm.envUint("PK");

        vm.startBroadcast(pk);
        new ElevatorExecutor(elevator).top();
        vm.stopBroadcast();
    }

    // forge script script/elevator.s.sol:ElevatorScript --broadcast
}

contract ElevatorExecutor is Building {
    Elevator internal _elevator;

    constructor(Elevator elevator) {
        _elevator = elevator;
    }

    function top() external {
        _elevator.goTo(5);
    }

    function isLastFloor(uint256) external view returns (bool) {
        return _elevator.floor() != 5 ? false : true;
    }
}

