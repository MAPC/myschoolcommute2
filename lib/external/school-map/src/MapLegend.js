import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import hexToRgb from './utils/hex-to-rgb';
import { shedColorMap, modes } from './utils/data-maps';


class MapLegend extends Component {


  componentDidMount() {
    const legend = ReactDOM.findDOMNode(this.refs.legend);
    legend.setAttribute('leaflet-browser-print-content', true);
  }


  render() {

    const renderModes = () => {
      const uniqueModeCodes = [...new Set(this.props.points.map(point => point.to_school))].filter(x => x !== null);
      const uniqueModes = uniqueModeCodes.map(code => modes[code]);

      return uniqueModes.map((mode, index) => {
        return (
          <li key={index}>
            <span>
              <svg height="20" width="20">
                <circle r="10" cx="10" cy="10" fill={mode.color}></circle>
              </svg>
            </span>

            {mode.name}
          </li>
        );
      });
    };

    const renderWalksheds = () => {
      const shedKeys = Object.keys(shedColorMap).reverse();
      const colors = Object.values(shedColorMap).reverse();

      const distances = shedKeys.map(key => parseFloat(key.split('_')[1]) / 10);

      return distances.map((distance, index) => {
        var rgb = hexToRgb(colors[index]);

        return (
          <li key={index}>
            <span>
              <svg height="25" width="25">
                <rect height="25" width="25" fill={`rgba(${rgb.r}, ${rgb.g}, ${rgb.b}, .3)`}></rect>
              </svg>
            </span>

            {distance.toFixed(1)} Mile
          </li>
        );
      });
    };


    return (
      <div className="MapLegend" ref="legend">

        <div className="modes">
          <h4>Approx. home locations and travel to school mode</h4>
          <ul>
            {renderModes()}
          </ul>
        </div>

        <div className="walksheds">
          <h4>Walksheds</h4>
          <ul>
            {renderWalksheds()}
          </ul>
        </div>

      </div>
    );
  }

}


export default MapLegend;
