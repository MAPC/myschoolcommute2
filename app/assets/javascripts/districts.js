
$(document)
  .ready(function() {
    if ($('.districts.index')[0]){
      $.getJSON('/districts.json?all=true', function(results) {
        $('.ui.search').search({
          source: results,
          searchFields   : [
            'distname'
          ],
          fields: {
            title: 'distname'
          }
        });
      })
    };
  });
  