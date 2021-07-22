// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./MercuryToken.sol";
import "./PlutoToken.sol";

contract Exchange {
    // address of admin
    address public admin;

    // define the instance of DevToken
    MercuryToken public mercuryToken;
    PlutoToken public plutoToken;

    // count of token sold variable
    uint256 public totalsold;

    uint256 public rate;

    event Sell(address sender, uint256 totalvalue);

    // constructor
    constructor(
        address _mercuryTokenAddress,
        address _plutoTokenAddress,
        uint256 _rate
    ) public {
        admin = msg.sender;
        mercuryToken = MercuryToken(_mercuryTokenAddress);
        plutoToken = PlutoToken(_plutoTokenAddress);
        rate = _rate;
    }

    // buyTokens function
    function buyTokens(uint256 _amount) public {
        // check if the contract has the tokens or not
        require(
            mercuryToken.balanceOf(address(msg.sender)) >= _amount,
            "not enough token"
        );

        // transfer mercury token to this contract
        mercuryToken.transferFrom(msg.sender, address(this), _amount);

        // transfer the pluto token to the user
        plutoToken.transfer(msg.sender, _amount * rate);

        // increase the token sold
        totalsold += _amount;

        // emit sell event for ui
        emit Sell(msg.sender, _amount);
    }
}
