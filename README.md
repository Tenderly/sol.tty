# sol.tty

Made with ♥ by [Tenderly](https://tenderly.dev)

<a href="https://raw.githubusercontent.com/Tenderly/sol.tty/master/images/logo.jpg" target="_blank">![An example of a snippet](https://raw.githubusercontent.com/Tenderly/sol.tty/master/images/logo.jpg)</a>

## What it does

The scripting layer Ethereum was missing. A Solidity implementation of the EVM deployed as an identity contract so you can run any Solidity code just like you could if you had a REPL.

Sol.tty is an easy way to script multiple transaction calls together and send them in a single transaction.

Ideal for saving gas by batching transactions together, writing one-off scripts and codifying specific transaction behavior in a reusable format.

<a href="https://raw.githubusercontent.com/Tenderly/sol.tty/master/images/sss.png" target="_blank">![An example of a snippet](https://raw.githubusercontent.com/Tenderly/sol.tty/master/images/sss.png)</a>

## How we built it
There are a couple of steps involved in making this:
* A factory contract that
    * Acts as a registry where we map wallet addresses to Identity contracts
    * Deploys new identity contracts if needed
* Identity contract that
    * Has a full implementation of the EVM (bytecode parsing and OP code evaluation)
    * Accepts bytecode and a function selector and passes it to the EVM implementation to be executed
* Use solcjs on the front-end app to compile the snippet into bytecode
* Sending the compiled bytecode to the Identity contract

## Challenges we ran into
* Implementing the EVM itself (all of the OP codes) while keeping the gas usage low

## Accomplishments that we're proud of
* Implementing the EVM inside the EVM
* Our own Stack implementation used by our embedded VM
* The idea of writing an on-chain REPL

## What we learned
* Some of the internals of the EVM itself

## Links
* [Devpost](https://devpost.com/software/sol-tty)
* [Deployed EvalFactory on Kovan](https://kovan.etherscan.io/address/0x9e487a842272bcff7d5b644681e185cca6fb974c#code)

## Demo

<a href="https://youtu.be/C05UpxP7O9g">![video](https://img.youtube.com/vi/C05UpxP7O9g/0.jpg)</a> 
