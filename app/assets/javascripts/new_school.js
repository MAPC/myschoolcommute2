 var mymap = L.map('school-location').setView([42.360, -72.058], 9);
 var clickMarker
 var latlong

 L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
  attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
     maxZoom: 18,
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
