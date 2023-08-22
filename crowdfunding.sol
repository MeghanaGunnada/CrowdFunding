// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Crowdfunding {
    address public creator;
    uint public goal;
    uint public raisedAmount;
    mapping(address => uint) public contributions;
    bool public fundingClosed;

    constructor(uint _goal) {
        creator = msg.sender;
        goal = _goal;
    }

    modifier onlyCreator() {
        require(msg.sender == creator, "Only the creator can call this function");
        _;
    }

    function contribute() external payable {
        require(!fundingClosed, "Funding is closed");
        contributions[msg.sender] += msg.value;
        raisedAmount += msg.value;
    }

    function withdrawFunds() external onlyCreator {
        require(raisedAmount >= goal, "Goal not reached");
        payable(creator).transfer(raisedAmount);
        fundingClosed = true;
    }

}
