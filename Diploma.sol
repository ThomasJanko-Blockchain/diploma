// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./MyToken.sol";
import "./Establishment.sol";
import "./Student.sol";

contract Diploma {
    struct DiplomaInfo {
        address ID_holder;
        string nom_EES;
        uint ID_EES;
        string country;
        string type_diploma;
        string speciality;
        string mention;
        string obtention_date;
    }

    mapping(address => DiplomaInfo) public diplomas;
    Establishment public establishmentContract;
    Student public studentContract;

    //onlyEstablishment can add a diploma
    modifier onlyEstablishment() {
        require(establishmentContract.checkIfEstablishment(msg.sender), "Only establishment can do this.");
        _;
    }

    //check if the sender is an establishment
    function checkIfSenderIsEstablishment() public view returns (bool){
        return establishmentContract.checkIfEstablishment(msg.sender);
    }

    //can be set to private
    function checkIfStudentExist(address _idHolder) public view returns (bool){
        return studentContract.checkIfStudentExist(_idHolder);
    }

    constructor(address _establishmentContractAddress, address _studentContractAddress) {
        establishmentContract = Establishment(_establishmentContractAddress);
        studentContract = Student(_studentContractAddress);
    }

    //add a diploma
    function addDiploma(
        address _idHolder,
        string memory _nomEstablishment,
        uint _idEstablishment,
        string memory _country,
        string memory _typeDiploma, 
        string memory _speciality, 
        string memory _mention,
        string memory _obtentionDate
        ) external onlyEstablishment {
            require(studentContract.checkIfStudentExist(_idHolder), "Student does not exist");
            diplomas[_idHolder] = DiplomaInfo(
                _idHolder,
                _nomEstablishment,
                _idEstablishment,
                _country,
                _typeDiploma,
                _speciality,
                _mention,
                _obtentionDate
            );
        }

    function getDiploma(address _idHolder) public view returns (DiplomaInfo memory){
        require(studentContract.checkIfStudentExist(_idHolder), "This student does not exist");
        require(diplomas[_idHolder].ID_holder == _idHolder, "This student does not have a diploma");
        return diplomas[_idHolder];
    }

}
