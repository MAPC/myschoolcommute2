import React, { Component } from 'react';
import ChildSurvey from './ChildSurvey';
import { Form, Button } from 'semantic-ui-react';

const counts = [  { value: '0', text: '0'  },
                  { value: '1', text: '1'  },
                  { value: '2', text: '2'  },
                  { value: '3', text: '3'  },
                  { value: '4', text: '4'  },
                  { value: '5', text: '5'  },
                  { value: '6', text: '6'  },
                  { value: '7', text: '7'  },
                  { value: '8', text: '8'  },
                  { value: '9', text: '9'  } ];

class ChildSurveys extends Component {
  constructor(props) {
    super(props);

    this.state = {
      count: 1,
      nrVehicles: '',
      nrLicenses: '',
    };
  }

  AddChild = () => {
    this.setState({ count: this.state.count+1 })
  }

  updateNrVehicles = (event, { value }) => {
    this.setState({ nrVehicles: value });
  }

  updateNrLicenses = (event, { value }) => {
    this.setState({ nrLicenses: value });
  }

  render() {
    let childSurveys = [];
    for (var i = 0; i < this.state.count; i++) {
      childSurveys.push(
        <div key={i}>
          <ChildSurvey id={i+1} />
        </div>
      );
    }
    return (
      <div>
        {childSurveys}
        <Button onClick={this.AddChild}
                type='button'
                className="primary">
          { window.__('Add another child at this school') }
        </Button>

        <Form.Dropdown placeholder='Select from an option below' fluid selection
                  options={ counts }
                  onChange={this.updateNrVehicles}
                  label={ window.__('How many vehicles do you have in your household?') }
                  name={ 'survey_response[nr_vehicles]' }/>

        <input type="hidden" name="survey_response[nr_vehicles]" value={this.state.nrVehicles} />

        <Form.Dropdown placeholder="Select from an option below" fluid selection
                  options={ counts }
                  onChange={this.updateNrLicenses}
                  label={ window.__('How many people in your household have a driver\'s license?') }
                  name={ 'survey_response[nr_licenses]' }/>

        <input type="hidden" name="survey_response[nr_licenses]" value={this.state.nrLicenses} />
      </div>

    );
  }
}

export default ChildSurveys;
