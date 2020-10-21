$(function() {
    function toggleLocationPickup(){
        if ($('input#order_pickup').is(':checked')) {
            $("#locations_pickup").show();
        } else {
            $("#locations_pickup").hide();
        }
    }

    toggleLocationPickup()

    $('input#order_pickup').on('change', function(){
        toggleLocationPickup()
    });
});