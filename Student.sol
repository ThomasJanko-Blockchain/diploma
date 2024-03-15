// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Establishment.sol";
import "./Diploma.sol";

contract Student {
    struct PersonalInfo {
        address studentAddress;
        string firstName;
        string lastName;
        string birthday;
        string sexe;
        string nationality;
        string civilityStatus;
        string homeAddress;
        string courriel;
        string phone;
    }

    struct InternshipInfo {
        string section;
        string subjectPfe;
        string enterpriseInternshipPfe;
        string fullnameInternshipMaster;
        string dateStartInternship;
        string dateEndInternship;
        string evaluation;
    }

    struct StudentInfo {
        PersonalInfo personalInfo;
        InternshipInfo internshipInfo;
    }

    mapping(address => StudentInfo) public students;
    Establishment public establishmentContract;
    // Diploma public diplomaContract;

    // Contract constructor dependency (Establishment contract address)
    constructor(address _establishmentContractAddress, address _diplomaContractAddress) {
        establishmentContract = Establishment(_establishmentContractAddress);
        // diplomaContract = Diploma(_diplomaContractAddress);
    }

    //check if the sender is an establishment (modifier)
    modifier onlyEstablishment() {
        require(establishmentContract.checkIfEstablishment(msg.sender), "Only establishment can do this.");
        _;
    }

    //check if the sender is an establishment
    function checkIfSenderIsEstablishment() public view returns (bool){
        return establishmentContract.checkIfEstablishment(msg.sender);
    }

    //check if the student exist
    function checkIfStudentExist(address _studentAddress) public view returns (bool){
        return bytes(students[_studentAddress].personalInfo.firstName).length > 0;
    }

    // add a student
    function setStudentInfo(
        PersonalInfo calldata _personalInfo,
        InternshipInfo calldata _internshipInfo
    ) external onlyEstablishment {
        //create a new student with the address sudentAddress
        students[_personalInfo.studentAddress] = StudentInfo(
            _personalInfo,
            _internshipInfo
        );
        
    }

    // update a student
    function updateStudentInfo(
        address _studentAddress,
        PersonalInfo calldata _personalInfo,
        InternshipInfo calldata _internshipInfo
    ) external onlyEstablishment {
        students[_studentAddress] = StudentInfo(
            _personalInfo,
            _internshipInfo
        );
    }

    // get a student (address)
    function getStudent(address _studentAddress) external view returns (StudentInfo memory){
        return students[_studentAddress];
    }

    // get diploma of msg.sender ID_holder
    // function seeDiploma() public view returns (Diploma.DiplomaInfo memory){
    //     require(diplomaContract.checkIfStudentExist(msg.sender), "Student does not exist");
    //     return diplomaContract.getDiploma(msg.sender);
    // }
    
}

// ["studentAddress", "firstName", "lastName", "birthday", "sexe", "nationality", "civilityStatus", "homeAddress", "courriel", "phone"]
// ["0xC69B6fd033e8b4C9c3BD2A322B3Fa754010dd68E", "Jhon", "Doe", "01/01/1990", "M", "French", "Single", "1 rue de la paix, Paris", "Joohn@lepauvre.com", "06 12 34 56 78"]
// ["section", "subjectPfe", "enterpriseInternshipPfe", "fullnameInternshipMaster", "dateStartInternship", "dateEndInternship", "evaluation"]
// ["Computer Science", "Blockchain", "IBM", "John Smith", "01/01/2021", "01/07/2021", "A"]
