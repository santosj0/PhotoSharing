$(document).ready(function(){

    // Name of file appear on select
    $(".custom-file-input").on("change", function(){
        // Read the file
        var reader = new FileReader();

        // Retrieves the file name
        var fileName = $(this).val().split("\\").pop();

        // Resets the preview/filename
        if(fileName == '') {
            fileName = "Select image...";
        }else {
            reader.readAsDataURL(this.files[0]);
        }

        // Adds selected class to custome-file-label and filename
        $(this).siblings(".custom-file-label").addClass("selected").html(fileName);

    });

    // Update Profile Picture
    $('#update_prof_button').on("click", function(){
        // Disables both forms
        toggleForm('#upload_prof_button');
        toggleForm('#update_prof_button');

        $.ajax({
            url: '/api/photos/update-profile-pic',
            type: "POST",
            dataType: "json",
            data: $('#update_prof_form').serialize(),
            success: function(result) {
                var res = result['result'];

                // Unsuccessful Update
                if(res != 'Profile Picture Updated') {
                    if(res == formExist("profile_pic") || res == "Profile Picture does not exist") {
                        m_body = "Please select a profile picture. It will highlight blue for the selected image.";
                    }else {
                        m_body = upperFirst(res);
                    }

                    dangerMessage("Profile Picture Error. ", m_body);
                }

                // Successful Update
                else {
                    successMessage("Profile Picture Updated. ", "Profile Picture has been updated. Redirecting you to the Account page...");

                    // Redirect to Account page
                    setTimeout(function(){
                        window.location = "/account";
                    }, 2000);
                }
            },
            error: function(xhr, resp, text) {
                console.log(xhr, resp, text);
                serverError(text);
            },
            complete: function(res) {
                // Enables both forms
                toggleForm('#upload_prof_button');
                toggleForm('#update_prof_button');
                window.scrollTo(0, 0);
            }
        });

        // Prevents html form submission
        return false;
    });

    // Submit uploaded profile picture
    $('#upload_prof_button').on('click', function(){
        // Retrieve the form
        var form = $('#upload_prof_form')[0];

        // Create a FormData Object
        var data = new FormData(form);

        // Disables both forms
        toggleForm('#upload_prof_button');
        toggleForm('#update_prof_button');

        $.ajax({
            url: "/api/photos/add-new-profile-pic",
            type: "POST",
            data: data,
            enctype: "multipart/form-data",
            processData: false,
            contentType: false,
            cache: false,
            success: function(result) {
                var res = result['result'];

                // Unsuccessful Upload
                if(res != "Profile Pic added") {
                    if(res == "Invalid file type") {
                        m_body = "Please select a valid image. Only jpeg, jpg, png, and gifs are allowed.";
                    }else {
                        m_body = upperFirst(res);
                    }

                    dangerMessage("Upload Error. ", m_body);
                }

                // Sucessful Upload
                else {
                    successMessage("Profile Picture Updated. ", "Profile Picture has been updated. Redirecting you to the Account page...");

                    // Redirect to Account page
                    setTimeout(function(){
                        window.location = "/account";
                    }, 2000);
                }
            },
            error: function(xhr, resp, text) {
                console.log(xhr, resp, text);
                serverError(text);
            },
            complete: function(res) {
                // Enables both forms
                toggleForm('#upload_prof_button');
                toggleForm('#update_prof_button');
                window.scrollTo(0, 0);
            }
        });

        // Prevents html form submission
        return false;
    });

});