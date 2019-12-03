$(document).ready(function(){

    $('#update_password_button').on('click', function(){

        // Disable Form
        toggleForm('#update_password_button');

        $.ajax({
            url: '/api/users/update-password',
            type: "POST",
            dataType: 'json',
            data: $('#update_password_form').serialize(),
            success: function(result) {
                var res = result['result'];

                // Unsuccessful Update
                if(res != "Password Updated") {
                    if(res == formExist("old_password")) {
                        m_body = "Old password requires a value";
                    }else if(res == formExist("new_password")) {
                        m_body = "New password requires a value";
                    } else {
                        m_body = upperFirst(res);
                    }
                    dangerMessage("Update Error. ", m_body);

                    // Enables form
                    toggleForm("#update_password_button");

                    // Goes to top of the page
                    window.scrollTo(0, 0);
                }

                else {
                    // Show success message
                    window.scrollTo(0, 0);
                    successMessage("Password Updated. ", "Password has been updated. Redirecting you to account page...");

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
                toggleForm("#update_password_button");

                // Goes to top of the page
                window.scrollTo(0, 0);
            }
        });

        return false;
    });

});