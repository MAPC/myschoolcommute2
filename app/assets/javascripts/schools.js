$(document)
  .ready(function() {
    if ($('.schools.show')[0]){
      $('.datepicker').datepicker({ format: 'yyyy-mm-dd' });
    };
  });

