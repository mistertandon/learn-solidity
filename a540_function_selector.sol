// SPDEX-License-Identifier: MIT
pragma solidity ^0.8.5;

contract ParentContract {
    function getSelector(string calldata _func) external pure returns (bytes4) {
        return bytes4(keccak256(bytes(_func)));
    }
}

contract ChildContract {
    event Log(bytes data);

    function transfer(address _to, uint _amount) external {
        emit Log(msg.data);
    }
}
/*
Log(msg.data);
[
	{
		"from": "0xD7ACd2a9FD159E69Bb102A1ca21C9a3e3A5F771B",
		"topic": "0xafabcf2dd47e06a477a89e49c03f8ebe8e0a7e94f775b25bbb24227c9d0110b2",
		"event": "Log",
		"args": {
			"0": "0xa9059cbb0000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc40000000000000000000000000000000000000000000000000000000000000001",
			"data": "0xa9059cbb0000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc40000000000000000000000000000000000000000000000000000000000000001"
		}
	}
]

function signature 0xa9059cbb
address _to  0000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc4
uint _amount 0000000000000000000000000000000000000000000000000000000000000001


getSelector("transfer(address, uint)")
0x9e17553b
*/
