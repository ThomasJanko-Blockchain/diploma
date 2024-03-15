// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Establishment {

    struct EstablishmentInfo {
        string name;
        string establishment_type;
        string country;
        string establishment_address;
        string web_site_url;
        uint ID_agent;
    }

    mapping (address => EstablishmentInfo) public establishments;

    modifier onlyEstablishment() {
        require(bytes(establishments[msg.sender].name).length > 0, "Only establishment can do this.");
        _;
    }

    function checkIfEstablishment(address _address) public view returns (bool){
        return bytes(establishments[_address].name).length > 0;
    }

    event EstablishmentAdded(
        address indexed agentAddress,
        string _name,
        string _establishmentType,
        string _country,
        string _establishmentAddress,
        string _webSiteUrl
    );

    modifier onlyAgent() {
        require(bytes(establishments[msg.sender].name).length > 0, "Only agent of establishment can do this.");
        _;
    }

    function addEstablishment(
        string memory _name,
        string memory _establishmentType,
        string memory _country,
        string memory _establishmentAddress,
        string memory _webSiteUrl,
        uint _IDAgent
    ) external {

        require(bytes(_name).length > 0, "Name cannot be empty");
        require(bytes(_establishmentType).length > 0, "Establishment type cannot be empty");
        require(bytes(_country).length > 0, "Country cannot be empty");
        require(bytes(_establishmentAddress).length > 0, "Establishment address cannot be empty");
        require(_IDAgent > 0, "ID agent cannot be empty");

        establishments[msg.sender] = EstablishmentInfo(_name,
        _establishmentType,
        _country,
        _establishmentAddress,
        _webSiteUrl,
        _IDAgent);

        emit EstablishmentAdded(msg.sender, _name, _establishmentType, _country, _establishmentAddress, _webSiteUrl);
    }

}