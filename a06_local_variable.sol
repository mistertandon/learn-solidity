// SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;

contract LocalVariables{

    uint256 public stateVNumber;

    address public stateVAddress;

    function foo() external {

        uint256 localVNumber;
        address localVAddress;

        localVNumber +=10;
        localVAddress = address(10);

        stateVNumber +=5;
        stateVAddress = address(5);
    }
}