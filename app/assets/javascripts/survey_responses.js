// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document)
  .ready(function() {
    $('.ui.selection.dropdown.noreact')
      .dropdown()
    ;
    if (sessionStorage.getItem('lastSubmittedSurveyId')) {
      $('.selected-survey').val(sessionStorage.getItem('lastSubmittedSurveyId'))
    }
  });