// SPDX-License-Identifier: MIT
pragma solidity ^0.5.15;

contract Voting {
    struct Candidate {
        uint id;
        string name;
        string party;
        uint voteCount;
        uint campaignId; // Campaign association
    }

    struct Campaign {
        uint id;
        string name;
        uint startDate;
        uint endDate;
    }

    mapping(uint => Candidate) public candidates;
    mapping(uint => Campaign) public campaigns;
    mapping(address => bool) public voters;

    uint public candidateCount;
    uint public campaignCount;

    // Add a new campaign
    function addCampaign(string memory name, uint startDate, uint endDate) public {
        campaignCount++;
        campaigns[campaignCount] = Campaign(campaignCount, name, startDate, endDate);
    }

    // Add a candidate to a specific campaign
    function addCandidate(string memory name, string memory party, uint campaignId) public {
        require(campaignId > 0 && campaignId <= campaignCount, "Invalid campaign ID");
        candidateCount++;
        candidates[candidateCount] = Candidate(candidateCount, name, party, 0, campaignId);
    }

    // Fetch candidate details
    function getCandidate(uint candidateId) public view returns (uint, string memory, string memory, uint, uint) {
        Candidate memory c = candidates[candidateId];
        return (c.id, c.name, c.party, c.voteCount, c.campaignId);
    }

    // Fetch all campaigns
    function getCampaign(uint campaignId) public view returns (uint, string memory, uint, uint) {
        Campaign memory c = campaigns[campaignId];
        return (c.id, c.name, c.startDate, c.endDate);
    }

    // Voting logic remains similar
    function vote(uint candidateId) public {
        require(!voters[msg.sender], "You have already voted");
        require(candidates[candidateId].id != 0, "Invalid candidate ID");

        voters[msg.sender] = true;
        candidates[candidateId].voteCount++;
    }
    
}
