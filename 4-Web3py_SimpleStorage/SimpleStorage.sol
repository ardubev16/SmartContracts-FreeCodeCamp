// SPDX-License-Identifier: MIT

// Solidity version:    1. Range: >=0.6.0 <0.9.0
//                      2. All versions of major release: ^0.6.0 ( >=0.6.0 <0.7.0 )
pragma solidity ^0.6.0;

// Contract is like a class in OOP
contract SimpleStorage {
    /*      Basic variable types:
        int256 sample_int = -5;
        uint256 sample_uint = 5;
        bool sample_bool = true;
        string sample_string = "string";
        address sample_address = 0x2fd4B1baC49b869657F5d4FC03d6e47378A715E2;
        bytes32 sample_bytes = "cat";
    */

    // Structs:
    struct People {
        uint256 number;
        string name;
    }

    // Staic array: e.g. uint256[3] name;
    // Dynamic array:
    People[] public people;

    // Map datastructure, maps string to uint
    mapping(string => uint256) public nameToNumber;

    // initialized to 0
    uint256 number;

    function store(uint256 _number) public {
        number = _number;
    }

    function retrieve() public view returns (uint256) {
        return number;
    }

    function addPerson(string memory _name, uint256 _number) public {
        // Use "push" method to add elements to arrays
        //people.push(People({number: _number, name: _name}));
        people.push(People(_number, _name)); // this is equivalent to the above

        // Adds _number "value" to _name "key" in the map
        nameToNumber[_name] = _number;
    }
}
