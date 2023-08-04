// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Array {
    uint256[] public num = [1, 2, 3];

    modifier validateArrayLength(uint256 _idx) {
        require(_idx <= num.length - 1, "Index overflow");
        _;
    }

    function deleteElementAtIdx(
        uint256 _idx
    ) external validateArrayLength(_idx) {
        delete num[_idx];
    }

    function add(uint256 element) external {
        num.push(element);
    }

    function updateElementAtIdx(
        uint256 _idx,
        uint256 _val
    ) external validateArrayLength(_idx) {
        num[_idx] = _val;
    }

    function getNumArray() external view returns (uint256[] memory) {
        return num;
    }
}
