// var Ownable = artifacts.require("./Ownable.sol");
var EventTicket = artifacts.require("./EventTicket.sol");

module.exports = function(deployer) {
  // deployer.deploy(Ownable);
  // deployer.link(Ownable, EventTicket);
  deployer.deploy(EventTicket);
};
