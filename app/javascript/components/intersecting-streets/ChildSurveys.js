import React from 'react';
import ChildSurvey from './ChildSurvey';
import { Button } from 'semantic-ui-react';

const ChildSurveys = ({studentInfo, dispatch}) => {
  let childSurveys = [];
  for (var i = 0; i < studentInfo.length; i++) {
    childSurveys.push(
      <ChildSurvey
        id={i}
        key={i}
        studentInfo={studentInfo}
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
