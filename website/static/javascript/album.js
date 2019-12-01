$(document).ready(function(){
    $("button[data-pid]").each(function(){
        // Get photo_id
        var pid = $(this).data('pid');
        var title = $(this).data('title');

        $(this).on('click', function(){

            // Toggles button
            toggleForm('#remove' + pid);

            // Confirmation for photo deletion
            if(confirm("Are you sure you wish to delete this photo: " + title+ "?")) {
                if(confirm("Are you 100% certain you wish to delete this photo: " + title + "?!")) {
                    $.ajax({
                        url: '/api/photos/remove-photo',
                        type: 'POST',
                        dataType: "json",
                        data: {'photo_id' : pid},
                        success: function(resp) {
                            result = resp['result'];

                            // Failure result
                            if(result != "Photo has been removed") {
                                dangerMessage("Photo Error. ", result);
                            }

                            //Success Result
                            else {
                                location.reload();
                            }

                            console.log(resp['result']);
                        },
                        error: function(xhr, resp, text) {
                            // Display Error
                            console.log(xhr, resp, text);
                            serverError(text);
                        }
                    });

                    // Goes to top of the page
                    window.scrollTo(0, 0);
                }
            }

            // Toggle button
            toggleForm('#remove' + pid);

        });
    });
});