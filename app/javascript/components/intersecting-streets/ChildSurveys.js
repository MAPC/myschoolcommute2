import React, { useState } from 'react';
import ChildSurvey from './ChildSurvey';
import { Button } from 'semantic-ui-react';

const ChildSurveys = () => {
  const [count, addChild] = useState(1);

  let childSurveys = [];
  for (var i = 0; i < count; i++) {
    childSurveys.push(
      <div key={i}>
        <ChildSurvey id={i+1} />
      </div>
    );
  }

  return (
    <div>
      {childSurveys}
      <Button 
        onClick={() => addChild(count+1)}
        type='button'
        className="primary"
      >
        { window.__('Add another child at this school') }
      </Button>
    </div>
  );
};

export default ChildSurveys;
