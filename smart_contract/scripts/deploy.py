from brownie import mintnft, network, config;
from scripts.helpful_scripts import get_account
from web3 import Web3;

base_uri = ""
base_extension = ".json"

def deploy_contract():
    account = get_account()
    contract = mintnft.deploy(base_uri, base_extension, {"from": account, "gas_limit": 10000000}, publish_source=config["networks"][network.show_active()].get("verify", False))
    print("Contract has been deployed")
    mint(account, contract)
    withdraw(account, contract)

def mint(account, contract):
    contract.mintNFT(1, {"from": account, "value": 60000000000000000})
    token_owner = contract.getTokenOwner(1, {"from": account})
    print(token_owner)
    token_uri = contract.tokenURI(1, {"from": account})
    print(token_uri)

def withdraw(account, contract):
    contract.withdraw({"from": account})

def main():
    deploy_contract()

