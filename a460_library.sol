// SPDX-License-identifier: MIT

pragma solidity ^0.8.7;

library ArrayLib{
    function find(uint256[] storage _arr, uint256 element) internal view returns (uint256){

        for(uint256 i=0; i< _arr.length; i++){
            if(_arr[i] == element){
                return i;
            }
        }

        revert("No element found");
    }
}

contract TestArray{

    uint256[] public arr = [1, 2, 3];

    function findElement(uint x) external view returns (uint256) {
        uint256 keyResult = ArrayLib.find(arr, x);

        return keyResult;
    }
}