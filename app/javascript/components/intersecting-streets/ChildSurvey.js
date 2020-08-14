import React, { useState, Component } from 'react';
import { Form } from 'semantic-ui-react';

// answers and values
// we can internationalize these in rails
const modes = [ {value: "w",    text: "Walk"},
                {value: "fv",   text: "Family Vehicle (only children in your family)"},
                {value: "sb",   text: "School Bus (regular & SPED transport)"},
                {value: "b",    text: "Bike (skateboard, scooter, inline skates, etc.)"},
                {value: "o",    text: "Other (private bus/van, taxi, after-school transport, etc.)"},
                {value: "t",    text: "Transit (city bus, subway, etc.)"},
                {value: "cp",   text: "Carpool (with children from other families)"}
              ].map(option=> {
                return { value: option.value, text: window.__(option.text) };
              });

const grades = [  { value: 'pk',   text: 'Pre-K'},
                  { value: 'k',    text: 'K'},
                  { value: '1',    text: '1'},
                  { value: '2',    text: '2'},
                  { value: '3',    text: '3'},
                  { value: '4',    text: '4'},
                  { value: '5',    text: '5'},
                  { value: '6',    text: '6'},
                  { value: '7',    text: '7'},
                  { value: '8',    text: '8'},
                  { value: '9',    text: '9'},
                  { value: '10',   text: '10'},
                  { value: '11',   text: '11'},
                  { value: '12',   text: '12'}
                ];

const yesNo = [ { value: 'y', text: 'Yes' },
                { value: 'n', text: 'No'  }
              ].map(option=> {
                return { value: option.value, text: window.__(option.text) };
              });

const TripReasonQuestion = ({id, mode, question, name, onChange}) => {
  if (mode === 'fv' || mode === 'cp' ) {
    return (
      <div className="field">
        <Form.Dropdown placeholder={question} fluid selection
                  required
                  name={name}
                  onChange={onChange}
                  label={ window.__(question) }
                  options={ yesNo } />
      </div>
    )
  } else {
    return null
  }
}

const ChildSurvey = ({id, studentInfo, dispatch}) => {
  const deleteButton = id > 0
    ? <button
        onClick={() => dispatch({type: 'removeStudent', id: id})}
        id={`remove${id}`}
      >
        x
      </button>
    : '';

  return (
    <div className="child-survey">
      <div className="ui attached segment">
        <div className="ui top attached label child-survey__header">
          <span>Child {id+1}</span>
          {deleteButton}
        </div>
        <Form.Dropdown
          placeholder='Select from an option below' fluid selection
          required
          label={ window.__('What grade is your child in?') }
          options={ grades }
          onChange={(e, {value}) => dispatch({type: 'updateStudent', id: id, value: value, property: 'grade'})}
          name={ `survey_response[grade_${id}]` }
          value={studentInfo[`${id}`].grade}
        />
        <Form.Dropdown
          placeholder='Select from an option below' fluid selection
          required
          onChange={(e, {value}) => dispatch({type: 'updateStudent', id: id, value: value, property: 'to_school'})}
          options={ modes }
          label={ window.__('How does your child get TO school on most days?') }
          name={ `survey_response[to_school_${id}]` }
          value={studentInfo[`${id}`].to_school}
        />
        <TripReasonQuestion
          id={id}
          mode={studentInfo[`${id}`].to_school}
          onChange={(e, {value}) => dispatch({type: 'updateStudent', id: id, value: value, property: 'dropoff'})}
          name={ `survey_response[dropoff_${id}]` }
          question='Do you usually drop off your child on your way to work or another destination (other than home)?'
          value={studentInfo[`${id}`].dropoff}
        />
        <Form.Dropdown
          placeholder='Select from an option below' fluid selection
          required
          onChange={(e, {value}) => dispatch({type: 'updateStudent', id: id, value: value, property: 'from_school'})}
          options={ modes }
          label={ window.__('How does your child get home FROM school on most days?') }
          name={ `survey_response[from_school_${id}]` }
          value={studentInfo[`${id}`].from_school}
        />
        <TripReasonQuestion
          id={id}
          mode={studentInfo[`${id}`].from_school}
          onChange={(e, {value}) => dispatch({type: 'updateStudent', id: id, value: value, property: 'pickup'})}
          name={ `survey_response[pickup_${id}]` }
          question='Do you usually pick up your child on your way from work or another location (other than home)?'
          value={studentInfo[`${id}`].pickup}
        />
      </div>
    </div>
  )
};

export default ChildSurvey;
