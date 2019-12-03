$(document).ready(function(){

    $('#delete-user').on('click', function(){

        // Disables button
        toggleForm('#delete-user');

        if(confirm("Are you sure you want to delete this account?")){
            if(confirm("Are you 100% sure you want to delete this account?")){

                $.ajax({
                    url: '/api/users/delete-user',
                    type: "POST",
                    dataType: 'json',
                    data: {'confirmation': true},
                    success: function(result) {
                        var res = result['result'];

                        // Unsuccessful result
                        if(res != "User has been removed") {
                            dangerMessage("User Removal. ", res);
                        }else {
                            window.location = "/";
                        }

                    },
                    error: function(xhr, resp, text) {
                        console.log(xhr, resp, text);
                        serverError(text);
                    }
                });

            }
        }

        // Enables form
        toggleForm("#delete-user");

        // Goes to top of the page
        window.scrollTo(0, 0);

        // Prevents link redirect
        return false;
    });

});