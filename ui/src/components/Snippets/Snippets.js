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
    code: `pragma solidity ^0.5.11;

contract Eval {
    function evaluate() public pure returns (int256) {
        return 10;
    }
}`,
  },
  {
    name: "Multi-Transfer funds",
    code: `pragma solidity ^0.5.11;

contract Eval {
 
    function evaluate() external {
        address payable[2] memory addresses = [
            0x06480C93a7Acc5769f63f2AF20A82069eDc2312d, 
            0xC4dFd227848Fbe6640ab14c9C339845BEd350665
        ];
        
        for (uint i = 0; i < addresses.length; i++) {
            addresses[i].transfer(100000000000000000);
        }
    }
 
}`
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
