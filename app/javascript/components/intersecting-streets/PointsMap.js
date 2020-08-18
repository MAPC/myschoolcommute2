import React, { Component } from 'react';
import { Map, Marker, TileLayer } from 'react-leaflet';

class PointsMap extends Component  {
  render() {
    return (
      <div className="map-container">
        <div className="required field"><label>{window.__('What is your approximate home location?')} <span className="required">({window.__('required') })</span></label></div>
        <div>{window.__('Please click the map at an intersection on your street, near your home:')}</div>
        <Map center={this.props.center} zoom={this.props.zoom} onClick={this.props.addCustomPoint.bind(this)}>
          <TileLayer
            attribution='&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
            url='http://{s}.tile.osm.org/{z}/{x}/{y}.png'
          />
          <Marker position={this.props.school} className="active-marker" />
          {
            this.props.points.map((point, index) => {
              var _opacity = (!this.props.customPoint && index === this.props.selectedIndex) ? 1 : .4;
              return <Marker opacity={_opacity} onClick={this.props.onMarkerClick.bind(this, index)} position={[point.lat, point.lng]} key={index} />
            }
            )
          }

          { this.props.customPoint ? <Marker position={[this.props.customPoint.lat, this.props.customPoint.lng]} key={1} /> : null }
        </Map>
      </div>
    )
  }
} 

export default PointsMap;
