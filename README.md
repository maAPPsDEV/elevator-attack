# Solidity Game - Elevator Attack

_Inspired by OpenZeppelin's [Ethernaut](https://ethernaut.openzeppelin.com), Elevator Level_

⚠️Do not try on mainnet!

## Task

This elevator won't let you reach the top of your building. Right?

1. Bring the elevator at the top.

_Hint:_

1. Sometimes solidity is not good at keeping promises.
2. This `Elevator` expects to be used from a `Building`.

## What will you learn?

1. What are Interfaces

   Interfaces allow different contract classes to talk to each other.
   Think of interfaces as an ABI (or API) declaration that forces contracts to all communicate in the same language/data structure. But interfaces do not prescribe the logic inside the functions, leaving the developer to implement his own business layer.

   > Contract Interfaces specifies the WHAT but not the HOW

   **Developers typically use interfaces:**

   - **To design contracts:** by generating a working ABI first, before implementing the actual contract.
   - **For token contracts:** by declaring a shared language, so different contracts can use these tokens to handle their business logic.
   - **Not used:** some developer want to scrap interfaces altogether, in favor of abstract classes\*.

   > \*Note: Abstract classes share similar security vulnerabilities with interfaces. In abstract contracts some functions are already programmed, but can be easily overridden.

## What is the most difficult challenge? 💣

- Interfaces do not guarantee contract security. Remember that just because another contract uses the same interface, doesn’t mean it will behave as intended!

- Be careful when inheriting contracts that extend from interfaces. Each layer of abstraction introduces security issues through information obscurity. This makes each generation of the contract less and less secure than the previous.

## Source Code

⚠️This contract contains a bug or risk. Do not use on mainnet!

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;

interface Building {
  function isLastFloor(uint256) external returns (bool);
}

contract Elevator {
  bool public top;
  uint256 public floor;

  function goTo(uint256 _floor) public {
    Building building = Building(msg.sender);

    if (!building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}

```

## Configuration

### Install Truffle cli

_Skip if you have already installed._

```
npm install -g truffle
```

### Install Dependencies

```
yarn install
```

## Test and Attack!💥

### Run Tests

```
truffle develop
test
```

You should take ownership of the target contract successfully.

```
truffle(develop)> test
Using network 'develop'.


Compiling your contracts...
===========================
> Everything is up to date, there is nothing to compile.



  Contract: Hacker
    √ should move elevator to top floor (250ms)


  1 passing (334ms)

```
