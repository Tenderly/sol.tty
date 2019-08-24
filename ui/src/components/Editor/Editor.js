import React, {Component} from 'react';
import AceEditor from "react-ace";

import "ace-mode-solidity/build/remix-ide/mode-solidity";
import "brace/theme/dracula";

import "./Editor.scss";

export class Editor extends Component {
  constructor(props) {
    super(props);

    this.state = {
      code: "",
    };
  }

  handleChange = (value) => {
    this.setState({code: value});
  };

  render() {
    const {code} = this.state;

    return (
      <div className="editor">
        <div className="editor-header">
          <div className="heading">
            <span>sol.tty</span>
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
