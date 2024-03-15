// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Student.sol";

contract Company {
    struct CompanyInfo {
        string name;
        string sector;
        string creation_date;
        string classification_size;
        string country;
        string company_address;
        string email;
        string phone;
        string web_site_url;
        bool isRegistered;
    }

    mapping(address => CompanyInfo) public companies;
    Student public studentContract;

    // Contract constructor dependency (Establishment contract address)
    constructor(address _studentContractAddress) {
        studentContract = Student(_studentContractAddress);
    }

    modifier onlyCompany() {
        require(bytes(companies[msg.sender].name).length > 0, "Only Company can do this.");
        _;
    }

    function checkIfCompany(address _address) public view returns (bool){
        return bytes(companies[_address].name).length > 0;
    }

    event CompanyRegistered(
        address indexed companyAddress,
        string name,
        string sector,
        string creation_date,
        string classification_size,
        string country,
        string company_address,
        string email,
        string phone,
        string web_site_url
        );

    function addCompany(
        string memory _name,
        string memory _sector,
        string memory _creation_date,
        string memory _classification_size,
        string memory _country,
        string memory _company_address,
        string memory _email,
        string memory _phone,
        string memory _web_site_url
    ) external {
        require(bytes(_name).length > 0, "Company Name cannot be empty.");
        require(bytes(_email).length > 0, "Company Email cannot be empty");
        require(companies[msg.sender].isRegistered == false, "Company already registered");
        //other check ?

        companies[msg.sender] = CompanyInfo(_name, _sector, _creation_date, _classification_size, _country, _company_address, _email, _phone, _web_site_url, true);

        emit CompanyRegistered(msg.sender, _name, _sector, _creation_date, _classification_size, _country, _company_address, _email, _phone, _web_site_url);
    }

    function EvaluateStudent (address _studentAddress, string memory _evaluation) external onlyCompany {
        require(studentContract.checkIfStudentExist(_studentAddress), "Student does not exist");
        Student.PersonalInfo memory _personalInfo = studentContract.getStudent(_studentAddress).personalInfo;
        Student.InternshipInfo memory _internshipInfo = studentContract.getStudent(_studentAddress).internshipInfo;
        _internshipInfo.evaluation = _evaluation;
        studentContract.updateStudentInfo(_studentAddress, _personalInfo, _internshipInfo);
    }
}
 