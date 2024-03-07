// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./MyToken.sol";

contract DiplomaRegistry {
    struct Diploma {
        uint ID_holder;
        string nom_EES;
        uint ID_EES;
        string country;
        string type_diploma;
        string speciality;
        string mention;
        string obtention_date;
    }

    mapping(uint => Diploma) public diplomas;

    MyToken public tokenContract;
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function.");
        _;
    }

    constructor (address _tokenAddress) {
        tokenContract = MyToken(_tokenAddress);
        owner = msg.sender;
    }

    function addDiploma(
        uint _idHolder,
        string memory _nomEstablishment,
        uint _idEstablishment,
        string memory _country,
        string memory _typeDiploma, 
        string memory _speciality, 
        string memory _mention,
        string memory _obtentionDate
        ) external onlyOwner {
            diplomas[_idHolder] = Diploma(_idHolder, _nomEstablishment, _idEstablishment, _country, _typeDiploma, _speciality, _mention, _obtentionDate);
        }
}
