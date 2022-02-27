// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract TestContract{

    uint256 public x;

    uint256 public value;

    function setX(uint256 _x) external {
        x = _x;
    }

    function getX() external view returns (uint256){
        return x;
    }

    function setXAndReceiveEther(uint256 _x) external payable {
        x = _x;
        value = value + msg.value;
    }

    function getXAndValue() external view returns (uint256, uint256){
        return (x, value);
    }
}

contract CallTestContract{

    function setX(address ctrtAddr, uint256 _x) external {
        TestContract(ctrtAddr).setX(_x);
    }

    function getX(address ctrtAddr) external view returns (uint256){

        return TestContract(ctrtAddr).getX();
    }
}