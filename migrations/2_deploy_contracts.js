const MercuryToken = artifacts.require("MercuryToken");
const PlutoToken = artifacts.require("PlutoToken");
const Exchange = artifacts.require("Exchange");

module.exports = async function (deployer) {
  //deploy Mercury Tokens
  await deployer.deploy(MercuryToken, "1000000000000000000000000");
  const mercuryToken = await MercuryToken.deployed();

  //deploy Pluto Tokens
  await deployer.deploy(PlutoToken, "1000000000000000000000000");
  const plutoToken = await PlutoToken.deployed();

  //deploy Exchange
  await deployer.deploy(Exchange, mercuryToken.address, plutoToken.address, 10);
  const exchange = await Exchange.deployed();

  //transfer all Pluto tokens to Exchange (1 million)
  await plutoToken.transfer(exchange.address, "1000000000000000000000000");
};
