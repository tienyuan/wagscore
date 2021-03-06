
var wagscore = {};

wagscore.initialize = function () {
  client_geocoder = new google.maps.Geocoder();
};

wagscore.geocodeAddressThenSubmit = function() {
  var address = document.getElementById('address').value;
  client_geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      $('#search_location_lat').val(results[0].geometry.location.lat());
      $('#search_location_lng').val(results[0].geometry.location.lng());
      $('#search_form').submit();
    } else {
      alert('Search was not successful for the following reason: ' + status);
    }
  });
};

wagscore.useMyLocation = function() {
  geoPosition.init();
  geoPosition.getCurrentPosition(wagscore.geoSuccess, wagscore.geoError);
};

wagscore.geoSuccess = function(p) {
  $('#search_location_lat').val(p.coords.latitude);
  $('#search_location_lng').val(p.coords.longitude);
  $('#search_form').submit();
};

wagscore.geoError = function() {
  alert("We could not automatically find your location. Please search for a place.");
};
