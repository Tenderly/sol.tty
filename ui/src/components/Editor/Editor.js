import React, {Component} from 'react';
import AceEditor from "react-ace";

import "ace-mode-solidity/build/remix-ide/mode-solidity";
import "brace/theme/dracula";

import Button from "../Button/Button";

import "./Editor.scss";
import Compiler from "../../services/Compiler";
import Snippets from "../Snippets/Snippets";

export class Editor extends Component {
  constructor(props) {
    super(props);

    this.state = {
      code: `pragma solidity ^0.5.11;

contract Eval {
 
    function evaluate() external {
        // @TODO: Add code here
    }
 
}`,
      loaded: false,
      snippetsOpen: false,
    };
  }

  componentDidMount = () => {
    const script = document.createElement("script");

    script.src = "//solc-bin.ethereum.org/bin/soljson-v0.5.11+commit.c082d0b4.js";
    script.onload = () => {
      this.setState({loaded: true});
    };

    document.body.appendChild(script);
  };

  handleChange = (value) => {
    this.setState({code: value});
  };

  handleCompile = (event) => {
    event.preventDefault();

    const result = Compiler.compile(this.state.code);

    this.props.handleCompile(result);
  };

  handleSnippetsOpen = (event) => {
    event.preventDefault();
    this.setState({snippetsOpen: true});
  };

  handleSnippetsClose = (event) => {
    this.setState({snippetsOpen: false});
  };

  handlePick = (code) => {
    this.setState({code});
  };

  render() {
    const {code, loaded, snippetsOpen} = this.state;
    const {unlocked} = this.props;

    return (
      <div className="editor">
        <div className="editor-header">
          <div className="heading">
            <span>sol.tty</span>
          </div>
          <div className="actions">
            <Button text="Compile" icon="circle" onClick={this.handleCompile}/>
            {!unlocked &&
            <Button text="Unlock MetaMask" icon="key" onClick={this.props.handleUnlock} className="margin-btn"/>}
            {unlocked && <Button icon="code" onClick={this.handleSnippetsOpen} text="Snippets" className="margin-btn"/>}
          </div>
        </div>
        <AceEditor
          readOnly={!loaded}
          mode="solidity"
          theme="dracula"
          fontSize={14}
          showPrintMargin={true}
          value={code}
          width="100%"
          height="100%"
          onChange={this.handleChange}
          showGutter={true}
          setOptions={{
            enableBasicAutocompletion: true,
            enableLiveAutocompletion: true,
            enableSnippets: false,
            showLineNumbers: true,
            tabSize: 4,
          }}
        />
        <Snippets open={snippetsOpen} handleClose={this.handleSnippetsClose} handlePick={this.handlePick}/>
      </div>
    );
  }
}
