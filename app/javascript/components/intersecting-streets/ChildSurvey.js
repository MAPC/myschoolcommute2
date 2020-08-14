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

const deleteStudentEntry = (e, id, studentInfo, setStudentInfo, count, setStudentCount) => {
  e.preventDefault()
  setStudentInfo(() => {
    console.log(`Delete id ${id} out of ${count} total objects`)
    let tempStudentInfo = studentInfo;
     for (let i = id; i <= count; i++) {
      tempStudentInfo[`grade_${i}`] = tempStudentInfo[`grade_${i+1}`]
      tempStudentInfo[`to_school_${i-1}`] = tempStudentInfo[`to_school_${i}`]
      tempStudentInfo[`dropoff_${i-1}`] = tempStudentInfo[`dropoff_${i}`]
      tempStudentInfo[`from_school_${i-1}`] = tempStudentInfo[`from_school_${i}`]
      tempStudentInfo[`pickup_${i-1}`] = tempStudentInfo[`pickup_${i}`]
    }
    delete tempStudentInfo[`grade_${count}`]
    delete tempStudentInfo[`to_school_${count}`]
    delete tempStudentInfo[`dropoff_${count}`]
    delete tempStudentInfo[`from_school_${count}`]
    delete tempStudentInfo[`pickup_${count}`]
    return tempStudentInfo
  })
  
  setStudentCount(count-1);
}

const ChildSurvey = ({id, setStudentCount, count, studentInfo, setStudentInfo}) => {
  const deleteButton = id > 1
    ? <button
        onClick={(e) => deleteStudentEntry(e, id, studentInfo, setStudentInfo, count, setStudentCount)}
        id={`remove${id}`}
      >
        x
      </button>
    : '';

  return (
    <div className="child-survey">
      <div className="ui attached segment">
        <div className="ui top attached label child-survey__header">
          <span>Child {id}</span>
          {deleteButton}
        </div>
        <Form.Dropdown
          placeholder='Select from an option below' fluid selection
          required
          label={ window.__('What grade is your child in?') }
          options={ grades }
          onChange={ (e, { value }) => setStudentInfo({...studentInfo, [`grade_${id}`]: value}) }
          name={ `survey_response[grade_${id}]` }
          value={studentInfo[`grade_${id}`]}
        />
        <Form.Dropdown
          placeholder='Select from an option below' fluid selection
          required
          onChange={ (e, { value }) => setStudentInfo({...studentInfo, [`to_school_${id}`]: value}) }
          options={ modes }
          label={ window.__('How does your child get TO school on most days?') }
          name={ `survey_response[to_school_${id}]` }
        />
        <TripReasonQuestion
          id={id}
          mode={studentInfo[`to_school_${id}`]}
          onChange={ (e, { value }) => setStudentInfo({...studentInfo, [`dropoff_${id}`]: value}) }
          name={ `survey_response[dropoff_${id}]` }
          question='Do you usually drop off your child on your way to work or another destination (other than home)?'
        />
        <Form.Dropdown
          placeholder='Select from an option below' fluid selection
          required
          onChange={ (e, { value }) => setStudentInfo({...studentInfo, [`from_school_${id}`]: value}) }
          options={ modes }
          label={ window.__('How does your child get home FROM school on most days?') }
          name={ `survey_response[from_school_${id}]` }
        />
        <TripReasonQuestion
          id={id}
          mode={studentInfo[`from_school_${id}`]}
          onChange={ (e, { value }) => setStudentInfo({...studentInfo, [`pickup_${id}`]: value}) }
          name={ `survey_response[pickup_${id}]` }
          question='Do you usually pick up your child on your way from work or another location (other than home)?'
        />
      </div>
    </div>
  )
};

export default ChildSurvey;
