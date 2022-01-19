# accounts is an array of 10 addressses from the ganache-cli
from brownie import accounts, config, SimpleStorage, network

# import os


def deploy_simpleStorage():
    account = get_account()

    simple_storage = SimpleStorage.deploy({"from": account})
    # returns a Contract Object
    stored_value = simple_storage.retrieve()
    print(stored_value)
    transaction = simple_storage.store(15, {"from": account})
    transaction.wait(1)  # waits 1 block for confirmation
    updated_stored_value = simple_storage.retrieve()
    print(updated_stored_value)


def get_account():
    # for "development network"
    # account = accounts[0]

    # for other networks, load saved account in Brownie (safest)
    # account = accounts.load("dev1_metamask")

    # load account from .env, see brownie-config.yaml (less safe)
    # account = accounts.add(os.getenv("PRIVATE_KEY"))
    # account = accounts.add(config["wallets"]["from_key"])

    if network.show_active() == "development":
        return accounts[0]
    else:
        return accounts.add(config["wallets"]["from_key"])


def main():
    deploy_simpleStorage()
