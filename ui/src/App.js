import React from 'react';
import './App.scss';
import {Editor} from "./components/Editor/Editor";
import Runner from "./components/Runner/Runner";


function App() {
  return (
    <div className="App">
      <Editor/>
      <Runner/>

      <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500"/>
    </div>
  );
}

export default App;
