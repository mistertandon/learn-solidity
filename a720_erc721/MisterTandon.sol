// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts@4.9.3/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.9.3/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.9.3/security/Pausable.sol";
import "@openzeppelin/contracts@4.9.3/access/Ownable.sol";
import "@openzeppelin/contracts@4.9.3/utils/Counters.sol";

contract Mistertandon is ERC721, ERC721Enumerable, Pausable, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    uint256 public MINT_PRICE = 0.05 ether;
    uint256 public MAX_SUPPLY = 1000;

    constructor() ERC721("Mistertandon", "MT") {
        
    }

    function withdraw() public onlyOwner(){
        require(address(this).balance > 0, "Contract balanace is ZERO");
        // require(msg.sender === )
        payable(owner()).transfer(address(this).balance);
    }

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://chatgpt-plus.in/";
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function safeMint(address to) public payable {
        require(totalSupply() < MAX_SUPPLY, "Maximum allowed token have already been minted");
        require(msg.value >= MINT_PRICE, "Not enough ether send for minting");
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId,
        uint256 batchSize
    ) internal override(ERC721, ERC721Enumerable) whenNotPaused {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    // The following functions are overrides required by Solidity.

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
/*
    Complitaion steps:
    Step 1: 
        ENVIRONMENT - Remix VM (Shanghai)
        ACCOUNT - Address 1 [0x5B38Da6a701c568545dCfcB03FcB875f56beddC4]
        CONTRACT - Mistertandon - MisterTandon.sol [0x9D7f74d0C41E726EC95884E0e97Fa6129e3b5E99]
        Click on compile button
        Logs after deployment

        transaction hash	0xca6ac1cbe45ce18538f115433ae690f4c21bebff87089cb7fdc1a78ac1150192
        block hash	        0x552eadb73a26f52d75712b9446aa7edaf4d89e3dae9477dfcc36436f4dac2ae4
        block number	    1
        contract address	0xd9145CCE52D386f254917e481eB44e9943F39138
        from	            0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
        to	                Mistertandon.(constructor)
        gas	                3853755 gas
        transaction cost	3352059 gas 
        execution cost	    3074107 gas 
        input	            0x608...90033
        decoded input	    {}
        decoded output	    - 
        logs	[
            {
                "from": "0xd9145CCE52D386f254917e481eB44e9943F39138",
                "topic": "0x8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e0",
                "event": "OwnershipTransferred",
                "args": {
                    "0": "0x0000000000000000000000000000000000000000",
                    "1": "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",
                    "previousOwner": "0x0000000000000000000000000000000000000000",
                    "newOwner": "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4"
                }
            }
        ]

    Step 2:
        ACCOUNT         Address 2 [0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2]
        VALUE           1 Ether
        Fn-safeMint     Address 2
            LOGS in Remix Console
                status	            true Transaction mined and execution succeed
                transaction hash	0x70e739707df3e2687660b420301cec5bae18a4460066b85858aad8cb1e056b4f
                block hash	        0xb63091b0e609ed74b09c76bdf49518422cb92a1619d86812c5d3f9c8f594c31e
                block number	    13
                from	            0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
                to	                Mistertandon.safeMint(address) 0x9D7f74d0C41E726EC95884E0e97Fa6129e3b5E99
                gas	                150146 gas
                transaction cost	130561 gas 
                execution cost	    109129 gas 
                input	            0x40d...35cb2
                decoded input	    {
                                        "address to": "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2"
                                    }
                decoded output	    {}
                logs	            [
                                        {
                                            "from": "0x9D7f74d0C41E726EC95884E0e97Fa6129e3b5E99",
                                            "topic": "0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef",
                                            "event": "Transfer",
                                            "args": {
                                                "0": "0x0000000000000000000000000000000000000000",
                                                "1": "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",
                                                "2": "0",
                                                "from": "0x0000000000000000000000000000000000000000",
                                                "to": "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",
                                                "tokenId": "0"
                                            }
                                        }
                                    ]
                val	1000000000000000000 wei

    Step 3: Owner of tokenId
        Fn-ownerOf      0
            LOGS in Remix Console
                from	        0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
                to	            Mistertandon.ownerOf(uint256) 0x9D7f74d0C41E726EC95884E0e97Fa6129e3b5E99
                execution cost	3004 gas (Cost only applies when called by a contract)
                input	        0x635...00000
                decoded input	{
                                    "uint256 tokenId": "0"
                                }
                decoded output	{
                                    "0": "address: 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2"
                                }
                logs	        []

    Step 4: Now switch to Address-2 [Current owner of NFT], and transfer NFT at Address-2 to Address-3 using transferFrom function
    Address-2 [0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2]
    Address-3 [0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db]

        ACCOUNT     Account-2 [0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2, Current owner of NFT]
        Fn-transferFrom
            From    [0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2]
            To      [0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db]
            tokenId 0
                LOGS in Remix Console
                    status	            true Transaction mined and execution succeed
                    transaction hash	0xbbf4636a86320491c7cc4a13c0d7978cc010d7c7b8f72c9e93202329262cfbbc
                    block hash	        0xaceb4186ee2131b3a07a4fe5be242c2c36d11543c8388ad43de95a7874e71be5
                    block number	    19
                    from	            0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
                    to	                Mistertandon.transferFrom(address,address,uint256) 0x9D7f74d0C41E726EC95884E0e97Fa6129e3b5E99
                    gas	                88046 gas
                    transaction cost	66961 gas 
                    execution cost	    49833 gas 
                    input	            0x23b...00000
                    decoded input	    {
                                            "address from": "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",
                                            "address to": "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db",
                                            "uint256 tokenId": "0"
                                        }
                    decoded output	    {}
                    logs	            [
                                            {
                                                "from": "0x9D7f74d0C41E726EC95884E0e97Fa6129e3b5E99",
                                                "topic": "0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef",
                                                "event": "Transfer",
                                                "args": {
                                                    "0": "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",
                                                    "1": "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db",
                                                    "2": "0",
                                                    "from": "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",
                                                    "to": "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db",
                                                    "tokenId": "0"
                                                }
                                            }
                                        ]
                    val	                0 wei
    Step 4: withdraw function
        Only owner of the contract must be able to call this function i..e Address-1 [0x5B38Da6a701c568545dCfcB03FcB875f56beddC4] 


*/