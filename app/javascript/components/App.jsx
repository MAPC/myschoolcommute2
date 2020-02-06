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
      setTimeout(function() { location.reload(); }, 2000);
    })
    .catch(function (error) {
      console.log(error);
      submit.innerText="Submission failed"
      document.querySelector('.submit__results-text').innerText = "Something went wrong. Please contact an administrator."
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
