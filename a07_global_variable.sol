// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract GlobalVariable {
    function globalVars() external view returns (address, uint256, uint256) {
        address sender = msg.sender;
        uint256 blockNum = block.number;
        uint256 blcokTimestamp = block.timestamp;

        return (sender, blockNum, blcokTimestamp);
    }
}
