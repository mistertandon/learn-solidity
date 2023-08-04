// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract ArFixeday {
    uint256[3] public fixedNum = [1, 2, 3];

    modifier validateArrayLength(uint256 _idx) {
        require(_idx <= fixedNum.length - 1, "Index overflow");
        _;
    }

    function deleteElementAtIdx(
        uint256 _idx
    ) external validateArrayLength(_idx) {
        delete fixedNum[_idx];
    }

    function updateElementAtIdx(
        uint256 _idx,
        uint256 _val
    ) external validateArrayLength(_idx) {
        fixedNum[_idx] = _val;
    }

    function getNumArray() external view returns (uint256[3] memory) {
        return fixedNum;
    }
}
