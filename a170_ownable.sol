// SPDX-License-Identifier:MIT

pragma solidity ^0.8.7;

contract Ownable {
    address public owner;
    uint256 public privateCounter;
    uint256 public publicCounter;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only ADMIN");
        _;
    }

    function setOwner(address _newAddress) external onlyOwner {
        owner = _newAddress;
    }

    function onlyOwnerCanCallThisFunction() external onlyOwner {
        privateCounter++;
    }

    function anyoneCanCallThisFunction() external {
        publicCounter++;
    }
}
