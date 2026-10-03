// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract PollingSystem {
    uint256 public pollCount;

    struct Poll {
        string title;
        string[] options;
        uint256 endTime;
        mapping(address => bool) hasVoted;
        mapping(uint256 => uint256) voteCount;
    }

    mapping(uint256 => Poll) private polls;

    // Create a new poll
    function createPoll(
        string calldata _title,
        string[] calldata _options,
        uint256 _durationInSeconds
    ) external returns (uint256) {
        require(bytes(_title).length > 0, "Title required");
        require(_options.length >= 2, "At least 2 options required");
        require(_durationInSeconds > 0, "Duration must be greater than 0");

        uint256 pollId = pollCount;
        pollCount++;

        Poll storage poll = polls[pollId];

        poll.title = _title;
        poll.endTime = block.timestamp + _durationInSeconds;

        for (uint256 i = 0; i < _options.length; i++) {
            require(bytes(_options[i]).length > 0, "Empty option");
            poll.options.push(_options[i]);
        }

        return pollId;
    }

    // Vote for an option
    function vote(
        uint256 _pollId,
        uint256 _optionIndex
    ) external {
        Poll storage poll = polls[_pollId];

        require(
            _pollId < pollCount,
            "Poll does not exist"
        );

        require(
            block.timestamp < poll.endTime,
            "Poll has ended"
        );

        require(
            !poll.hasVoted[msg.sender],
            "You have already voted"
        );

        require(
            _optionIndex < poll.options.length,
            "Invalid option"
        );

        poll.hasVoted[msg.sender] = true;
        poll.voteCount[_optionIndex]++;
    }

    // Get poll information
    function getPoll(
        uint256 _pollId
    )
        external
        view
        returns (
            string memory title,
            string[] memory options,
            uint256 endTime
        )
    {
        require(_pollId < pollCount, "Poll does not exist");

        Poll storage poll = polls[_pollId];

        return (
            poll.title,
            poll.options,
            poll.endTime
        );
    }

    // Get vote count for a specific option
    function getVoteCount(
        uint256 _pollId,
        uint256 _optionIndex
    ) external view returns (uint256) {
        require(_pollId < pollCount, "Poll does not exist");

        Poll storage poll = polls[_pollId];

        require(
            _optionIndex < poll.options.length,
            "Invalid option"
        );

        return poll.voteCount[_optionIndex];
    }

    // Check whether an address has voted
    function hasAddressVoted(
        uint256 _pollId,
        address _voter
    ) external view returns (bool) {
        require(_pollId < pollCount, "Poll does not exist");

        return polls[_pollId].hasVoted[_voter];
    }

    // Return winning option after poll ends
    function getWinner(
        uint256 _pollId
    ) external view returns (string memory winner) {
        require(_pollId < pollCount, "Poll does not exist");

        Poll storage poll = polls[_pollId];

        require(
            block.timestamp >= poll.endTime,
            "Poll is still active"
        );

        uint256 winningIndex = 0;
        uint256 highestVotes = 0;

        for (uint256 i = 0; i < poll.options.length; i++) {
            if (poll.voteCount[i] > highestVotes) {
                highestVotes = poll.voteCount[i];
                winningIndex = i;
            }
        }

        return poll.options[winningIndex];
    }
}