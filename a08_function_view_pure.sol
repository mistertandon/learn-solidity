// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract PureAndViewFunctions {
    uint256 stateVNum;

    function increaseStateVNum() external {
        stateVNum += 1;
    }

    function getStateVNum() external view returns (uint256) {
        return stateVNum;
    }

    function pureAndViewFunc(uint256 x) external view returns (uint256) {
        return stateVNum + x;
    }

    function pureFunc(uint256 x, uint256 y) external pure returns (uint256) {
        return x + y;
    }
}
