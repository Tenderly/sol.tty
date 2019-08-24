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

    return {result, errors};
  }
}
