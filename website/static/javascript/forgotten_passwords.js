$(document).ready(function(){

    // Submit on button click
    $('#password_button').on('click', function(){

        // Disables form
        toggleForm("#password_button");

        $.ajax({
            url: "/api/users/send-password-reset",
            type: "POST",
            dataType: "json",
            data: $('#password_form').serialize(),
            success: function(result) {
                var res = result['result'];

                // Unsuccessful Registration
                if(!res['message']) {

                    dangerMessage("Password Reset Error.", upperFirst(res));

                    // Enables form
                    toggleForm("#password_button");

                    // Goes to top of the page
                    window.scrollTo(0, 0);
                }

                // User has successfully registered so either goes
                // to previous page or the homepage if previous
                // page does not exist
                else {
                    // Goes to top of the page
                    window.scrollTo(0, 0);

                    // Remove the form
                    $('#password_form').remove();

                    // Remove the styling
                    $('#password_container').removeAttr('style');

                    // Display Verification message
                    $('#password_valid').append(
                        "<h1>Email has been sent!</h1><p>Please refer to " + res['email'] + " for the link to reset your password.</p>"
                    );
                }
            },
            error: function(xhr, resp, text) {
                console.log(xhr, resp, text);
                serverError(text);

                // Enables form
                toggleForm("#password_button");

                // Goes to top of the page
                window.scrollTo(0, 0);
            }
        });

        // Prevents html form submission
        return false;

    });

});