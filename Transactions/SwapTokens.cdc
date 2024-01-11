import FungibleToken from 0x05
import Dynamo from 0x06
import FlowToken from 0x05
import SwapperContract from 0x06

transaction (amount: UFix64) {
    let swapper: &SwapperContract.Swapper
    let flowVault: &FungibleToken.Vault
    let DYNAMOVault: &Dynamo.Vault{FungibleToken.Receiver}
    prepare (signer: AuthAccount) {

        self.swapper = signer.borrow<&SwapperContract.Swapper>(from: /storage/DYNAMOSwapper) ?? panic ("mint a swapper first")

        self.flowVault = signer.borrow<&FlowToken.Vault>(from: /storage/flowToken) ?? panic("You do not have a flow Vault")

        self.DYNAMOVault = signer.borrow<&Dynamo.Vault>(from: Dynamo.VaultStoragePath) ?? panic("You do not have a DYNAMO Vault")
    }

    execute {
        self.DYNAMOVault.deposit(from:<- self.swapper.Swap(from: self.flowVault, amount: amount))
    }
}
