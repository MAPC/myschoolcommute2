 var mymap = L.map('school-location').setView([42.360, -72.058], 9);
 var clickMarker
 var latlong

 L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
     attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
     maxZoom: 18,
     id: 'mapbox.streets',
     accessToken: 'pk.eyJ1IjoibXphZ2FqYSIsImEiOiJ5N0Y3Z3pVIn0.Wqu2VeG4ycaw0nPrwy0-sA'
 }).addTo(mymap);

 function onMapClick(e) {
   if (clickMarker) {
    clickMarker.setLatLng([e.latlng.lat, e.latlng.lng])
    latlong.setAttribute("value", "POINT(" + e.latlng.lng + " " + e.latlng.lat + ")")
    } else {
      clickMarker = L.marker([e.latlng.lat, e.latlng.lng]).addTo(mymap);
      latlong = L.DomUtil.get("school_geometry");
      latlong.setAttribute("value", "POINT(" + e.latlng.lng + " " + e.latlng.lat + ")")
   }
 }

 mymap.on('click', onMapClick);
 // Potential refactor suggestion link: https://jsfiddle.net/f2hkkx8c/
