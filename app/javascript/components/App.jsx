import React, { useReducer } from 'react';
import StreetDropdown from './intersecting-streets/StreetDropdown';
import ChildSurveys from './intersecting-streets/ChildSurveys';
import { Form, Button, Dropdown } from 'semantic-ui-react';
import axios from 'axios';
import './intersecting-streets/App.css';

function reducer(state, action) {
  switch(action.type) {
    case 'updateLatLng':
      return {...state, chosenLatLng: action.value}
    case 'updateStudent':
      const updatedStudentInfo = state.studentInfo
      updatedStudentInfo[`${action.id}`][`${action.property}`] = action.value;
      return { ...state, studentInfo: updatedStudentInfo }
    case 'addStudent':
      const increasedStudentInfo = state.studentInfo
      increasedStudentInfo.push({
        grade: '',
        to_school: '',
        from_school: '',
      })
      return { ...state, studentInfo: increasedStudentInfo }
    case 'removeStudent':
      const removedStudentInfo = state.studentInfo
      removedStudentInfo.splice([`${action.id}`], 1)
      return { ...state, studentInfo: removedStudentInfo}
    case 'updateVehicles':
      return {...state, nrVehicles: action.value}
    case 'updateLicenses':
      return {...state, nrLicenses: action.value}
    default:
      throw new Error();
  }
}

function App() {
  const [state, dispatch] = useReducer(reducer, {
    chosenLatLng: 'POINT (-71 42)',
    studentInfo: [{
      grade: '',
      to_school: '',
      from_school: '',
    }],
    nrLicenses: '',
    nrVehicles: '',
  })
  const csrfToken = document.querySelector('[name=csrf-token]').content

  const verifySubmission = (event) => {
    event.preventDefault();
    const form = document.querySelector('#root').parentNode;
    const mapContainer = form.querySelector('.map-container');
    const formFields = Array.from(form.querySelectorAll('*[required]')); // the user might add more fields dynamically
    const surveySelectDropdown = form.querySelector('.survey-id-selection')
    let noErrors = true;
    const ERROR_CLASS = 'error';
    const DEFAULT_POINT = 'POINT (-71 42)';

    // Bulk editor - select which survey to run
    if (surveySelectDropdown) {
      if (!surveySelectDropdown.querySelector('input[name="survey_response[survey_id]"]').getAttribute('value')) {
        surveySelectDropdown.classList.add(ERROR_CLASS);
        noErrors = false;
        return;
      } else {
        surveySelectDropdown.classList.remove(ERROR_CLASS)
      }
    }

    // Check if coordinates are selected on map or from dropdowns
    if (state.chosenLatLng === DEFAULT_POINT) {
      mapContainer.classList.add(ERROR_CLASS);
      noErrors = false;
      return;
    }
    else {
      mapContainer.classList.remove(ERROR_CLASS);
    }

    // Make sure each field has a filled, corresponding piece of state
    formFields.forEach((field) => {
      let studentId = /\d+/.exec(field.id)[0]
      let studentField = /\D+/.exec(field.id)[0].slice(0, -1)

      if (!state.studentInfo[studentId][`${studentField}`]) {
        field.classList.add(ERROR_CLASS);
        noErrors = false;
        return;
      }
    });

    if (noErrors) {
      const formResponse = {};
      formResponse.geometry = state.chosenLatLng
      state.studentInfo.forEach((student, i) => {
        formResponse[`grade_${i}`] = student.grade
        formResponse[`to_school_${i}`] = student.to_school
        formResponse[`from_school_${i}`] = student.from_school
        formResponse[`dropoff_${i}`] = student.dropoff
        formResponse[`pickup_${i}`] = student.pickup
      })
      formResponse.nr_licenses = state.nrLicenses
      formResponse.nr_vehicles = state.nrVehicles
      handleSubmit(event, formResponse)
    }
  }

  const handleSubmit = (event, response) => {
    const surveyId = window.isBulkEntry ? +document.querySelector('[name="survey_response[survey_id]"]').getAttribute("value") : window.survey_id;
    const submit = document.querySelector("button[type='submit']")
    submit.innerText="Submitting..."
    submit.disabled = true
    response.survey_id = surveyId
    response.is_bulk_entry = isBulkEntry
    axios({
      method: 'post',
      url: '/survey_responses',
      data: response,
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
  
  return (
    <Form onSubmit={(e) => { return verifySubmission(e) }} className="new_survey_response" id="new_survey_response">
      <StreetDropdown dispatch={dispatch} />
      <ChildSurveys 
        studentInfo={state.studentInfo}
        dispatch={dispatch}
      />
      <label>{ window.__('How many vehicles do you have in your household?') }</label>
      <Dropdown 
        placeholder='Select from an option below' fluid selection
        options={ counts }
        onChange={(e, {value}) => dispatch({type: 'updateVehicles', value: value})}
        name={ 'survey_response[nr_vehicles]' }
      />
      <label>{ window.__("How many people in your household have a driver's license?") }</label>
      <Dropdown
        placeholder="Select from an option below" fluid selection
        options={ counts }
        onChange={(e, {value}) => dispatch({type: 'updateLicenses', value: value})}
        name={ 'survey_response[nr_licenses]' }
      />
      <Button type='submit'>Submit</Button>
      <div className="submit__results-text"></div>
    </Form>
  )
}

export default App;
