import React, { useReducer } from 'react';
import ChildSurvey from './ChildSurvey';
import { Button } from 'semantic-ui-react';

function reducer(state, action) {
  switch(action.type) {
    case 'updateStudent':
      const updatedStudentInfo = state.studentInfo
      updatedStudentInfo[`${action.id}`][`${action.property}`] = action.value;
      return { studentInfo: updatedStudentInfo }
    case 'addStudent':
      const increasedStudentInfo = state.studentInfo
      increasedStudentInfo.push({
        grade: '',
        to_school: '',
        dropoff: '',
        from_school: '',
        pickup: ''
      })
      return { studentInfo: increasedStudentInfo }
    case 'removeStudent':
      const removedStudentInfo = state.studentInfo
      removedStudentInfo.splice([`${action.id}`], 1)
      return { studentInfo: removedStudentInfo}
    default:
      throw new Error();
  }
}

const ChildSurveys = () => {
  const [state, dispatch] = useReducer(reducer, {
    studentInfo: [{
      grade: '',
      to_school: '',
      dropoff: '',
      from_school: '',
      pickup: '',
    }]
  })
  let childSurveys = [];
  for (var i = 0; i < state.studentInfo.length; i++) {
    childSurveys.push(
      <ChildSurvey
        id={i}
        key={i}
        studentInfo={state.studentInfo}
        dispatch={dispatch}
      />
    );
  }

  return (
    <div>
      {childSurveys}
      <Button
        onClick={() => dispatch({type: 'addStudent'})}
        type='button'
        className="primary"
      >
        { window.__('Add another child at this school') }
      </Button>
    </div>
  );
};

export default ChildSurveys;
