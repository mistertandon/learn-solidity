//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Test {
    function func1() external view returns (uint256, uint256) {
        return (1, block.timestamp);
    }

    function func2() external view returns (uint256, uint256) {
        return (2, block.timestamp);
    }

    function getData1() external pure returns (bytes memory) {
        return abi.encodeWithSelector(this.func1.selector);
    }

    function getData2() external pure returns (bytes memory) {
        return abi.encodeWithSelector(this.func2.selector);
    }    
}

contract MultiCall {
    function caller(address[] calldata targets, bytes[] calldata data)
        external
        view
        returns (bytes[] memory)
    {
        require(targets.length == data.length, "targets.length != data.length");

        bytes[] memory results = new bytes[](targets.length);

        for (uint256 i; i < targets.length; i++) {
            // Read difference between targets[i].staticcall and targets[i].call
            (bool success, bytes memory result) = targets[i].staticcall(
                data[i]
            );

            require(success, "Call failed");
            results[i] = result;
        }
        return results;
    }
}
/*
    Deployed contracts
        TEST        [0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8]
        MULTICALL   [0xd9145CCE52D386f254917e481eB44e9943F39138]

    Step 1: 
        Run TEST -> getData1
        Remix Logs
            from	        0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
            to	            Test.getData1() 0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8
            execution cost	800 gas (Cost only applies when called by a contract)
            input	        0x994...4cc71
            decoded input	{}
            decoded output	{
                                "0": "bytes: 0x74135154"
                            }
            logs        	[]
    Step 2:
         Run TEST -> getData2
            from	        0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
            to	            Test.getData2() 0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8
            execution cost	822 gas (Cost only applies when called by a contract)
            input	        0xa89...8fd70
            decoded input	{}
            decoded output	{
                                "0": "bytes: 0xb1ade4db"
                            }
            logs	        []
    Step 3:
        Run MultiCall -> caller
            Arguments
                targets ["0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8", "0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8"]
                data    ["0x74135154", "0xb1ade4db"]

        Remix logs
            from	        0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
            to	            MultiCall.caller(address[],bytes[]) 0xd9145CCE52D386f254917e481eB44e9943F39138
            execution cost	9050 gas (Cost only applies when called by a contract)
            input	        0x995...00000
            decoded input	{
                                "address[] targets": [
                                    "0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8",
                                    "0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8"
                                ],
                                "bytes[] data": [
                                    "0x74135154",
                                    "0xb1ade4db"
                                ]
                            }
            decoded output	{
                                "0": "bytes[]: 0x00000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000064e29580,0x00000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000064e29580"
                            }
            logs	        []
*/