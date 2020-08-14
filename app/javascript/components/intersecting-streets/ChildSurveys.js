import React, { useState } from 'react';
import ChildSurvey from './ChildSurvey';
import { Button } from 'semantic-ui-react';

const ChildSurveys = () => {
  const [count, setStudentCount] = useState(3);
  const [studentInfo, setStudentInfo] = useState({
    'grade_1': "1",
    'grade_2': "2",
    'grade_3': "3"
  })
  console.log(studentInfo)
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
