$(document).ready(function() {

  if (document.querySelector('body').classList.contains('surveys')) { // this file is shared by multiple pages
    var ERROR_CLASS = 'error';
    var DEFAULT_POINT = 'POINT (-71 42)';

    var reactRoot = document.querySelector('#root'),
        form = reactRoot.parentNode,
        submit = form.querySelector('input[type="submit"]'),
        mapContainer = form.querySelector('.map-container'),
        geometry = form.querySelector('input[name="survey_response[geometry]"]')
        inDistrict = form.querySelector('input[name="survey_response[in_district]"]');

    $('.leaflet-container').click(function() {
      if (geometry.value !== DEFAULT_POINT) {
        mapContainer.classList.remove(ERROR_CLASS);
      }
    });

    $(submit).click(function(e) {
      e.preventDefault();

      var formFields = Array.from(form.querySelectorAll('*[required]')); // the user might add more fields dynamically
      var noErrors = true;

      if (inDistrict.checked && geometry.value === DEFAULT_POINT) {
        mapContainer.classList.add(ERROR_CLASS);
        noErrors = false;
      }
      else {
        mapContainer.classList.remove(ERROR_CLASS);
      }

      formFields.forEach(function(field) {
        var value = field.querySelector(':scope > .text:not(.default)');

        if (!value || value.textContent === '') {
          field.classList.add(ERROR_CLASS);
          noErrors = false;
        }
      });

      if (noErrors) {
        form.submit();
      }
    });
  }

  if ($('.surveys.show')[0]) {
    $('.leaflet-container').css('cursor','crosshair');
  }
});
