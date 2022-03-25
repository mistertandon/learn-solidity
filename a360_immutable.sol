// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Constant{

    address public owner;

    uint256 public count;

    constructor(){
        owner = msg.sender;
    }

    function foo() external {
        require(owner == msg.sender, "Not Authorized");
        count++;
    }
}

contract Immutable{

    address public immutable owner;

    uint256 public count;

    constructor(){
        owner = msg.sender;
    }

    function foo() external {
        require(owner == msg.sender, "Not Authorized");
        count++;
    }    
}