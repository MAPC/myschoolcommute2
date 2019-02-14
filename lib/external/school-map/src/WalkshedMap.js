import L from 'leaflet';
import React, { Component } from 'react';
import MapLegend from './MapLegend';
import LeafletPrintPlugin from './LeafletPrintPlugin';
import { shedColorMap, modes } from './utils/data-maps';
import { Map, GeoJSON, CircleMarker, TileLayer } from 'react-leaflet';

import './styles/WalkshedMap.css';


// initialize non-AMD/reacty leaflet plugin
LeafletPrintPlugin();

class WalkshedMap extends Component {

  componentDidMount() {
    if (!window.staticRender) {
      const map = this.refs.map.leafletElement;
      L.browserPrint().addTo(map);
    }
  }

  style = (feature) => {
    return {
      color: shedColorMap[feature.properties.distance]
    }
  }

  render() {
    const geojson = () => {
        if (this.props.walksheds) {
            return <GeoJSON data={this.props.walksheds}
                            style= {
                              (feature) => {
                                return {
                                  color: shedColorMap[feature.properties.shed],
                                  weight: 1,
                                  opacity: 0.3
                                }
                              }
                            } />

        }
    };

    const school = () => {
      if(this.props.school) {
        return <CircleMarker  center={this.props.school}
                              color={'red'}
                              fillColor={'#f03'}
                              fillOpacity={0.5} />
      }
    };

    const survey_responses = () => {
      const points = this.props.points;

      if (points.length > 0) {
        return points.map((point, index) => {
          var geom = point.geometry;

          if (point.to_school !== null) {
            return <CircleMarker center={[geom.coordinates[1], geom.coordinates[0]]}
                          key={index}
                          radius={3}
                          fillColor={modes[point.to_school].color}
                          color={"#000"}
                          weight={1}
                          opacity={1}
                          fillOpacity={0.8} />
          }

          return null;
        }).filter(x => x !== null);
      }
    };

    return (
      <div className={`WalkshedMap ${window.staticRender ? 'static' : null}`}>
        <Map bounds={this.props.bounds} zoomControl={!window.staticRender} ref='map'>
          <TileLayer
            url='https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png'
          />
          {geojson()}
          {school()}
          {survey_responses()}
          <MapLegend
            points={this.props.points}
            walksheds={this.props.walksheds}
          />
        </Map>
      </div>
    );
  }
}

export default WalkshedMap;
