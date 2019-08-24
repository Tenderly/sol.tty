import React, {Component} from "react";
import TextField from "@material-ui/core/TextField";
import Button from "../Button/Button";

import "./Runner.scss";

export default class Runner extends Component {
  constructor(props) {
    super(props);
  }

  handleChange = (field) => {
    return (event) => {
      this.setState({[field]: event.target.value});
    };
  };

  render() {
    const {compilationResult, unlocked, identityAddress, deployIdentity} = this.props;

    return (
      <div className='runner'>
        {compilationResult.errors.length > 0 && <div className="compiler-errors">
          {compilationResult.errors.map((err, i) => {
            return <pre key={i}>
                {err.formattedMessage}
              </pre>;
          })}
        </div>}
        <div className="identity-info">
          {unlocked && identityAddress.length > 0 &&
          <TextField
            label="Identity contract address"
            className="text-field"
            type="text"
            margin="normal"
            disabled
            onChange={() => {
            }}
            value={identityAddress}
          />}
          {unlocked && identityAddress.length === 0 &&
          <Button icon="contract" text="Deploy identity contract" onClick={deployIdentity}/>}
          {unlocked && identityAddress.length > 0 &&
            <div className="actions">

            </div>
          }
        </div>
      </div>
    );
  }
}
