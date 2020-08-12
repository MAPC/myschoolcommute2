import React, { useState } from 'react';
import StreetDropdown from './intersecting-streets/StreetDropdown';
import ChildSurveys from './intersecting-streets/ChildSurveys';
import { Form, Button, Dropdown } from 'semantic-ui-react';
import axios from 'axios';
import './intersecting-streets/App.css';

function App() {
  const csrfToken = document.querySelector('[name=csrf-token]').content

  const verifySubmission = (event) => {
    event.preventDefault();
    const form = document.querySelector('#root').parentNode;
    const mapContainer = form.querySelector('.map-container');
    const geometry = form.querySelector('input[name="survey_response[geometry]"]');
    const formFields = Array.from(form.querySelectorAll('*[required]')); // the user might add more fields dynamically
    const surveySelectDropdown = form.querySelector('.survey-id-selection')
    let noErrors = true;
    const ERROR_CLASS = 'error';
    const DEFAULT_POINT = 'POINT (-71 42)';

    if (surveySelectDropdown) {
      if (!surveySelectDropdown.querySelector('input[name="survey_response[survey_id]"]').getAttribute('value')) {
        surveySelectDropdown.classList.add(ERROR_CLASS);
        noErrors = false;
      } else {
        surveySelectDropdown.classList.remove(ERROR_CLASS)
      }
    }

    if (geometry.value === DEFAULT_POINT) {
      mapContainer.classList.add(ERROR_CLASS);
      noErrors = false;
    }
    else {
      mapContainer.classList.remove(ERROR_CLASS);
    }

    formFields.forEach(field => {
      const fieldName=field.attributes.name.nodeValue;
      const input = document.querySelector("input[name='" + fieldName + "']")
  
      if (input.value === '') {
        field.classList.add(ERROR_CLASS);
        noErrors = false;
      }
    });

    if (noErrors) {
      handleSubmit(event)
    }
  }

  const handleSubmit = (event) => {
    const surveyId = window.isBulkEntry ? +document.querySelector('[name="survey_response[survey_id]"]').getAttribute("value") : window.survey_id;
    const submit = document.querySelector("button[type='submit']")
    submit.innerText="Submitting..."
    submit.disabled = true
    const submission = new FormData(event.target)
    submission.append("survey_response[survey_id]", surveyId)
    submission.append("survey_response[is_bulk_entry]", window.isBulkEntry)
    axios({
      method: 'post',
      url: '/survey_responses',
      data: submission,
      headers: { 'X-CSRF-TOKEN': csrfToken, 'Accept': 'application/json' },
      responseType: "json",
    })
    .then(function (response) {
      submit.innerText="Submitted"
      document.querySelector('.submit__results-text').innerText = "Survey response was successfully created. Page refreshing momentarily..."
      sessionStorage.setItem('lastSubmittedSurveyId', surveyId);
      setTimeout(function() { location.reload(); }, 1000);
    })
    .catch(function (error) {
      console.log(error);
      submit.innerText="Submission failed"
      document.querySelector('.submit__results-text').innerText = "Something went wrong. Please contact an administrator."
    })
  }

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
  
  const [nrVehicles, updateNrVehicles] = useState();
  const [nrLicenses, updateNrLicenses] = useState();

  return (
    <Form onSubmit={() => console.log("!")} className="new_survey_response" id="new_survey_response">
      {/* <form className="new_survey_response" id="new_survey_response" acceptCharset="UTF-8" _lpchecked="1" onSubmit={verifySubmission}> */}
        <StreetDropdown />
        <ChildSurveys />
        <label>{ window.__('How many vehicles do you have in your household?') }</label>
        <Dropdown 
          placeholder='Select from an option below' fluid selection
          options={ counts }
          onChange={(value) => updateNrVehicles(value)}
          name={ 'survey_response[nr_vehicles]' }
        />
        <label>{ window.__("How many people in your household have a driver's license?") }</label>
        <Dropdown
          placeholder="Select from an option below" fluid selection
          options={ counts }
          onChange={(value) => updateNrLicenses(value)}
          name={ 'survey_response[nr_licenses]' }
        />
        <Button type='submit'>Submit</Button>
      <div className="submit__results-text"></div>
    </Form>
  )
}

export default App;
