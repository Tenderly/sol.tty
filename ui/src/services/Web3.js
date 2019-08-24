import Web3Client from 'web3';

let web3;
let account;

export default class Web3 {
  static async getInstance() {
    if (web3) {
      return web3;
    }

    if (window.ethereum) {
      window.web3 = new Web3Client(window.ethereum);
      web3 = window.web3;

      try {
        await window.ethereum.enable();

        const accounts = await web3.eth.getAccounts();

        if (accounts.length === 0) {
          alert('User doesn\'t have any MetaMask accounts!');
          return;
        }

        account = accounts[0];
        web3.eth.defaultAccount = account;

        return web3;
      } catch (error) {
        alert(`User rejected access to MetaMask accounts: ${error}`);
      }
    }
  }

  static async getAccount() {
    await Web3.getInstance();
    return account;
  }
}
