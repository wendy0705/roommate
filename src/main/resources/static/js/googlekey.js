document.addEventListener('DOMContentLoaded', function () {
    var apiKey = [[${googleMapsApiKey}]];
    var script = document.createElement('script');
    script.src = 'https://maps.googleapis.com/maps/api/js?key=' + apiKey + '&callback=initMap&libraries=drawing&v=beta';
    script.defer = true;
    document.head.appendChild(script);
});