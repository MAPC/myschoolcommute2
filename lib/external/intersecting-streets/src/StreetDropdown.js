import React, { Component } from 'react';
import PointsMap from './PointsMap';
import { Form } from 'semantic-ui-react';
import $ from 'jquery';
import L from 'leaflet';

const endpoint = "//mapc-admin.carto.com/api/v2/sql?q=";
const muni_id = window.muni_id || 1;
const school = window.school || { lat: 42, lng: -71 };

let muniCache = [];

const initialState = {
  munis: muniCache,
  muni: muni_id,
  initialStreets: [{
    name: '',
    value: 1
  }],
  intersectingStreets: [{
    name: '',
    value: 1
  }],
  customPoint: null,
  selectedIntersection: null,
  selectedIntersectionIndex: 0,
  points: [{ lat: 42, lng: -71 }],
  lat: school.lat,
  lng: school.lng,
  school,
  zoom: 16,
  showDropdowns: false,
};

class StreetDropdown extends Component {
  constructor(props) {
    super(props);

    this.state = initialState;
    this.query = '';
  }

  componentDidMount() {
    this.Munis();
    this.InitialStreets(this.state.muni);
  }

  Munis() {
    if (muniCache.length > 0) {
      return this.setState({ munis: muniCache})
    }

    return $.getJSON(`${endpoint}SELECT DISTINCT(town) as text, town_id as value FROM %22mapc-admin%22.survey_intersection ORDER BY town`)
      .then(data => {
        muniCache = data.rows;
        this.setState({ munis: muniCache })
      });
  }

  InitialStreets(muni) {
    return $.getJSON(`${endpoint}SELECT DISTINCT(st_name_1) AS text%20, st_name_1 AS value FROM%20%22mapc-admin%22.survey_intersection%20WHERE town_id=${muni} ORDER BY st_name_1`)
      .then((data) => {
        this.setState({ initialStreets: data.rows });
      });
  }

  IntersectingStreets(street) {
    let encodedStreet = street;
    return $.getJSON(`${endpoint}SELECT DISTINCT(st_name_2) AS text, st_name_2 AS value FROM%20%22mapc-admin%22.survey_intersection%20WHERE st_name_1='${encodedStreet}' AND town_id=${this.state.muni} ORDER BY st_name_2`)
      .then((data) => {
        const sortedRows = data.rows.sort((a,b) => (a.text > b.text) ? 1 : -1);

        this.setState({ intersectingStreets: sortedRows });
        this.IntersectingPoints(street);
      });
  }

  IntersectingPoints = (street) => {
    let encodedStreet = street;
    return $.getJSON(`${endpoint}SELECT DISTINCT(st_name_2) AS text, lat, long AS lng FROM%20%22mapc-admin%22.survey_intersection%20WHERE st_name_1='${encodedStreet}' AND town_id=${this.state.muni}`)
      .then((data) => {
        const sortedRows = data.rows.sort((a,b) => (a.text > b.text) ? 1 : -1);
        let latlngs = sortedRows.map((row) => { return [row.lat,row.lng]; });
        let center = new L.LatLngBounds(latlngs).getCenter();

        this.setState({ points: sortedRows,
                        lat: center.lat,
                        lng: center.lng });
      });
  }

  OnMuniChange = (event, { value }) => {
    this.setState({
      ...initialState,
      muni: value,
      munis: muniCache,
      showDropdowns: true,
    });
    this.InitialStreets(value);
  }

  OnDropdownChange = (event, data) => {
    this.setState({selectedIntersectionIndex: 0})
    this.IntersectingStreets(data.value);
  }

  OnIntersectingPointsChange = (event, data) => {
    let chosenIndex = data.options.findIndex((el) => { return el.value === data.value });
    this.setState({ selectedIntersectionIndex: chosenIndex, customPoint: null }, done => {
      this.forceUpdate();
    });
  }

  OnMarkerClick = (index) => {
    this.setState({ selectedIntersectionIndex: index, customPoint: null });
  }

  AddCustomPoint = (loc) => {
    this.setState({ customPoint: { lat: loc.latlng.lat, lng: loc.latlng.lng } });
  }

  ShowDropdowns = (event) => {
    this.setState({ showDropdowns: true });
  }

  render() {
    let initialStreets = this.state.initialStreets,
        intersectingStreets = this.state.intersectingStreets,
        selectedIntersection = this.state.points[this.state.selectedIntersectionIndex],
        munis = this.state.munis,
        muni = this.state.muni,
        onMuniChange = this.OnMuniChange,
        onFirstChange = this.OnDropdownChange,
        onSecondChange = this.OnIntersectingPointsChange,
        onMarkerClick = this.OnMarkerClick,
        chosenLatLng = this.state.customPoint || selectedIntersection;

    return (
      <div className="ui equal width padded grid">
        <div className="row">
          <PointsMap  zoom={this.state.zoom}
                      points={this.state.points}
                      school={this.state.school}
                      center={[this.state.lat,this.state.lng]}
                      onMarkerClick={onMarkerClick}
                      customPoint={this.state.customPoint}
                      addCustomPoint={this.AddCustomPoint}
                      selectedIndex={this.state.selectedIntersectionIndex} />
        </div>
        <div className="row" onClick={this.ShowDropdowns} style={{display: this.state.showDropdowns ? 'none' : 'inherit'}}>
          <div className="ui button">{window.__('...or tell us the street intersection closest to your home.')}</div>
        </div>
        <div className={this.state.showDropdowns ? 'row active' : 'row'} style={{display: this.state.showDropdowns ? 'flex' : 'none'}}>
          <div className="column">
            <div className="field">
              <Form.Dropdown placeholder='Select from an option below' fluid search selection
                        options={munis}
                        value={muni}
                        label={ window.__('Name of your town/city') }
                        onChange={onMuniChange} />
            </div>
          </div>
          <div className="column">
            <div className="field">
              <Form.Dropdown placeholder='Select from an option below' fluid search selection
                        options={ initialStreets }
                        label={ window.__('Name of your street') }
                        onChange={onFirstChange} />
            </div>
          </div>
          <div className="column">
            <div className="field">
              <Form.Dropdown placeholder='Select from an option below' fluid search
                        value={selectedIntersection.text} selection
                        options={ intersectingStreets }
                        label={ window.__('Name of nearest cross-street') }
                        onChange={onSecondChange} />
            </div>
          </div>
          <input type="hidden" name="survey_response[geometry]" value={`POINT (${chosenLatLng['lng']} ${chosenLatLng['lat']})`} />
        </div>
      </div>
    )
  }
}

export default StreetDropdown
