// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract TestErrors{

    function testRequire(uint256 i) public pure returns (uint256){

        require(i > 10, "Passed arg must be greater than 10");

        return i;
    }

    function testRevert(uint256 i) public pure returns (uint256){

        if(i>0){
            if(1<50){
                if(i>10){
                    revert("0 < i < 10");
                }
            }
        }
        return i;
    }

    uint256 public num = 1111;

    function testAssert() public view {
        assert(num == 1111);
    }

    function updateStateVNum() external {
        num += 111;
        this.testAssert();
    } 

    error CustomError(address caller, uint256 i);

    function testCustomError(uint i) public view {

        if(i > 10){
            revert CustomError(msg.sender, i);
        }
    }
}