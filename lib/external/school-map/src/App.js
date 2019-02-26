import React, { Component } from 'react';
import WalkshedMap from './WalkshedMap';
import MapLegend from './MapLegend';
import L from 'leaflet';
import $ from 'jquery';
import scatter from './utils/scatter';

import './styles/App.css';

const shedColumnNames = ['shed_05','shed_10','shed_15','shed_20'];

class App extends Component {

  constructor(props) {
    super(props);

    this.state = {
      bounds: [[40.712, -74.227],[40.774, -74.125]],
      points: [],
      walksheds: false,
      school: null,
    };
  }

  componentDidMount() {
    this.fetchSchoolData();
  }

  // filter for non-null values and roll them up into a Leaflet geoJSON object
  collect(cols, data) {
    return cols.filter((col) => {
        return data[col];
      })
      .reduce((geojson, current) => {
        if(!Array.isArray(data[current])) {
          let newObject = {};

          newObject.type = "Feature";
          newObject.properties = { shed: current };
          newObject.geometry = data[current];

          return geojson.addData(newObject);
        }

        return geojson;
      }, L.geoJson(null));
  }

  fetchSchoolData() {
    return $.getJSON(window.endpoint || '/data/school.json')
      .then((data) => {

        // flatten survey responses across surveys into one
        const responses = data.surveys.reduce((a,b) => a.concat(b.survey_responses), []);
        const sheds = this.collect(shedColumnNames, data);

        const scatteredPoints = scatter(responses, .00015);

        this.setState({ bounds: sheds.getBounds(),
                        points: scatteredPoints,
                        walksheds: sheds.toGeoJSON(),
                        school: { lat: data.wgs84_lat, lng: data.wgs84_lng } });
      });
  }

  render() {
    return (
      <div className="App">
        <WalkshedMap
          bounds={this.state.bounds}
          points={this.state.points}
          walksheds={this.state.walksheds}
          school={this.state.school}
        />
      </div>
    );
  }
}

export default App;
