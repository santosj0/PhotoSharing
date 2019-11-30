/* Page working */
console.log("Hello!")

function updateComments(comments, user) {

    // Remove anything inside comment section
    $('#comment_section').empty();

    // Add each comment
    for(comment of comments){
        // Storing the comment_id
        cid = comment['comment_id'];
        console.log(cid);

        html = "<article class='media content-section shadow'>" +
                "<div class='media-body'>" +
                    "<div class='article-metadata'>" +
                        "<a class='mr-2' href='#'>" + comment['commenter'] + "</a>" +
                        "<small class='text-muted'>" + comment['comment_date'] + "</small>";

        // Add remove button if user is uploader or commenter
        if(user == comment['commenter'] || user == comment['uploader']){
            html += "<button id='remove" + cid + "' href='' class='float-right btn btn-link text-decoration-none' data-comment='" + cid + "'>&times;</button>";
        }

         html += "</div>" +
                    "<p class='article-content'>" + comment['comment_text'] + "</p>" +
                "</div>" +
            "</article>";

        $('#comment_section').append(html);

        // Add onclick event
        if(user == comment['commenter'] || user == comment['uploader']){
            $('#remove' + comment['comment_id']).on('click', function(){

                // Toggle button
                toggleForm('#remove' + comment['comment_id']);

                // Generate the data to be sent
                var data = {"comment_id" : $(this).attr("data-comment")};
                $.ajax({
                    url: '/api/photos/remove-comment',
                    type: 'POST',
                    dataType: "json",
                    data: data,
                    success: function(resp) {
                        // Result of the deletion
                        result = resp['result'];

                        // Failure result
                        if(result != "Comment has been removed"){
                            dangerMessage("Comment Error. ", result);

                            // Toggle button
                            toggleForm('#remove' + comment['comment_id']);

                            // Go to the top of the page
                            window.scrollTo(0, 0);
                        }

                        // Success Result
                        else {
                            successMessage("Removed. ", "Comment has been removed.");
                            getComments(pid);
                        }

                    },
                    error: function(xhr, resp, text) {
                        console.log(xhr, resp, text);
                        serverError(text);

                        // Goes to top of the page
                        window.scrollTo(0, 0);

                        // Toggle button
                        toggleForm('#remove' + comment['comment_id']);
                    }
                });

                // Prevents link from forced reload
                return false;
            });
        }

    }

}

function noComment() {
    // Remove anything inside comment section
    $('#comment_section').empty();

    // Generate comment message
    $('#comment_section').append('<div id="comment_message" class="content_section"></div>');

    // Provide a default message
    $('#comment_message').html("No comments available.");
}

function getComments(pid){
    $.ajax({
        url: "/api/photos/comments/" + pid,
        type: "GET",
        success: function(resp) {
            if(resp['result'] == "No comments") {
                noComment();
            }else {
                updateComments(resp['result'], resp['user']);
            }

        },
        error: function(xhr, resp, text) {
            console.log(xhr, resp, text);
            serverError(text);
        }
    });

    return false;
}

/* Ajax call to get the comments */
$(document).ready(function(){

    console.log(pid);

    // Adds comment to page immediately
    getComments(pid);

    // Adds new comment on submit
    $('#comment_button').on('click', function(){
        // Disables Form
        toggleForm('#comment_button');

        // Empty placeholder
        $('#comment').removeAttr("placeholder");

        $.ajax({
            url: '/api/photos/add-comment-to-photo',
            type: "POST",
            dataType: "json",
            data: $('#comment_form').serialize(),
            success: function(resp) {

                // Result of the comment
                result = resp['result'];

                // Failure result
                if(result != "Comment Added") {
                    if(result == "photo_id does not exist") {
                        m_body = "Issue with the comment form. Please try again later.";
                    }else if(result == "comment does not exist") {
                        m_body = "Comment is empty.";
                        $('#comment').attr('placeholder', "Write your comment here...");
                    }else {
                        m_body = upperFirst(result);
                    }
                    dangerMessage("Comment Error. ", m_body);
                    window.scrollTo(0, 0);
                }

                // Successful Result
                else {
                    getComments(pid);
                    location.hash = "#comment_form";
                    $('#comment_form').trigger("reset");
                    $('#comment').attr('placeholder', 'Write your comment here...');
                }

                // Turn the form back on
                toggleForm('#comment_button');

            },
            error: function(xhr, resp, text) {
                console.log(xhr, resp, text);
                serverError(text);

                // Enables Form
                toggleForm("#comment_button");

                // Goes to the top of the page
                window.scrollTo(0, 0);

            }
        });

        // Prevents html form submission
        return false;

    });

});