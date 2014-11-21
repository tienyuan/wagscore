
var client_geocoder;
function initialize() {
  client_geocoder = new google.maps.Geocoder();
}

function codeAddress() {
  var address = document.getElementById('address').value;
  client_geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      console.log(results)
      $('#search_location_lat').val(location.lat());
      alert(results[0].geometry.location.lat()); #put this into .val for hidden field
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}

function geocodeAddressAndSubmit() {
  codeAddress()

}