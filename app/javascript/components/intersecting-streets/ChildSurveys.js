import React, { useState } from 'react';
import ChildSurvey from './ChildSurvey';
import { Button } from 'semantic-ui-react';

const ChildSurveys = () => {
  const [count, setStudentCount] = useState(1);
  const [studentInfo, setStudentInfo] = useState({})
  let childSurveys = [];
  for (var i = 0; i < count; i++) {
    childSurveys.push(
      <ChildSurvey
        id={i+1}
        setStudentCount={setStudentCount}
        count={count}
        key={i}
        studentInfo={studentInfo}
        setStudentInfo={setStudentInfo}
      />
    );
  }

  return (
    <div>
      {childSurveys}
      <Button 
        onClick={() => setStudentCount(count+1)}
        type='button'
        className="primary"
      >
        { window.__('Add another child at this school') }
      </Button>
    </div>
  );
};

export default ChildSurveys;
