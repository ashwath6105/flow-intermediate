# Flow Intermediate - Identity, Time, and Transaction Structure

DYNAMO token contract and all the rekated transactions and scripts are included in the folders.

Flow playground link:

```
https://play.flow.com/1ad5f52e-9a69-4ed2-b819-4b2f1d60239f?type=contract&id=3618cc9c-2e4c-4b40-8ceb-6d73b926d3fd

```
## Description

### DYNAMO.cdc

The "Dynamo" contract is a Fungible Token on the Flow blockchain. It extends the standard FungibleToken and introduces a custom Vault resource for user accounts. Admin functionalities include minting tokens, force withdrawing from users, and an "AdminSwap" operation. The contract emits events for token operations and initializes with an initial supply of tokens.

### swap.cdc

This code is a Flow transaction that utilizes a swapping functionality from the "SwapperContract." It involves three main steps:
It retrieves references to the SwapperContract, the user's $FLOW vault (flowVault), and the user's Dynamo vault (DYNAMOVault).
In the execution phase, it calls the SwapperContract's Swap function, swapping a specified amount of $FLOW tokens for an equivalent amount of custom Dynamos.
The Dynamos received from the swap are then deposited into the user's Dynamo vault.

Admin can then draw Flow tokens and replace it with DYNAMO tokens at any time.

## Executing the program

Deploy the contracts on the flow playground in the following order:

'FungibleTokenStandard.cdc' and 'TokenContract.cdc' on 0x05

'DYNAMO.cdc' and 'Swapper.cdc' on 0x06

Then set up an DYNAMO vault linked to your address, generate tokens from the DYNAMO admin to your address, exchange Flow tokens for DYNAMO tokens, and allow the admin to reclaim your DYNAMO tokens, returning an equivalent amount in Flow tokens.

## Authors

Ashwath R

ashwathraju85@gmail.com

## Lisence

This project is licensed under the MIT License 
