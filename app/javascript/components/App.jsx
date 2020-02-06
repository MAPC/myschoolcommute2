import React, { Component } from 'react';
import StreetDropdown from './intersecting-streets/StreetDropdown';
import ChildSurveys from './intersecting-streets/ChildSurveys';
import { Button } from 'semantic-ui-react';
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
    let noErrors = true;
    const ERROR_CLASS = 'error';
    const DEFAULT_POINT = 'POINT (-71 42)';

    document.getElementsByClassName('leaflet-container')[0].addEventListener('click', function() {
      if (geometry.value !== DEFAULT_POINT) {
        mapContainer.classList.remove(ERROR_CLASS);
      }
    })

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

    // if (!window.surveyId) {
    //   field.classList.add(ERROR_CLASS);
    //   noErrors = false;
    // }

    if (noErrors) {
      handleSubmit(event)
    }
  }

  const handleSubmit = (event) => {
    const submit = document.querySelector("button[type='submit'")
    submit.innerText="Submitting..."
    submit.disabled = true
    const submission = new FormData(event.target)
    submission.append("survey_response[survey_id]", window.survey_id)
    axios({
      method: 'post',
      url: '/survey_responses',
      data: submission,
      headers: { 'X-CSRF-TOKEN': csrfToken, 'Accept': 'application/json' },
      responseType: "json",
    })
    .then(function (response) {
      submit.innerText="Submitted"
      document.querySelector('.submit__results-text').innerText = response.data.message
    })
    .catch(function (error) {
      console.log(error);
    })
  }

  return (
    <>
      <form className="new_survey_response" id="new_survey_response" acceptCharset="UTF-8" _lpchecked="1" onSubmit={verifySubmission}>
        <StreetDropdown />
        <ChildSurveys />
        <Button type='submit'>Submit</Button>
      </form>
      <div className="submit__results-text"></div>
    </>
  )
}

export default App;
