//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Event {
    event Log(string message, uint256 val);

    event IndexedLog(address indexed sender, uint256 val);

    function foo() external {
        emit Log("Solidity event", 18100000);
    }

    function bar() external {
        emit IndexedLog(msg.sender, 19100000);
    }
}
