import React, {Component} from "react";
import {Modal} from "@material-ui/core";
import ExpansionPanel from '@material-ui/core/ExpansionPanel';
import ExpansionPanelSummary from '@material-ui/core/ExpansionPanelSummary';
import ExpansionPanelDetails from '@material-ui/core/ExpansionPanelDetails';
import {FaChevronDown} from "react-icons/all";

import "./Snippets.scss";

const templates = [
  {
    name: "Template Function",
    code: `pragma solidity ^0.5.11;

contract Eval {
 
    function evaluate() external {
        // @TODO: Add code here
    }
 
}`
  },
  {
    name: "Simple Return",
    code: `pragma solidity >=0.4.21 <0.6.0;

contract Eval {
    function evaluate() public pure returns (int256) {
        return 10;
    }
}`,
  },
];

export default class Snippets extends Component {
  constructor(props) {
    super(props);
  }

  handlePick = (entry) => {
    return (event) => {
      this.props.handlePick(entry.code);
      this.props.handleClose();
    };
  };

  render() {
    const {open, handleClose} = this.props;

    return (
      <div className="snippets">
        <Modal open={open} onClose={handleClose}>
          <div className="snippet-container">
            {templates.map((template, i) => {
              return <ExpansionPanel key={i}>
                <ExpansionPanelSummary
                  expandIcon={<FaChevronDown/>}
                  aria-controls="panel1a-content"
                  id="panel1a-header"
                >{template.name}</ExpansionPanelSummary>
                <ExpansionPanelDetails className="snippet-entry" onClick={this.handlePick(template)}>
                  <pre>{template.code}</pre>
                </ExpansionPanelDetails>
              </ExpansionPanel>
            })};
          </div>
        </Modal>
      </div>
    );
  }
}
