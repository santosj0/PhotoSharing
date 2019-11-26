/* Display the previous page */
console.log(document.referrer);

/* Ajax call to log the user in */
$(document).ready(function(){
    // Submit on button mouse-up
    $("#login_button").on('click', function(){
        $.ajax({
            url: "/api/users/login",
            type: "POST",
            dataType: "json",
            data: $("#login_form").serialize(),
            success: function(result) {

                // Unsuccessful Login result
                if(result['result'] != "Logged in"){
                    console.log(result);
                }

                // User is successfully logged so either goes
                // to previous page or the homepage if previous
                // page does not exist
                else{
                    if(document.referrer){
                        window.location = document.referrer;
                    }else{
                        window.location = "/";
                    }
                }


            },
            error: function(xhr, resp, text) {
                console.log(xhr, resp, text);
            }
        });

        return false;
    });
});