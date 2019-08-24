import Web3 from "./Web3";

const abi = [
  {
    "constant": true,
    "inputs": [
      {
        "internalType": "address",
        "name": "",
        "type": "address"
      }
    ],
    "name": "evals",
    "outputs": [
      {
        "internalType": "address",
        "name": "",
        "type": "address"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [],
    "name": "deploy",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  }
];

const address = "0x731a62c7BcDE7597F07Cf73f14279DaaA18e9f9D";

export default class EvaluatorFactory {
  static async getInstance() {
    if (this.instance) {
      return this.instance;
    }

    this.instance = new (await Web3.getInstance()).eth.Contract(abi, address);

    return this.instance;
  }
}
