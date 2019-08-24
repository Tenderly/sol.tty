import React, {Component} from 'react';
import AceEditor from "react-ace";

import "ace-mode-solidity/build/remix-ide/mode-solidity";
import "brace/theme/dracula";

import "./Editor.scss";
import {FiPlayCircle} from "react-icons/fi";
import {FaKey} from "react-icons/all";
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
            <button className="submit-btn" onClick={this.handleCompile}>
              <FiPlayCircle className="icon"/>
              <span>Compile</span>
            </button>
            {!unlocked && <button className="unlock-btn" onClick={this.props.handleUnlock}>
              <FaKey className="icon"/>
              <span>Unlock MetaMask</span>
            </button>}
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
