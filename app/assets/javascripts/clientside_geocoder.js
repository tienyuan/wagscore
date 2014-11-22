
var client_geocoder;
function initialize() {
  client_geocoder = new google.maps.Geocoder();
}

function geocodeAddress() {
  var address = document.getElementById('address').value;
  client_geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      $('#search_location_lat').val(results[0].geometry.location.lat());
      $('#search_location_lng').val(results[0].geometry.location.lng());
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}

function geocodeAddressAndSubmit() {
  geocodeAddress();
  $('#search_form').submit();
}