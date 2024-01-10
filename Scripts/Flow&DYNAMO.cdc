import FungibleToken from 0x05
import Dynamo from 0x06
import FlowToken from 0x05

pub fun main (_address: Address): [Wallet] {

  let Vaults : [Wallet] = []

  let account: AuthAccount = getAuthAccount(_address)

  // the other way to make sure the vault is the correct type is implemented here, we simply borrow a DYNAMO Token instead of an AnyResource type
  let DYNAMOVault = account.borrow<&Dynamo.Vault>(from: Dynamo.VaultStoragePath) ?? panic("the address does not have a DYNAMO vault")
  let flowVault = account.borrow<&FlowToken.Vault>(from: /storage/flowToken) ?? panic("the address does not have a flow vault")


  // makes sure the vault is the correct type (DYNAMOToken)
  assert(
    DYNAMOVault.getType() == Type<@Dynamo.Vault>(),
    message: "This is not the correct type. No hacking me today!"
  )

  assert (
    flowVault.getType() == Type<@FlowToken.Vault>(),
    message: " This is not the correct type. No hacking me today!"
  )
      

  account.unlink(/public/DYNAMO)
  account.link<&Dynamo.Vault{FungibleToken.Balance}>(/public/DYNAMO, target: Dynamo.VaultStoragePath)
  let DYNAMOwallet = getAccount(_address).getCapability<&Dynamo.Vault{FungibleToken.Balance}>(/public/DYNAMO).borrow() ?? panic ("error0")
  Vaults.append(Wallet("Dynamo", DYNAMOwallet.balance))

  account.unlink(/public/flowToken)
  account.link<&FlowToken.Vault{FungibleToken.Balance}>(/public/flowToken, target: /storage/flowToken)
  let flowwallet = getAccount(_address).getCapability<&FlowToken.Vault{FungibleToken.Balance}>(/public/flowToken).borrow() ?? panic("error1")
  Vaults.append(Wallet("Flow Token", flowwallet.balance))

  log("will return flow and DYNAMO token data as structs")
  log(Vaults)
  return Vaults
}

pub struct Wallet {
  pub let tokenName: String
  pub let tokenBalance: UFix64

  init (_ name: String, _ balance: UFix64){
    self.tokenName = name
    self.tokenBalance = balance
  }
}
