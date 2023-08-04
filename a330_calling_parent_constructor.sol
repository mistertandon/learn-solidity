// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract S {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

contract T {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

contract U is S("Loreum"), T("mistertandon") {
    string public city;

    constructor(string memory _city) {
        city = _city;
    }
}

contract V is S, T {
    string public city;

    constructor(
        string memory _text,
        string memory _name,
        string memory _city
    ) S(_text) T(_name) {
        city = _city;
    }
}

contract VV is S("Loreum"), T {
    string public city;

    constructor(string memory _name, string memory _city) T(_name) {
        city = _city;
    }
}

contract V1 is S, T {
    string public city;

    constructor(
        string memory _text,
        string memory _name,
        string memory _city
    ) T(_name) S(_text) {
        city = _city;
    }
}

contract V2 is T, S {
    string public city;

    constructor(
        string memory _text,
        string memory _name,
        string memory _city
    ) T(_name) S(_text) {
        city = _city;
    }
}
