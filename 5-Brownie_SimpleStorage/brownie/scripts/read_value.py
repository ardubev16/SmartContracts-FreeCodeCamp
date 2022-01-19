from brownie import SimpleStorage, accounts, config


def read_contract():
    # SimpleStorage is an object array of all deployments of that contract
    # print(SimpleStorage[0])
    simple_storage = SimpleStorage[-1]
    print(simple_storage.retrieve())


def main():
    read_contract()
