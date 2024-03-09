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

    function setStudentInfo(
        PersonalInfo calldata _personalInfo,
        InternshipInfo calldata _internshipInfo
    ) external onlyEstablishment {
        students[msg.sender] = StudentInfo(
            _personalInfo,
            _internshipInfo
        );
      
    }

    function getStudent(address _studentAddress) external view returns (StudentInfo memory){
        return students[_studentAddress];
    }
}
