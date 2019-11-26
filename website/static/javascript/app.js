/* Hides the message box on button click */
$('#message_close').on('click', function(){
    $('#message').hide();
});

/* Function to display error messages */
function dangerMessage(status, body) {
    if($('#message').hasClass("alert-success")){
        $('#message').removeClass("alert-success");
    }

    $('#message').addClass("alert-danger");
    $('#message_status').text(status + " ");
    $('#message_body').text(body);
    $('#message').show();
}

/* Function to display good messages */
function successMessage(status, body) {
    if($('#message').hasClass("alert-danger")){
        $('#message').removeClass("alert-danger");
    }

    $('#message').addClass("alert-success");
    $('#message_status').text(status + " ");
    $("#Message_body").text(body);
    $("#message").show();
}

/* Logout Handling */
$(document).ready(function(){
    $("#logout").on('click', function(){
        $.ajax({
            url: "/api/users/logout",
            type: "GET",
            success: function(result) {
                // Unsuccessful Logout result
                if(result['result'] != "Logged Out") {
                    dangerMessage("Error.", "Unable to log you out at this time. Please attempt later.")
                }

                // Logs the use out and refreshes the page that they are on
                else {
                    window.location.reload(true);
                }
            }
        });
    });
});

/* Disable/Enable form arguments */
function toggleForm() {
    for(var i = 0; i < arguments.length; i++) {
        $(arguments[i]).prop('disabled', !$(arguments[i]).is(':disabled'));
    }
}