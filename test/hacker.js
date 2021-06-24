const Hacker = artifacts.require("Hacker");
const Elevator = artifacts.require("Elevator");
const { expect } = require("chai");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("Hacker", function ([_owner, _hacker]) {
  it("should move elevator to top floor", async function () {
    const hackerContract = await Hacker.deployed();
    const targetContract = await Elevator.deployed();
    const result = await hackerContract.attack(targetContract.address, { from: _hacker });
    expect(result.receipt.status).to.be.equal(true);
    expect(await targetContract.top()).to.be.equal(true);
  });
});
