from brownie import FundMe
from scripts.helpful_scripts import get_account


def deploy_fundMe():
    account = get_account()
    # publish_source=True => verifies contract on Etherscan
    fund_me = FundMe.deploy({"from": account}, publish_source=True)
    print(f"Contract deployed to {fund_me.address}")


def main():
    deploy_fundMe()
