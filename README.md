# Flow Intermediate Module 

Token contract "DYNAMO". includes all the related transaction, scripts and contracts are included in the folders.

## Description

Flow playground link: "https://play.flow.com/1ad5f52e-9a69-4ed2-b819-4b2f1d60239f?type=contract&id=3618cc9c-2e4c-4b40-8ceb-6d73b926d3fd"


"FlowContract.cdc" :-

The FlowContract.cdc contract contains the basic functionalitites like deposit, mint, transfer etc. It defines a resource Minter that contains a function mintTokens used for minting fungible tokens on the Flow blockchain. The function requires an amount of type UFix64 as a parameter and is restricted to be called only by the contract owner (the owner's address must match the FlowToken account address). Upon successful execution, it increases the total token supply, emits a TokensMinted event with the minted amount, and creates a new vault with the minted tokens, returning the vault to the caller.


Setting the incoming vault's balance to 0.0 before destroying it in the deposit function is a common practice to ensure that any remaining balance in the vault is effectively cleared before the resource is destroyed.


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
