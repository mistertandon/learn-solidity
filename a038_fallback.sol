// SPDX-License-Identifier:MIT

pragma solidity ^0.8.7;

contract Fallback{

    constructor() payable {

    }
    
    event Log(string func, address sender, uint256 val, bytes data);

    fallback() external payable {
        emit Log("fallback", msg.sender, msg.value, msg.data);
    }

    receive() external payable {
        emit Log("receive", msg.sender, msg.value, "");
    }    
}