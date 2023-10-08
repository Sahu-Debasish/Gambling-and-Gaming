// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DiceGame {
    address public owner;
    uint public lastRoll;
    uint public betAmount;
    uint public jackpot;
    
    event Bet(address indexed player, uint indexed betAmount, uint indexed rollResult, bool isWinner);
    
    constructor() {
        owner = msg.sender;
        betAmount = 1 ether; // Default bet amount is 1 ether
        jackpot = 0;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }
    
    function setBetAmount(uint _betAmount) external onlyOwner {
        betAmount = _betAmount;
    }
    
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
    
    function rollDice() external payable {
        require(msg.value == betAmount, "Please send the correct bet amount");
        require(msg.value > 0 && msg.value <= getBalance(), "Bet amount exceeds available funds");
        
        // Generate a random number between 1 and 6
        uint random = uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, msg.sender))) % 6 + 1;
        
        // Check if the player wins (e.g., rolling a 6)
        bool isWinner = (random == 6);
        
        // If the player wins, they receive the jackpot; otherwise, the jackpot increases
        if (isWinner) {
            uint winnings = jackpot + betAmount;
            msg.sender.transfer(winnings);
            jackpot = 0;
        } else {
            jackpot += betAmount;
        }
        
        // Update the last roll and emit the Bet event
        lastRoll = random;
        emit Bet(msg.sender, msg.value, random, isWinner);
    }
    
    function withdrawFunds(uint amount) external onlyOwner {
        require(amount <= getBalance(), "Withdrawal amount exceeds available funds");
        payable(owner).transfer(amount);
    }
}
