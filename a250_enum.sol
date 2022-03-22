// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Enum{
    enum Status{
        None,
        Pending,
        Shipped,
        Completed,
        Rejected,
        Cancelled
    }

    Status public status;

    struct Order{
        address buyer;
        Status status;
    }

    Order[] public orders;

    function get() view external returns (Status){
        return status;
    }

    function ship() external {
        status = Status.Shipped;
    }

    function reset() external {
        delete status;
    }
}