// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract CoinFlip {
    address public owner;

    event BetPlaced(address indexed player, uint256 betAmount, bool betOnHeads);
    event CoinFlipped(address indexed player, uint256 betAmount, bool betOnHeads, bool won);

    constructor() {
        owner = msg.sender;
    }

    
    modifier contractHasEnoughBalance(uint256 betAmount) {
        require(address(this).balance >= betAmount * 2, "Contract doesn't have enough balance.");
        _;
    }

    
    modifier validBet(uint256 betAmount) {
        require(betAmount > 0, "Bet amount must be greater than zero.");
        _;
    }

    function sendEtherToContract(uint256 amount) external payable{

        
    }




    function placeBet(bool betOnHeads) external payable validBet(msg.value) contractHasEnoughBalance(msg.value) {
        
        bool coinFlipResult = random() == 1;

        emit BetPlaced(msg.sender, msg.value, betOnHeads);

        
        if (coinFlipResult == betOnHeads) {
            uint256 winnings = msg.value * 2;
            payable(msg.sender).transfer(winnings);
            emit CoinFlipped(msg.sender, msg.value, betOnHeads, true);
        } else {
            emit CoinFlipped(msg.sender, msg.value, betOnHeads, false);
        }
    }

    function random() private view returns (uint8) {
        return uint8(uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, msg.sender))) % 2);
    }

    
    

    
    receive() external payable {}
}
