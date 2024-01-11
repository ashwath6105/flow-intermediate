import Dynamo from 0x06
import FungibleToken from 0x05

transaction () {

    prepare (signer: AuthAccount) {
        signer.unlink(/public/flowToken)
        signer.link<&Dynamo.Vault{FungibleToken.Receiver, FungibleToken.Balance, Dynamo.adminAccess}>(/public/DYNAMO, target: Dynamo.VaultStoragePath)
    }

    execute {
        log("Dynamo Linked successfully")
    }
}
 
