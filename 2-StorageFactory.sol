// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

// It's like pasting everything in the file "1-SimpleStorage.sol"
import "./1-SimpleStorage.sol";

// Inheritance:
//      contract StorageFactory is SimpleStorage {}
// inherits all functions and variables of "SimpleStorage"
contract StorageFactory {
    SimpleStorage[] public simpleStorageArray;

    // Deploys "SimpleStorage" contracts to the blockchain
    function createSimpleStorageContract() public {
        // New object of contract "SimpleStorage"
        SimpleStorage simpleStorage = new SimpleStorage();
        // Keep track of the deployed contracts
        simpleStorageArray.push(simpleStorage);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber)
        public
    {
        // Need to pass the address of the deployed smart contract "SimpleStorage"
        SimpleStorage simpleStorage = SimpleStorage(
            address(simpleStorageArray[_simpleStorageIndex])
        );
        // Call function in "SimpleStorage" contract
        simpleStorage.store(_simpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        //SimpleStorage simpleStorage = SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]));
        //return simpleStorage.retrieve();
        return
            SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]))
                .retrieve(); // Equivalent to the above
    }
}
