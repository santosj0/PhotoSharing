/* Reset preview image */
function resetPreview(){
    $("#preview_image").attr('src', "https://via.placeholder.com/500x600?text=Preview+Image");
}

/* Ajax call to upload a picture */
$(document).ready(function(){

    // Name of file appear on select
    $(".custom-file-input").on("change", function(){
        // Sets the preview image
        var reader = new FileReader();

        // Gets loaded data and render thumbnail
        reader.onload = function(e) {
            $("#preview_image").attr('src', e.target.result);
        };

        // Retrieves the file name
        var fileName = $(this).val().split("\\").pop();

        // Resets the preview/filename
        if(fileName == ''){
            fileName = "Select image...";
            resetPreview();
        }else {
            // Read the image file as a data URL
            reader.readAsDataURL(this.files[0]);
        }


        $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
    });

    // Submit on button click
    $('#upload_button').on('click', function(){

        // Retrieve the form
        var form = $('#upload_form')[0];

        // Create a FormData Object
        var data = new FormData(form);

        // Disables form
        toggleForm('#upload_button');

        $.ajax({
            url: "/api/photos/add-new-picture",
            type: "POST",
            data: data,
            enctype: "multipart/form-data",
            processData: false,
            contentType: false,
            cache: false,
            success: function(result) {
                var res = result['result'];

                // Unsuccessful Upload
                if(res != "Photo Added") {
                    if(res == "Invalid file type"){
                        m_body = "Please select a valid image. Only jpeg, jpg, png, and gifs are allowed.";
                    }else if(res == "title does not exist"){
                        m_body = "Title is empty.";
                    }else if(res == "dcript does not exist"){
                        m_body = "Description is empty.";
                    }else{
                        m_body = upperFirst(res);
                    }

                    dangerMessage("Upload Error.", m_body);
                }

                // Successful Upload
                else {
                    successMessage("Photo Uploaded.", "Photo has been uploaded. You may now upload another.");
                    $('#upload_form').trigger("reset");
                    resetPreview();
                    $(".custom-file-label").html("Select image...");
                }

            },
            error: function(xhr, resp, text) {
                console.log(xhr, resp, text);
                serverError(text);
            },
            complete: function(res) {
                // Enables Form
                toggleForm('#upload_button');
                window.scrollTo(0, 0);
            }
        });

        // Prevents html form submission
        return false;
    });
});