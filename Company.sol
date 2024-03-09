// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

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
}
