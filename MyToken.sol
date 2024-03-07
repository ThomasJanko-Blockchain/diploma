// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract MyToken is ERC20, ERC20Burnable, Ownable, ERC20Permit {

    address public tokenOwner;
    
    constructor(address initialOwner)
        ERC20("Diploma", "DIP")
        Ownable(initialOwner)
        ERC20Permit("Diploma")
    {
        tokenOwner = initialOwner;
        _mint(msg.sender, 10000000000 * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function purchaseTokens() external payable {
        require(msg.value > 0, "You can't send negative value !");
        uint tokensAmount = msg.value * 100; // 1Ether = 100 tokens
        _mint(msg.sender, tokensAmount);
    }

    function payEvaluationRewards(address _company, uint _evaluations) external onlyOwner {
        uint tokensToTransfer = _evaluations * 15;
        require (balanceOf(tokenOwner) >= tokensToTransfer, "Insufficient balance.");
        _transfer(tokenOwner, _company, tokensToTransfer);
    }

    function payVerificationFees(address _diplomaContract, address _company, uint _verifications) external onlyOwner {
        require(_company != address(0), "Invalid contract address");
       
        uint tokensToTransfer = _verifications * 10;
        require (balanceOf(tokenOwner) >= tokensToTransfer, "Insufficient balance.");
        // _transfer(_company, _diplomaContract, tokensToTransfer);
        _transfer(_company, tokenOwner, tokensToTransfer);
    }


}
