from unittest import mock
from brownie import FundMe, MockV3Aggregator, network, config
from scripts.helpful_scripts import get_account, deploy_mocks


def deploy_fundMe():
    account = get_account()
    # publish_source=True => verifies contract on Etherscan
    # fund_me = FundMe.deploy({"from": account}, publish_source=True)

    # pass the price feed address to our FundMe contract

    # if on persistent network like Rinkeby, use address
    # otherwise deploy Mocks
    active_network = network.show_active()
    if active_network != "development":
        price_feed_address = config["networks"][active_network]["eth_usd_price_feed"]
    else:
        deploy_mocks()
        price_feed_address = MockV3Aggregator[-1].address

    fund_me = FundMe.deploy(
        price_feed_address,
        {"from": account},
        publish_source=config["networks"][active_network].get("verify"),
    )
    print(f"Contract deployed to {fund_me.address}")


def main():
    deploy_fundMe()
