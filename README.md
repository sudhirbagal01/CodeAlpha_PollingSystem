# CodeAlpha Polling System Smart Contract

A decentralized Polling System Smart Contract developed as part of the CodeAlpha Blockchain Development Internship.

## Project Overview

This project implements a blockchain-based polling system using Solidity.

Users can create polls with multiple options, vote for an option, and determine the winning option after the voting deadline.

## Features

- Create polls with a title and multiple options
- Set a voting deadline
- Allow users to vote before the deadline
- Prevent the same address from voting more than once
- Store votes using Solidity mappings
- Count votes for each option
- Determine the winning option after the poll ends

## Technology Used

- Solidity
- Ethereum
- Remix IDE
- Ethereum Virtual Machine (EVM)

## Smart Contract Functions

### `createPoll()`

Creates a new poll with:

- Poll title
- Multiple options
- Voting duration

### `vote()`

Allows an address to vote for one option before the poll deadline.

Each address can vote only once per poll.

### `getPoll()`

Returns the poll title, available options, and ending time.

### `getVoteCount()`

Returns the number of votes received by a specific option.

### `hasAddressVoted()`

Checks whether a particular address has already voted in a poll.

### `getWinner()`

Returns the winning option after the voting deadline has passed.

## Testing

The contract was compiled, deployed, and tested successfully using Remix IDE.

### Test Poll

**Poll Title:**
Blockchain Technology

**Options:**

```text
Ethereum
Solana
Cardano
