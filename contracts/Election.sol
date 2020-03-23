pragma solidity >=0.4.21;

contract Election {
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }
    // Read/write Candidates
    mapping(uint => Candidate) public candidates;
    // Store accounts that have voted
    mapping(address => bool) public voters;

    // Store Candidates Count
    uint public candidatesCount;

    function addCandidate (string memory _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    event votedEvent(

        uint indexed _candidateId

    );

    function vote (uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender]);

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        emit votedEvent(_candidateId);
    }


    constructor () public {
        addCandidate("DJ Trump");
        addCandidate("Sleepy Joe");
    }


}
