import Dynamo from 0x06

pub fun main (): UFix64 {
    log("DYNAMO total supply is: ".concat(Dynamo.totalSupply.toString()))
    return Dynamo.totalSupply
}
