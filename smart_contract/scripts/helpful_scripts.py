from brownie import accounts, network, config

def get_account():
    if network.show_active() == "development":
        return
    else:
        return accounts.add(config["wallets"]["from_key"])