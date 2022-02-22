// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract ArrayReplace{
    uint256[] numArray;

    function getNumArray() public view returns (uint256[] memory){
        return numArray;
    }
    
    function addElement(uint element) external{
        numArray.push(element);
    }

    modifier validateNumArrayLength(uint idx){
        require(idx < numArray.length, "Array overflow");
        _;
    }

    function deleteElementAtIndex(uint idx) external validateNumArrayLength(idx){

        if(idx != numArray.length -1){
            numArray[idx] = numArray[numArray.length -1];
        }

        numArray.pop();
    }
}