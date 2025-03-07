// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Script} from "forge-std/Script.sol";
import {IAShop} from "../src/IAShop.sol";

contract DeployIAShop is Script {
    function run() external returns (address) {
        

        vm.startBroadcast();
        

        IAShop ot = new IAShop();
        
        vm.stopBroadcast();
        return address(ot);
    }
}