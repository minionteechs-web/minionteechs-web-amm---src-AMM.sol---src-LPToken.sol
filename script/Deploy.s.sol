// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/AMM.sol";

contract DeployScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        // Replace these with actual token addresses
        address token0 = 0x0000000000000000000000000000000000000001;
        address token1 = 0x0000000000000000000000000000000000000002;

        AMM amm = new AMM(token0, token1);

        vm.stopBroadcast();
    }
}
