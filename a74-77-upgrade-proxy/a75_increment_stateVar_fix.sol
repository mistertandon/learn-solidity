// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract CounterV1 {
    uint256 public count;

    function increment() external {
        count += 1;
    }
}

contract CounterV2 {
    uint256 public count;

    function increment() external {
        count += 1;
    }

    function decrement() external {
        count -= 1;
    }
}

contract BuggyProxy {
    address public implementation;
    address public admin;

    constructor() {
        admin = msg.sender;
    }

    function _delegate() private {
        (bool ok, ) = implementation.delegatecall(msg.data);
        require(ok, "delegateCall failed");
    }

    fallback() external payable {
        _delegate();
    }

    receive() external payable {
        _delegate();
    }

    function upgradeTo(address _implementation) external {
        require(msg.sender == admin, "Unauthorized access");
        implementation = _implementation;
    }
}
