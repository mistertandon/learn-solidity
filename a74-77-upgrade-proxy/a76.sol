// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract CounterV1 {
    address public implementation;
    address public admin;
    uint256 public count;

    function increment() external {
        count += 1;
    }
}

contract CounterV2 {
    address public implementation;
    address public admin;
    uint256 public count;

    function increment() external {
        count += 1;
    }

    function decrement() external {
        count -= 1;
    }
}

contract Proxy {
    bytes32 public constant IMPLEMENTATION_SLOT =
        bytes32(uint256(keccak256("eip1967.proxy.implementation")) - 1);

    bytes32 public constant ADMIN_SLOT =
        bytes32(uint256(keccak256("eip1967.proxy.admin")) - 1);

    function _getAdmin() private view returns (address) {
        return StorageSlot.getAddressSlot(ADMIN_SLOT).value;
    }

    function _setAdmin(address _admin) private {
        require(_admin != address(0), "Adming address can'\t be ZERO");
        StorageSlot.getAddressSlot(ADMIN_SLOT).value = _admin;
    }

    function _getImplementation() private view returns (address) {
        return StorageSlot.getAddressSlot(IMPLEMENTATION_SLOT).value;
    }

    function _setImplementation(address _implementation) private {
        require(_implementation.code.length > 0, "Invalid contract");
        StorageSlot.getAddressSlot(IMPLEMENTATION_SLOT).value = _implementation;
    }

    function admin() external view returns (address) {
        return _getAdmin();
    }

    function implementation() external view returns (address) {
        return _getImplementation();
    }

    constructor() {
        _setAdmin(msg.sender);
    }

    function _delegate(address _implementation) private {
        assembly {
            calldatacopy(0, 0, calldatasize())

            let result := delegatecall(
                gas(),
                _implementation,
                0,
                calldatasize(),
                0,
                0
            )

            returndatacopy(0, 0, returndatasize())

            switch result
            case 0 {
                revert(0, returndatasize())
            }
            default {
                return(0, returndatasize())
            }
        }
    }

    fallback() external payable {
        _delegate(_getImplementation());
    }

    receive() external payable {
        _delegate(_getImplementation());
    }

    function upgradeTo(address _implementation) external {
        require(msg.sender == _getAdmin(), "Unauthorized access");
        _setImplementation(_implementation);
    }
}

library StorageSlot {
    struct AddressSlot {
        address value;
    }

    /**
        -   (AddressSlot storage r)
                Means we're returning pointer to the storage variable slot.
        -   Using this function we returns the pointer to storgae `r`, located at `slot` (
            input Argument to function
        )

    */
    function getAddressSlot(bytes32 slot)
        internal
        pure
        returns (AddressSlot storage r)
    {
        assembly {
            r.slot := slot
        }
    }
}

contract TestSlot {
    bytes32 public constant SLOT = keccak256("TEST_SLOT");

    function getSlot() external view returns (address) {
        return StorageSlot.getAddressSlot(SLOT).value;
    }

    function writeSLot(address _addr) external {
        StorageSlot.getAddressSlot(SLOT).value = _addr;
    }
}

/**
    When we put deployed BuggyProxy address while re-deploying CounterV1 contract in `At Address` field means
    we're going to be loading the interface for CounterV1 using the address and storage of BuggyProxy.
*/
