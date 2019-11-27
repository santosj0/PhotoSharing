/* Hides the message box on button click */
$('#message_close').on('click', function(){
    $('#message').hide();
});

/* Function to display error messages */
function dangerMessage(status, body) {
    $('#message').removeClass("alert-success").removeClass("alert-warning");
    $('#message').addClass("alert-danger");
    $('#message_status').text(status + " ");
    $('#message_body').text(body);
    $('#message').show();
}

/* Server issue */
function serverError(err) {
    dangerMessage(err, "There has been an issue sending the form, please try again later.");
}

/* Function to display good messages */
function successMessage(status, body) {
    $('#message').removeClass("alert-danger").removeClass("alert-warning");
    $('#message').addClass("alert-success");
    $('#message_status').text(status + " ");
    $("#message_body").text(body);
    $("#message").show();
}

/* Function to display warning messages */
function warningMessage(status, body) {
    $('#message').removeClass("alert-danger").removeClass("alert-success");
    $('#message').addClass("alert-warning");
    $('#message_status').text(status + " ");
    $('#message_body').text(body);
    $('#message').show();
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

/* Makes the letter of the first string into an uppercase */
function upperFirst(word) {
    return word.replace(/^\w/, c => c.toUpperCase());
}

/* Form item does not exist */
function formExist(param) {
    return param + " does not exist";
}