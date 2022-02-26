// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract HashFunction{
    function hash(string memory message, uint256 num, address addr) external pure returns (bytes32){

        return keccak256(abi.encodePacked(message, num, addr));
    }
}