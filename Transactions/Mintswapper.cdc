import SwapperContract from 0x06


transaction () {
    prepare (signer: AuthAccount) {
        signer.save(<- SwapperContract.mintSwapper(), to: /storage/DYNAMOSwapper)
        log("Minted Swapper Successfully!")
    }
}
