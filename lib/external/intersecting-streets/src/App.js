import React, { Component } from 'react';
import StreetDropdown from './StreetDropdown';
import ChildSurveys from './ChildSurveys';

import './App.css';

class App extends Component {
  render() {
    return (
      <div className="App">
        <StreetDropdown />
        <ChildSurveys />
      </div>
    );
  }
}

export default App;
