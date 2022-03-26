// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract A{

    function foo() public pure virtual returns (string memory){
        return "A:foo()";
    }

    function bar() public pure virtual returns (string memory){
        return "A:bar()";
    }

    function baz() public pure returns (string memory){
        return "A:baz()";
    }    
}

contract B is A{

    function foo() public pure override returns (string memory){
        return "B:foo()";
    }

    function bar() public pure override returns (string memory){
        return "B:bar()";
    }
}