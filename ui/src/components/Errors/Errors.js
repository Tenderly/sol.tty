import React, {Component} from "react";

import "./Errors.scss";

export default class Errors extends Component {
  constructor(props) {
    super(props);
  }

  handleChange = (field) => {
    return (event) => {
      this.setState({[field]: event.target.value});
    };
  };

  render() {
    const {compilationResult} = this.props;

    return (
      <div className={`errors ${compilationResult.errors.length > 0 ? 'open' : ''}`}>
        {compilationResult.errors.length > 0 && <div className="compiler-errors">
          {compilationResult.errors.map((err, i) => {
            return <pre key={i}>
                {err.formattedMessage}
              </pre>;
          })}
        </div>}
      </div>
    );
  }
}
