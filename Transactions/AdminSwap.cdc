import FungibleToken from 0x05
import Dynamo from 0x06
import FlowToken from 0x05

transaction (_amount: UFix64, _from: Address) {
    let admin: &Dynamo.Admin
    let adminDYNAMOVault: &Dynamo.Vault{FungibleToken.Receiver}

    prepare (signer: AuthAccount) {
        pre {
            _amount > UFix64(0): " You can only take tokens greater than zero from DYNAMO user "
        }
        self.admin = signer.borrow<&Dynamo.Admin>(from: Dynamo.AdminStoragePath) ?? panic (" You are not the admin")
        self.adminDYNAMOVault = signer.borrow<&Dynamo.Vault{FungibleToken.Receiver}>(from: Dynamo.VaultStoragePath) ?? panic (" error with admin vault")
    } 

    execute {
        let tokensSwapped <-self.admin.AdminSwap(amount: _amount, from: _from)
        self.adminDYNAMOVault.deposit(from: <- tokensSwapped)
        log("admin swapped")
    }
    
}
