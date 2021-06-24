const Elevator = artifacts.require("Elevator");

module.exports = function (_deployer) {
  // Use deployer to state migration tasks.
  _deployer.deploy(Elevator);
};
