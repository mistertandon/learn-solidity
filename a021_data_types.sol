// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract DataTypes {
    uint public age;

    int public balance;

    bool public isApproved = true;

    bool public isDone;

    address public myEth = 0x4838B106FCe9647Bdf1E7877BF73cE8B0BAD5f97;

    string public cipherTxt = "Crypto";

    uint[4] public priceTracker = [100, 140, 80, 105];

    string[] public gradeTracker = ["A", "A++", "B++", "A"];

    uint[] public items;

    function addItem(uint item) public {
        items.push(item);
    }
}
