pragma solidity ^0.5.11;

contract EvalFactory {
    mapping(address => address) public evals;

    function deploy() public {
        require(evals[msg.sender] == address(0), "Contract already instatiated");

        Evaluator newEvaluator = new Evaluator(msg.sender);

        evals[msg.sender] = address(newEvaluator);
    }
}

contract Evaluator {
  address public owner;

  constructor(address _owner) public {
    owner = _owner;
  }

  function eval() public view returns(int16) {
    require(msg.sender == owner, "Not owner");

    return 5;
  }
}