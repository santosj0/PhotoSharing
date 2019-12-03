$(document).ready(function(){

    $('#update_email_button').on('click', function(){

        // Disable Form
        toggleForm('#update_email_button');

        $.ajax({
            url: '/api/users/update-email',
            type: "POST",
            dataType: 'json',
            data: $('#update_email_form').serialize(),
            success: function(result) {
                var res = result['result'];

                // Unsuccessful Update
                if(res != "Email has been updated") {
                    dangerMessage("Update Error. ", upperFirst(res));

                    // Enables form
                    toggleForm("#update_email_button");

                    // Goes to top of the page
                    window.scrollTo(0, 0);
                }

                else {
                    // Show success message
                    window.scrollTo(0, 0);
                    successMessage("Email Updates. ", "Email has been updated. Redirecting you to account page...");

                    // Redirect to Account page
                    setTimeout(function(){
                        window.location = "/account";
                    }, 2000);
                }
            },
            error: function(xhr, resp, text) {
                console.log(xhr, resp, text);
                serverError(text);

                // Enables form
                toggleForm("#update_email_button");

                // Goes to top of the page
                window.scrollTo(0, 0);
            }
        });

        return false;
    });

});