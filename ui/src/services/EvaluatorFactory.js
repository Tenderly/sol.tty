import Web3 from "./Web3";

const abi = [
  {
    "constant": true,
    "inputs": [
      {
        "name": "",
        "type": "address"
      }
    ],
    "name": "evals",
    "outputs": [
      {
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

const address = "0x54517690F7D0567a9034b4f73d322716a24a51F0";

export default class EvaluatorFactory {
  static async getInstance() {
    if (this.instance) {
      return this.instance;
    }

    this.instance = new (await Web3.getInstance()).eth.Contract(abi, address);

    return this.instance;
  }
}
