// SPDX-License-Identifier: MIT

pragma solidity >=0.6.6 <0.9.0;

// imports from "@chainlink/contracts" npm package (see DOCs)
import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

// "@openzeppelin/contracts" has a LIBRARY for checking variable overflow, needed for solidity version <0.8.0
// "@chainlink/contracts" has a similar LIBRARY
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";

contract FundMe {
    // not needed for Solidity >=0.8.0
    using SafeMathChainlink for uint256;

    mapping(address => uint256) public addressToAmountFunded;
    address[] public funders;
    address public owner;

    // the constructor will be called when the contract is first deployed
    constructor() public {
        owner = msg.sender;
    }

    function fund() public payable {
        // $50
        uint256 minimumUSD = 50 * (10**18);

        // if the require condition is not met, the transaction will revert
        require(getConversionRate(msg.value) >= minimumUSD, "Error message!");
        addressToAmountFunded[msg.sender] += msg.value;
        // msg.value is in WEI

        funders.push(msg.sender);
    }

    // contract call to another contract through an interface (AggregatorV3Interface.sol)
    function getVersion() public view returns (uint256) {
        // address of ETH/USD conversion rate on Kovan Testnet
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x9326BFA02ADD2366b30bacB125260Af641031331
        );
        return priceFeed.version();
    }

    // get ETH (1WEI) price in USD
    function getPrice() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x9326BFA02ADD2366b30bacB125260Af641031331
        );
        // priceFeed.latestRoundData() returns a TUPLE (list of different variables)

        // (uint80 roundId,
        //  int256 answer,
        //  uint256 startedAt,
        //  uint256 updatedAt,
        //  uint80 answeredInRound)
        //  = priceFeed.latestRoundData();

        // unused variables can be omitted:
        (, int256 answer, , , ) = priceFeed.latestRoundData();

        // casting of "answer" into uint256, give value of WEI
        return uint256(answer * (10**10));
    }

    // ethAmount in WEI, gives result *(10**18)
    function getConversionRate(uint256 ethAmount)
        public
        view
        returns (uint256)
    {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / (10**18);
        return ethAmountInUsd;
    }

    // if this modifier is applied the function code will run where is the "_"
    // in this case the "require" will run before
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function withdraw() public payable onlyOwner {
        // msg.sender.transfer() transfers ETH from the contract to the msg.sender
        msg.sender.transfer(address(this).balance);

        // resets every funder balance on the contract
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // resets the array to no elements
        funders = new address[](0);
    }
}
