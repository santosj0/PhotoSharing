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
            html += "<a id='remove" + cid + "' href='' class='float-right' data-comment='" + cid + "'>&times;</a>";
        }

         html += "</div>" +
                    "<p class='article-content'>" + comment['comment_text'] + "</p>" +
                "</div>" +
            "</article>";

        $('#comment_section').append(html);

        // Add onclick event
        if(user == comment['commenter'] || user == comment['uploader']){
            $('#remove' + comment['comment_id']).on('click', function(){

                // Generate the data to be sent
                var data = {"comment_id" : $(this).attr("data-comment")};
                $.ajax({
                    url: '/api/photos/remove-comment',
                    type: 'POST',
                    dataType: "json",
                    data: data,
                    success: function(resp) {
                        // TODO: Need to properly handle this later
                        console.log(resp);
                    },
                    error: function(xhr, resp, text) {
                        console.log(xhr, resp, text);
                        serverError(text);

                        // Goes to top of the page
                        window.scrollTo(0, 0);
                    }
                });

                // Prevents link from forced reload
                return false;
            });
        }

    }

}

function noComment() {
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
    

});