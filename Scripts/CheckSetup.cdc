import FungibleToken from 0x05
import Dynamo from 0x06

pub fun main(_address: Address) {
    let vaultCapability= getAccount(_address).getCapability<&Dynamo.Vault{FungibleToken.Balance, FungibleToken.Receiver, Dynamo.adminAccess}>(/public/DYNAMO)

    log("DYNAMO Vault set up correctly? T/F")
    log(vaultCapability.check())
}
