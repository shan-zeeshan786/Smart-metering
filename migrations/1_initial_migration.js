const Migrations = artifacts.require("SmartMeter");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
};
