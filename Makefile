-include .env

.PHONY: all test clean deploy fund help install snapshot format anvil install deploy deploy-sepolia verify

DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

all: clean remove install update build

# Clean the repo
clean  :; forge clean

# Remove modules
remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

install :; forge install cyfrin/foundry-devops@0.2.2 --no-commit && forge install foundry-rs/forge-std@v1.8.2 --no-commit && forge install openzeppelin/openzeppelin-contracts@v5.0.2 --no-commit

# Update Dependencies
update:; forge update

build:; forge build

test :; forge test 

snapshot :; forge snapshot

format :; forge fmt

anvil :; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1

deploy:
	@forge script script/DeployIAShop.s.sol:DeployIAShop --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast


deploy-mantle:
	@forge script script/DeployIAShop.s.sol:DeployIAShop --rpc-url $(MANTLE_SEPOLIA_RPC_URL) --account $(ACCOUNT1) --gas-price 1000000000 --gas-limit 3000000 --broadcast -vvvvv

verify:
	@forge script script/DeployIAShop.s.sol:DeployIAShop --rpc-url $(MANTLE_SEPOLIA_RPC_URL) --account $(ACCOUNT) --resume --verify --verifier blockscout --verifier-url https://explorer.sepolia.mantle.xyz/api/

	
deploy-verify:
	@forge script script/DeployIAShop.s.sol:DeployIAShop --rpc-url $(MANTLE_SEPOLIA_RPC_URL) --account $(ACCOUNT) --broadcast --verify --verifier blockscout --verifier-url https://explorer.sepolia.mantle.xyz/api/ -vvvvv

verify-contract:
	@forge verify-contract --rpc-url $(MANTLE_SEPOLIA_RPC_URL)  0x7D83Feebbf3509E18bdc294a5fe91f0462Bf9928 src/IAShop.sol:IAShop --verifier blockscout --verifier-url https://explorer.sepolia.mantle.xyz/api/

create-verify:
	@forge create src/IAShop.sol:IAShop  --rpc-url $(MANTLE_SEPOLIA_RPC_URL)  --account $(ACCOUNT) --broadcast  

