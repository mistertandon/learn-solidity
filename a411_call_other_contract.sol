// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract TestContract {
    uint256 public x;

    uint256 public value;

    function setX(uint256 _x) external {
        x = _x;
    }

    function getX() external view returns (uint256) {
        return x;
    }

    function setXAndReceiveEther(uint256 _x) external payable {
        x = _x;
        value = value + msg.value;
    }

    function getXAndValue() external view returns (uint256, uint256) {
        return (x, value);
    }
}

contract CallTestContract {
    function setX(TestContract ctrtAddr, uint256 _x) external {
        ctrtAddr.setX(_x);
    }

    function getX(TestContract ctrtAddr) external view returns (uint256) {
        return ctrtAddr.getX();
    }

    function setXAndReceiveEther(
        TestContract ctrtAddr,
        uint256 _x
    ) external payable {
        ctrtAddr.setXAndReceiveEther{value: msg.value}(_x);
    }

    function getXAndValue(
        TestContract ctrtAddr
    ) external view returns (uint256 x, uint256 value) {
        (uint256 _x, uint256 _value) = ctrtAddr.getXAndValue();

        x = _x;
        value = _value;
    }
}
