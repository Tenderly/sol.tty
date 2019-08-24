import * as wrapper from 'solc/wrapper';

let solc;

export default class Compiler {
  static compile(source) {
    if (!solc) {
      solc = wrapper(window.Module);
    }

    const input = {
      language: 'Solidity',
      sources: {
        'Eval.sol': {
          content: source,
        },
      },
      settings: {
        outputSelection: {
          '*': {
            '*': ['*']
          }
        }
      }
    };

    const result = JSON.parse(solc.compile(JSON.stringify(input)));
    const errors = result.errors ? result.errors : [];
    delete result.errors;

    // result.contracts["Eval.sol"]["Eval"].evm.methodIdentifiers
    if (errors.length === 0) {
      const contract = result.contracts["Eval.sol"];

      if (!contract["Eval"]) {
        errors.push({formattedMessage: "Eval contract not found"});
      } else if (contract["Eval"].evm.methodIdentifiers["evaluate()"] !== "7daa9efc") {
        errors.push({formattedMessage: "Eval.evaluate() function not found"});
      }
    }

    return {result, errors};
  }
}
