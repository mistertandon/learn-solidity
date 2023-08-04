// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ArrayShift {
    uint256[] public numArray;

    function getNumArray() public view returns (uint256[] memory) {
        return numArray;
    }

    function addElement(uint256 _element) public {
        numArray.push(_element);
    }

    modifier validateNumArrayLength(uint256 _idx) {
        require(_idx < numArray.length, "Array overflow");
        _;
    }

    function deleteElementAtIndex(
        uint256 _idx
    ) public validateNumArrayLength(_idx) {
        for (uint256 i = _idx; i < numArray.length - 1; i++) {
            numArray[i] = numArray[i + 1];
        }

        numArray.pop();
    }
}
