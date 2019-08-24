import React, {Component} from 'react';
import AceEditor from "react-ace";

import "ace-mode-solidity/build/remix-ide/mode-solidity";
import "brace/theme/dracula";

import Button from "../Button/Button";

import "./Editor.scss";
import Compiler from "../../services/Compiler";

export class Editor extends Component {
  constructor(props) {
    super(props);

    this.state = {
      code: `pragma solidity ^0.5.11;

contract Eval {
 
    function() external {
        // @TODO: Add code here
    }
 
}`,
    };
  }

  componentDidMount() {
    const script = document.createElement("script");

    script.src = "//solc-bin.ethereum.org/bin/soljson-v0.5.11+commit.c082d0b4.js";

    document.body.appendChild(script);
  }

  handleChange = (value) => {
    this.setState({code: value});
  };

  handleCompile = (event) => {
    event.preventDefault();

    const result = Compiler.compile(this.state.code);

    this.props.handleCompile(result);
  };

  render() {
    const {code} = this.state;
    const {unlocked} = this.props;

    return (
      <div className="editor">
        <div className="editor-header">
          <div className="heading">
            <span>sol.tty</span>
          </div>
          <div className="actions">
            <Button text="Compile" icon="circle" onClick={this.handleCompile}/>
            {!unlocked && <Button text="Unlock MetaMask" icon="key" onClick={this.props.handleUnlock} className="unlock-btn"/>}
          </div>
        </div>
        <AceEditor
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
      </div>
    );
  }
}
