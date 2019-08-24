import React, {Component} from 'react';
import './App.scss';
import {Editor} from "./components/Editor/Editor";
import Runner from "./components/Runner/Runner";


class App extends Component {
  constructor(props) {
    super(props);

    this.state = {
      compilationResult: {
        errors: [],
      }
    }
  }

  handleCompile = (compilationResult) => {
    console.log(compilationResult);
    this.setState({compilationResult});
  };

  render() {
    const {compilationResult} = this.state;
    return (
      <div className="App">

        <Editor handleCompile={this.handleCompile}/>
        <Runner compilationResult={compilationResult}/>

        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500"/>
      </div>
    );
  }

}

export default App;
