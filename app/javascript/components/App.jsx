import React, { Component } from 'react';
import StreetDropdown from './intersecting-streets/StreetDropdown';
import ChildSurveys from './intersecting-streets/ChildSurveys';

import './intersecting-streets/App.css';

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
