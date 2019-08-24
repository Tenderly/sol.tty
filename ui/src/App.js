import React, {Component} from 'react';
import './App.scss';
import {Editor} from "./components/Editor/Editor";
import Runner from "./components/Runner/Runner";
import Web3 from "./services/Web3";
import EvaluatorFactory from "./services/EvaluatorFactory";


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

    if (address !== "0x0000000000000000000000000000000000000000") {
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

  render() {
    const {compilationResult, unlocked, identityAddress} = this.state;
    return (
      <div className="App">

        <Editor handleCompile={this.handleCompile} unlocked={unlocked} handleUnlock={this.handleUnlock}/>
        <Runner compilationResult={compilationResult} unlocked={unlocked} identityAddress={identityAddress}
                deployIdentity={this.handleDeployIdentity}/>

        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500"/>
      </div>
    );
  }

}

export default App;
