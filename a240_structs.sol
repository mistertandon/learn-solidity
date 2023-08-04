// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Structs {
    struct Car {
        string model;
        uint256 year;
        address owner;
    }

    Car public car;

    Car[] public cars;

    mapping(address => Car) public carsByOwner;

    function getCars() external view returns (Car[] memory) {
        return cars;
    }

    function StructExample() external {
        Car memory maruti = Car("Maruti", 1990, address(1));
        cars.push(maruti);
        carsByOwner[address(1)] = maruti;

        Car memory toyota = Car({
            model: "Toyota",
            year: 2000,
            owner: address(2)
        });
        cars.push(toyota);
        carsByOwner[address(2)] = toyota;

        Car memory honda;
        honda.model = "Honda";
        honda.year = 2005;
        honda.owner = address(3);
        cars.push(honda);
        carsByOwner[address(3)] = honda;
    }

    function StructStorageExample() external {
        Car storage marutiCar = cars[0];
        marutiCar.year = 1990;
        delete marutiCar.year;

        Car memory toyota = cars[1];
        delete toyota;
    }
}
