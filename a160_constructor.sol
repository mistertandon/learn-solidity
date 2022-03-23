// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Constructor{

    uint256 public num;

    address public addr;

    constructor(uint256 _num){
        num = _num;
        addr = msg.sender;
    }
}