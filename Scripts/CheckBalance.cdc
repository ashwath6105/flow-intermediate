import FungibleToken from 0x05
import Dynamo from 0x06
import FlowToken from 0x05

pub fun main (_address: Address): UFix64 {

      let account: AuthAccount = getAuthAccount(_address)

    let Vault = account.borrow<&Dynamo.Vault>(from: Dynamo.VaultStoragePath) ?? panic("the address does not have a vault")


    assert(
        Vault.getType() == Type<@Dynamo.Vault>(),
        message: "This is not the correct type. No hacking me today!"
        )

      account.unlink(/public/DYNAMO)
      account.link<&Dynamo.Vault{FungibleToken.Balance}>(/public/DYNAMO, target: Dynamo.VaultStoragePath)
      let wallet = getAccount(_address).getCapability<&Dynamo.Vault{FungibleToken.Balance}>(/public/DYNAMO).borrow() ?? panic ("error")


    log("will return Vault balance")
    log(wallet.balance)
    return wallet.balance
}
