import FungibleToken from 0x05

pub contract FlowToken: FungibleToken {

    pub var totalSupply: UFix64

    pub event TokensInitialized(initialSupply: UFix64)
    pub event TokensWithdrawn(amount: UFix64, from: Address?)
    pub event TokensDeposited(amount: UFix64, to: Address?)
    pub event TokensMinted(amount: UFix64)
    pub event TokensBurned(amount: UFix64)
    pub event MinterCreated(allowedAmount: UFix64)
    pub event BurnerCreated()

    pub resource Vault: FungibleToken.Provider, FungibleToken.Receiver, FungibleToken.Balance {

        pub var balance: UFix64

        init(balance: UFix64) {
            self.balance = balance
        }

        pub fun withdraw(amount: UFix64): @FungibleToken.Vault {
            self.balance = self.balance - amount
            emit TokensWithdrawn(amount: amount, from: self.owner?.address)
            return <-create Vault(balance: amount)
        }

        pub fun deposit(from: @FungibleToken.Vault) {
            let vault <- from as! @FlowToken.Vault
            self.balance = self.balance + vault.balance
            emit TokensDeposited(amount: vault.balance, to: self.owner?.address)
            vault.balance = 0.0
            destroy vault
        }

        destroy() {
            if self.balance > 0.0 {
                FlowToken.totalSupply = FlowToken.totalSupply - self.balance
            }
        }
    }

    pub resource Minter {

        pub fun mintTokens(amount: UFix64): @FungibleToken.Vault {
            pre {
                self.owner?.address == FlowToken.account.address:
                "Only the contract owner can mint tokens"
            }

            FlowToken.totalSupply = FlowToken.totalSupply + amount
            emit TokensMinted(amount: amount)
            
            return <-create Vault(balance: amount)
        }
    }

    pub resource Administrator {

        pub fun createNewMinter(allowedAmount: UFix64): @Minter {
            emit MinterCreated(allowedAmount: allowedAmount)
            return <-create Minter()
        }

        pub fun createNewBurner(): @Burner {
            emit BurnerCreated()
            return <-create Burner()
        }
    }

    pub resource Burner {

        pub fun burnTokens(from: @FungibleToken.Vault) {
            let vault <- from as! @FlowToken.Vault
            let amount = vault.balance
            destroy vault
            emit TokensBurned(amount: amount)
        }
    }

    init() {
        let adminAccount = self.account
        self.totalSupply = 0.0

        let vault <- create Vault(balance: self.totalSupply)
        adminAccount.save(<-vault, to: /storage/flowToken)

        let admin <- create Administrator()
        adminAccount.save(<-admin, to: /storage/flowTokenAdmin)

        emit TokensInitialized(initialSupply: self.totalSupply)
    }

    pub fun createEmptyVault(): @FungibleToken.Vault {
        return <-create Vault(balance: 0.0)
    }
}
