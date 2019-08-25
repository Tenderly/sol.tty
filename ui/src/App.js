import React, {Component} from 'react';
import './App.scss';
import {Editor} from "./components/Editor/Editor";
import Web3 from "./services/Web3";
import EvaluatorFactory from "./services/EvaluatorFactory";
import Evaluator from "./services/Evaluator";
import Errors from "./components/Errors/Errors";


class App extends Component {
  constructor(props) {
    super(props);

    this.state = {
      unlocked: false,
      compilationResult: {
        errors: [],
      },
      identityAddress: '',
    }
  }

  handleCompile = (compilationResult) => {
    console.log(compilationResult);
    this.setState({compilationResult});
  };

  handleUnlock = async (event) => {
    event.preventDefault();

    const account = await Web3.getAccount();

    const factory = await EvaluatorFactory.getInstance();

    const address = await factory.methods.evals(account).call();

    let identityAddress = '';

    if (address && address !== '0x0000000000000000000000000000000000000000') {
      identityAddress = address;
    }

    this.setState({unlocked: true, identityAddress});
  };

  handleDeployIdentity = async (event) => {
    event.preventDefault();

    const account = await Web3.getAccount();

    const factory = await EvaluatorFactory.getInstance();

    await factory.methods.deploy().send({from: account}, (error, txHash) => {
    });
  };

  handleRunSnippet = async (event) => {
    event.preventDefault();

    const {compilationResult, identityAddress} = this.state;
    if (!compilationResult.result || compilationResult.errors.length > 0 || identityAddress === '') {
      return;
    }

    const web3Instance = await Web3.getInstance();
    const account = await Web3.getAccount();
    const contract = await Evaluator.getInstance(identityAddress);

    // const byteCode = web3Instance.utils.bytesToHex(compilationResult.result.contracts["Eval.sol"]["Eval"].evm.bytecode.object);
    const byteCode = "0x" + compilationResult.result.contracts["Eval.sol"]["Eval"].evm.deployedBytecode.object;
    console.log("Using bytecode: ", byteCode);
    // const selector = web3Instance.utils.stringToHex("7daa9efc");
    const selector = "0x7daa9efc";

    await contract.methods.eval(
      // "0x608060405260043610603f576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063c66478d5146044575b600080fd5b348015604f57600080fd5b5060566058565b005b5600a165627a7a72305820b1541a06a51fd17e270291a458f0688105feae44b3f810c2e914659ba887688d0029",
      byteCode,
      selector).send({from: account}, (error, txHash) => {
      // await contract.methods.eval(byteCode, selector).send({from: account}, (error, txHash) => {
      console.log(error, txHash);
    });
  };

  render() {
    const {compilationResult, unlocked, identityAddress} = this.state;
    return (
      <div className="App">

        <Editor handleCompile={this.handleCompile} unlocked={unlocked} handleUnlock={this.handleUnlock}
                identityAddress={identityAddress} compilationResult={compilationResult}
                deployIdentity={this.handleDeployIdentity} runSnippet={this.handleRunSnippet}/>
        <Errors compilationResult={compilationResult}/>

        {/*<Runner compilationResult={compilationResult} unlocked={unlocked} identityAddress={identityAddress}*/}
        {/*        deployIdentity={this.handleDeployIdentity} runSnippet={this.handleRunSnippet}/>*/}

        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500"/>
      </div>
    );
  }

}

export default App;
