// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FunctionModifer{

    bool public paused;

    uint256 public count;

    function setPaused(bool _paused) external {
        paused = _paused;
    }

    modifier whenNotPaused() {
        require(!paused, "Paused");
        _;
    }

    function increaseCount() external whenNotPaused {
        count+=1;
    }

    function decreaseCount() external whenNotPaused {
        count-=1;
    }    

    modifier upperRange(uint256 _x) {
        require(_x < 100, "Arg must be less than 100");
        _;
    }

    function increaseCountBy(uint256 _x) external whenNotPaused upperRange(_x) {
        count +=_x;
    }

    modifier sandwitch() {
        count += 2;
        _;
        count *= 2;
    }

    function multipleCountUpdate(uint256 _x) external sandwitch{
        count +=_x;
    }

}