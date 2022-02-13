// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract StateVariable{
    string public name = "My name is state variable";

    function foo() external {
        string memory nickName ="My name is local variable";
    }
}