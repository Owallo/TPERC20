// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.34; 
import "@openzeppelin/contracts/token/ERC20/ERC20.sol"; 
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol"; 
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol"; 
import "@openzeppelin/contracts/access/Ownable.sol"; 
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol"; 
/** 
 * @title OZToken 
 * @notice Token ERC20 utilisant OpenZeppelin — version production 
 */ 
contract OZToken is ERC20, ERC20Burnable, ERC20Pausable, Ownable, ERC20Capped { 
    constructor( 
        string memory name, 
        string memory symbol, 
        uint256 initialSupply, 
        uint256 cap 
    ) 
        ERC20(name, symbol) 
        Ownable(msg.sender) 
        ERC20Capped(cap * 10**decimals()) 
    { 
        _mint(msg.sender, initialSupply * 10**decimals()); 
    } 
    /** 
     * @notice Mint de nouveaux tokens (owner seulement) 
     */ 
    function mint(address to, uint256 amount) external onlyOwner { 
        _mint(to, amount); 
    } 
    /** 
     * @notice Pause tous les transferts 
     */ 
    function pause() external onlyOwner { 
        _pause(); 
    } 
    /** 
     * @notice Unpause les transferts 
     */ 
    function unpause() external onlyOwner { 
        _unpause(); 
    } 
    /** 
     * @dev Override requis par Solidity pour les héritages multiples 
     */ 
    function _update(address from, address to, uint256 value) 
        internal 
        override(ERC20, ERC20Pausable, ERC20Capped) 
    { 
        super._update(from, to, value); 
    } 
}