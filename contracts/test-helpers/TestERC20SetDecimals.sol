//SPDX-License-Identifier:ISC
pragma solidity ^0.7.6;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import "./ITestERC20.sol";

contract TestERC20SetDecimals is ITestERC20, ERC20 {
  mapping(address => bool) permitted;

  constructor(
    string memory name_,
    string memory symbol_,
    uint8 decimals_
  ) ERC20(name_, symbol_) {
    permitted[msg.sender] = true;
    _setupDecimals(decimals_);
  }

  function permitMint(address user, bool permit) external {
    require(permitted[msg.sender], "TestERC20SetDecimals: only permitted");
    permitted[user] = permit;
  }

  function mint(address account, uint amount) external override {
    require(permitted[msg.sender], "TestERC20SetDecimals: only permitted");
    ERC20._mint(account, amount);
  }

  function burn(address account, uint amount) external override {
    require(permitted[msg.sender], "TestERC20SetDecimals: only permitted");
    ERC20._burn(account, amount);
  }
}
