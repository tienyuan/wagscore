
var client_geocoder;
function initialize() {
  client_geocoder = new google.maps.Geocoder();
}

function codeAddress() {
  var address = document.getElementById('address').value;
  client_geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      alert(results[0].geometry.location);
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}

