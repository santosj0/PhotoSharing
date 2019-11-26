/* Display the previous page */
console.log(document.referrer);

/* Ajax call to log the user in */
$(document).ready(function(){

    // Submit on button click
    $("#login_button").on('click', function(){
        // Disables form
        toggleForm("#login_button");

        $.ajax({
            url: "/api/users/login",
            type: "POST",
            dataType: "json",
            data: $("#login_form").serialize(),
            success: function(result) {

                // Unsuccessful Login result
                if(result['result'] != "Logged in"){
                    dangerMessage("Login Error.", result['result']);

                    // Enables form
                    toggleForm("#login_button");
                }

                // User is successfully logged so either goes
                // to previous page or the homepage if previous
                // page does not exist
                else{
                    successMessage("Logged In.", "You have successfully logged in. Redirecting you now...");

                    setTimeout(function(){
                        if(document.referrer){
                            window.location = document.referrer;
                        }else{
                            window.location = "/";
                        }
                    }, 2000);

                }


            },
            error: function(xhr, resp, text) {
                console.log(xhr, resp, text);
            }
        });

        return false;
    });
});