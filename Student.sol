// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Establishment.sol";

contract Student {
    struct PersonalInfo {
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
    
    modifier onlyEstablishment() {
        require(establishmentContract.isEstablishment(msg.sender), "Only establishment can add a student");
        _;
    }

    constructor(address _establishmentContractAddress) {
        establishmentContract = Establishment(_establishmentContractAddress);
    }

    function setPersonalInfo(
        string memory _firstName,
        string memory _lastName,
        string memory _birthday,
        string memory _sexe,
        string memory _nationality,
        string memory _civilityStatus,
        string memory _homeAddress,
        string memory _courriel,
        string memory _phone
    ) external onlyEstablishment {
        students[msg.sender].personalInfo = PersonalInfo(
            _firstName,
            _lastName,
            _birthday,
            _sexe,
            _nationality,
            _civilityStatus,
            _homeAddress,
            _courriel,
            _phone
        );
    }

    function setInternshipInfo(
        string memory _section,
        string memory _subjectPfe,
        string memory _enterpriseInternshipPfe,
        string memory _fullnameInternshipMaster,
        string memory _dateStartInternship,
        string memory _dateEndInternship,
        string memory _evaluation
    ) external {
        students[msg.sender].internshipInfo = InternshipInfo(
            _section,
            _subjectPfe,
            _enterpriseInternshipPfe,
            _fullnameInternshipMaster,
            _dateStartInternship,
            _dateEndInternship,
            _evaluation
        );
    }

    function getStudent(address _studentAddress) external view returns (StudentInfo memory){
        return students[_studentAddress];
    }
}
