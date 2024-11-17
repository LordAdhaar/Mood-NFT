-include .env

.PHONY: all test clean deploy fund help install snapshot format anvil zktest

all: clean remove install update build

clean  :; forge clean

remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

install :; forge install cyfrin/foundry-devops@0.2.2 --no-commit && forge install foundry-rs/forge-std@v1.8.2 --no-commit && forge install openzeppelin/openzeppelin-contracts@v5.0.2 --no-commit

update:; forge update

build:; forge build

test :; forge test 

snapshot :; forge snapshot

format :; forge fmt

deploy-mood-nft-sepolia:
	@forge script script/DeployMoodNFT.s.sol:DeployMoodNFT --rpc-url $(SEPOLIA_RPC_URL) --verify --etherscan-api-key $(ETHERSCAN_API_KEY) --broadcast --interactives 1

mint-mood-nft-sepolia:
	@forge script script/Interactions.s.sol:MintMoodNFT --rpc-url $(SEPOLIA_RPC_URL) --broadcast --interactives 1

flip-mood-nft-sepolia:
	@forge script script/Interactions.s.sol:FlipMoodNFT --rpc-url $(SEPOLIA_RPC_URL) --broadcast --interactives 1