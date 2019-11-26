/* Display the previous page */
console.log(document.referrer);

/* Ajax call to register the user */
$(document).ready(function(){

    // Submit on button click
    $('#register_button').on('click', function(){
        // Disables form
        toggleForm("#register_button");

        $.ajax({
            url: "/api/users/register",
            type: "POST",
            dataType: "json",
            data: $('#register_form').serialize(),
            success: function(result) {

                // Unsuccessful Registration
                if(result['result'] != "User is registered") {
                    if(result['result'] == "Invalid Profile Picture" || result['result'] == formExist("profile_pic")) {
                        m_body = "Please select a profile picture. It will highlight blue for the selected image.";
                    }else {
                        m_body = upperFirst(result['result']);
                    }
                    dangerMessage("Registration Error.", m_body);

                    // Enables form
                    toggleForm("#register_button");

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
                    $('#register_form').remove();

                    // Display Verification message
                    $('#register_valid').append(
                        "<h1>User has been registered!</h1><p>Please refer to the email you have provided for verification.</p>"
                    );
                }
            },
            error: function(xhr, resp, text) {
                console.log(xhr, resp, text);
                serverError(text);

                // Enables form
                toggleForm("#register_button");

                // Goes to top of the page
                window.scrollTo(0, 0);
            }
        });

        // Prevents html form submission
        return false;
    });
});