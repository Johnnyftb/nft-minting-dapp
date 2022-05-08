from scripts.helpful_scripts import get_account
from scripts.deploy import base_uri, base_extension
from brownie import mintnft, config

def test_mint_nft():
    # Arrange
    account = get_account()
    contract = mintnft.deploy(base_uri, base_extension, {"from": account})

    # Act
    contract.mint(1, {"from": account, "value": 0.05})

    # Assert
    assert (contract.getTokenOwner(1, {"from": account}) == account)