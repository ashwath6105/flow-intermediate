import FungibleToken from 0x05
import Dynamo from 0x06

transaction () {

    let VaultAccess: &Dynamo.Vault?

    let VaultCapability: Capability<&Dynamo.Vault{FungibleToken.Balance, FungibleToken.Receiver}>

    prepare (signer: AuthAccount) {

        self.VaultAccess =  signer.borrow<&Dynamo.Vault>(from: Dynamo.VaultStoragePath)
        self.VaultCapability = signer.getCapability<&Dynamo.Vault{FungibleToken.Balance, FungibleToken.Receiver, Dynamo.adminAccess}>(/public/DYNAMO)

        var condition = (self.VaultAccess.getType() == Type<&Dynamo.Vault?>()) ? true  : false

        if condition {
            if self.VaultCapability.check() {
                log("Vault is set up properly")
            } else {
                signer.unlink(/public/DYNAMO)
                signer.link<&Dynamo.Vault{FungibleToken.Receiver, FungibleToken.Balance, Dynamo.adminAccess}>(/public/DYNAMO, target: Dynamo.VaultStoragePath)
            }   
        } else {
                let newVault <- Dynamo.createEmptyVault()
                signer.unlink(/public/DYNAMO)
                signer.save(<- newVault, to: Dynamo.VaultStoragePath)
                signer.link<&Dynamo.Vault{FungibleToken.Receiver, FungibleToken.Balance, Dynamo.adminAccess}>(/public/DYNAMO, target: Dynamo.VaultStoragePath)
        }
    }

    execute {
        log(" DYNAMO vault set-up correctly and successfully")
    }

}
 
