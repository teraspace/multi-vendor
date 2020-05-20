function getLocation() {
    if ("geolocation" in navigator) {
        navigator.geolocation.getCurrentPosition(function(position) {
            $.post('/session_location', { coords: position.coords });
        });
    } else {
        console.error("Geolocation is not supported by this browser.")
    }
}

$(function() {
    getLocation();
});