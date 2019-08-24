import React, {Component} from "react";
import TextField from "@material-ui/core/TextField";

import "./Runner.scss";

export default class Runner extends Component {
  constructor(props) {
    super(props);

    this.state = {
      identityAddress: "0x06480c93a7acc5769f63f2af20a82069edc2312d",
    };
  }

  handleChange = (field) => {
    return (event) => {
      this.setState({[field]: event.target.value});
    };
  };

  render() {
    const {identityAddress} = this.state;
    const {compilationResult} = this.props;

    return (
      <div className='runner'>
        {compilationResult.errors.length > 0 && <div className="compiler-errors">
          {compilationResult.errors.map((err, i) => {
            return <pre key={i}>
                {err.formattedMessage}
              </pre>;
          })}
        </div>}
        <TextField
          label="Identity contract address"
          className="text-field"
          type="text"
          margin="normal"
          onChange={this.handleChange('identityAddress')}
          value={identityAddress}
        />
      </div>
    );
  }
}
