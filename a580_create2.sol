// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract DeployWithCreate2 {
    address public owner;

    constructor(address _owner) {
        owner = _owner;
    }
}

/**
    Create tools allows use to compute the of the cotract that supposed to get deployed.
*/
contract Create2Factory {
    event Deploy(address addr);

    function deploy(uint256 _salt) external {
        DeployWithCreate2 _contract = new DeployWithCreate2{
            salt: bytes32(_salt)
        }(msg.sender);

        emit Deploy(address(_contract));
    }

    function getAddress(bytes memory bytecode, uint256 _salt)
        public
        view
        returns (address)
    {
        bytes32 hash = keccak256(
            abi.encodePacked(
                bytes1(0xff),
                address(this),
                _salt,
                keccak256(bytecode)
            )
        );

        // Last 20 bytes would be address
        return address(uint160(uint256(hash)));
    }

    /**
        To get the bytecode of contract to be deployed
    */
    function getByteCode(address _owner) public pure returns (bytes memory) {
        bytes memory bytecode = type(DeployWithCreate2).creationCode;
        return abi.encodePacked(bytecode, abi.encode(_owner));
    }
}

/*
    Run this contract by following below steps

    Step 1:
        Deply Create2Factory contract
            msg.sender : Address a [0x5B38Da6a701c568545dCfcB03FcB875f56beddC4]

    Step 2:
        call getByteCode
            getByteCode(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4)
            Output i.e. bytecode of `DeployWithCreate2`
            {
                "0": "bytes: 0x608060405234801561001057600080fd5b5060405161020d38038061020d833981810160405281019061003291906100db565b806000806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555050610108565b600080fd5b600073ffffffffffffffffffffffffffffffffffffffff82169050919050565b60006100a88261007d565b9050919050565b6100b88161009d565b81146100c357600080fd5b50565b6000815190506100d5816100af565b92915050565b6000602082840312156100f1576100f0610078565b5b60006100ff848285016100c6565b91505092915050565b60f7806101166000396000f3fe6080604052348015600f57600080fd5b506004361060285760003560e01c80638da5cb5b14602d575b600080fd5b60336047565b604051603e919060a8565b60405180910390f35b60008054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b600073ffffffffffffffffffffffffffffffffffffffff82169050919050565b6000609482606b565b9050919050565b60a281608b565b82525050565b600060208201905060bb6000830184609b565b9291505056fea264697066735822122057a3d232c6727a61e6cb49214bd5f88f1b0535b094eec63d4bfe805dd296e42564736f6c634300081200330000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc4"
            }
    Step 3:
        Call getAddress
             getAddress(
                    bytecode:   0x608060405234801561001057600080fd5b5060405161020d38038061020d833981810160405281019061003291906100db565b806000806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555050610108565b600080fd5b600073ffffffffffffffffffffffffffffffffffffffff82169050919050565b60006100a88261007d565b9050919050565b6100b88161009d565b81146100c357600080fd5b50565b6000815190506100d5816100af565b92915050565b6000602082840312156100f1576100f0610078565b5b60006100ff848285016100c6565b91505092915050565b60f7806101166000396000f3fe6080604052348015600f57600080fd5b506004361060285760003560e01c80638da5cb5b14602d575b600080fd5b60336047565b604051603e919060a8565b60405180910390f35b60008054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b600073ffffffffffffffffffffffffffffffffffffffff82169050919050565b6000609482606b565b9050919050565b60a281608b565b82525050565b600060208201905060bb6000830184609b565b9291505056fea264697066735822122057a3d232c6727a61e6cb49214bd5f88f1b0535b094eec63d4bfe805dd296e42564736f6c634300081200330000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc4
                    _salt:      777
                )
            Output in console
                from	        0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
                to	            Create2Factory.getAddress(bytes,uint256) 0xd9145CCE52D386f254917e481eB44e9943F39138
                execution cost	2553 gas (Cost only applies when called by a contract)
                input	        0x94c...00000
                decoded input	{
                                    "bytes bytecode": "0x608060405234801561001057600080fd5b5060405161020d38038061020d833981810160405281019061003291906100db565b806000806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555050610108565b600080fd5b600073ffffffffffffffffffffffffffffffffffffffff82169050919050565b60006100a88261007d565b9050919050565b6100b88161009d565b81146100c357600080fd5b50565b6000815190506100d5816100af565b92915050565b6000602082840312156100f1576100f0610078565b5b60006100ff848285016100c6565b91505092915050565b60f7806101166000396000f3fe6080604052348015600f57600080fd5b506004361060285760003560e01c80638da5cb5b14602d575b600080fd5b60336047565b604051603e919060a8565b60405180910390f35b60008054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b600073ffffffffffffffffffffffffffffffffffffffff82169050919050565b6000609482606b565b9050919050565b60a281608b565b82525050565b600060208201905060bb6000830184609b565b9291505056fea264697066735822122057a3d232c6727a61e6cb49214bd5f88f1b0535b094eec63d4bfe805dd296e42564736f6c634300081200330000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc4",
                                    "uint256 _salt": "777"
                                }
                decoded output	{
                                    "0": "address: 0x325135eB881299dE8c0691a7F226F423046f4Df3"
                                }
        Thus we expect contract to get deployed on `0x325135eB881299dE8c0691a7F226F423046f4Df3`

    Step 4: Call deploy
                deploy
                    _salt: 777
                Output in the console
                    status	            true Transaction mined and execution succeed
                    transaction hash	0x371accc4653e02a33488322646e025d8ca1c65acbecfca97e1cab7068bc90abf
                    block hash	        0x8509cd19ed974baf8fa3f4e11270b4136b87abaa6e02955a1b71aa1cbbdc6078
                    block number	    2
                    from	            0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
                    to	                Create2Factory.deploy(uint256) 0xd9145CCE52D386f254917e481eB44e9943F39138
                    gas	                146608 gas
                    transaction cost	127485 gas 
                    execution cost	    106269 gas 
                    input	            0xa5e...00309
                    decoded input	    {
                                            "uint256 _salt": "777"
                                        }
                    decoded output	    {}
                    logs	            [
                                            {
                                                "from": "0xd9145CCE52D386f254917e481eB44e9943F39138",
                                                "topic": "0x55ea6c6b31543d8e2ec6a72f71a79c0f4b72ed0d4757172b043d8f4f4cd84848",
                                                "event": "Deploy",
                                                "args": {
                                                    "0": "0x325135eB881299dE8c0691a7F226F423046f4Df3",
                                                    "addr": "0x325135eB881299dE8c0691a7F226F423046f4Df3"
                                                }
                                            }
                                        ]

*/