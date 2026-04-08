// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.34; 
import {Script, console} from "forge-std/Script.sol"; 
import {AdvancedToken} from "../src/AdvancedToken.sol"; 
/** 
 * @title Airdrop 
 * @notice Script pour distribuer des tokens à plusieurs comptes 
 * 
 * Usage : 
 *   forge script script/Airdrop.s.sol --rpc-url $SEPOLIA_RPC_URL -
broadcast 
 */ 
contract Airdrop is Script { 
    function run() external { 
        // Adresse du token déjà déployé 
        address tokenAddress = vm.envAddress("TOKEN_ADDRESS"); 
        AdvancedToken token = AdvancedToken(tokenAddress); 
        // Liste des bénéficiaires et montants 
        address[] memory recipients = new address[](5); 
        recipients[0] = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8; 
        recipients[1] = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC; 
        recipients[2] = 0x90F79bf6EB2c4f870365E785982E1f101E93b906; 
        recipients[3] = 0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65; 
        recipients[4] = 0x9965507D1a55bcC2695C58ba16FB37d819B0A4dc; 
        uint256 amountEach = 1000 ether; // 1000 tokens par personne 
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY"); 
        vm.startBroadcast(deployerPrivateKey); 
        for (uint256 i = 0; i < recipients.length; i++) { 
            console.log("Sending", amountEach / 1e18, "tokens to", recipients[i]); 
            token.transfer(recipients[i], amountEach); 
        } 
        vm.stopBroadcast(); 
        console.log("\nAirdrop completed!"); 
        console.log("Total distributed:", (amountEach / 1e18) * recipients.length, "tokens"); 
    } 
}