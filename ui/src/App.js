import React, {Component} from 'react';
import './App.scss';
import {Editor} from "./components/Editor/Editor";
import Runner from "./components/Runner/Runner";
import Web3 from "./services/Web3";


class App extends Component {
  constructor(props) {
    super(props);

    this.state = {
      compilationResult: {
        errors: [],
        unlocked: false,
      }
    }
  }

  handleCompile = (compilationResult) => {
    console.log(compilationResult);
    this.setState({compilationResult});
  };

  handleUnlock = async (event) => {
    event.preventDefault();

    await Web3.getAccount();

    this.setState({unlocked: true});
  };

  render() {
    const {compilationResult, unlocked} = this.state;
    return (
      <div className="App">

        <Editor handleCompile={this.handleCompile} unlocked={unlocked} handleUnlock={this.handleUnlock}/>
        <Runner compilationResult={compilationResult} unlocked={unlocked}/>

        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500"/>
      </div>
    );
  }

}

export default App;
