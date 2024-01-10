import FungibleToken from 0x05
import Dynamo from 0x06
import FlowToken from 0x05

transaction (amount: UFix64, receipient: Address) {

    let minter: &Dynamo.Admin
    let receiver: &Dynamo.Vault{FungibleToken.Receiver}

    prepare (signer: AuthAccount) {
        self.minter = signer.borrow<&Dynamo.Admin>(from:Dynamo.AdminStoragePath) ?? panic ("You are not the DYNAMO admin")
        self.receiver = getAccount(receipient).getCapability<&Dynamo.Vault{FungibleToken.Receiver}>(/public/DYNAMO).borrow() ?? panic ("Error, Check your receiver's DYNAMO Vault status")
    }

    execute {
        let tokens <- self.minter.mint(amount: amount)
        self.receiver.deposit(from: <- tokens)
        log("mint DYNAMO tokens successfully")
        log(amount.toString().concat(" Tokens minted"))
    }
}
