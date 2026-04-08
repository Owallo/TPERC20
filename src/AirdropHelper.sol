// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

import {IERC20} from "forge-std/interfaces/IERC20.sol";

contract AirdropHelper {
    function batchTransfer(
        address token,
        address[] calldata recipients,
        uint256[] calldata amounts
    ) external {
        require(recipients.length == amounts.length, "Length mismatch");
        
        // Calculer le montant total
        uint256 totalAmount = 0;
        for (uint256 i = 0; i < amounts.length; i++) {
            totalAmount += amounts[i];
        }
        
        // Transférer du caller vers ce contrat
        IERC20(token).transferFrom(msg.sender, address(this), totalAmount);
        
        // Distribuer à chaque destinataire
        for (uint256 i = 0; i < recipients.length; i++) {
            IERC20(token).transfer(recipients[i], amounts[i]);
        }
    }
} 