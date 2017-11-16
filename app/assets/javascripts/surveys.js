$(document).ready(function() {

  if (document.querySelector('body').classList.contains('surveys')) { // this file is shared by multiple pages
    var reactRoot = document.querySelector('#root'),
        form = reactRoot.parentNode,
        submit = form.querySelector('input[type="submit"]');

    $(submit).click(function(e) {
      e.preventDefault();

      var formFields = Array.from(form.querySelectorAll('*[required]')); // the user might add more fields dynamically
      var noErrors = true;

      formFields.forEach(function(field) {
        var input = field.querySelector('select');

        if (input.value === '') {
          field.classList.add('error');
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
