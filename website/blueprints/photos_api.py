import os
from flask import Blueprint, request, jsonify, session
from sqlalchemy.exc import SQLAlchemyError
from werkzeug.utils import secure_filename
from datetime import datetime
from website.blueprints.decorators import login_required, check_file_type, html_escape_values, uploader_only, \
    keyword_exist, uploader_commenter_only, make_request_get
from website import app, db
from website.models import ProfilePicturedComments as ppc, ProfilePicturedCommentsSchema as ppcs

# Set up photos blueprint
photos = Blueprint('photos', __name__)


""" Photo Section """
@photos.route('/add-new-picture', methods=['POST'])
@login_required
@check_file_type('file')
@html_escape_values
@keyword_exist(['title', 'dcript'])
def add_new_picture(**kwargs):
    """
    Adds a new user's uploaded photo to their folder and to the database
    :param kwargs: kwargs['request_get'] is a dictionary of html safe parameters
    :return: A Json response with whether or not this function succeeded
    """
    # Get variables
    params = kwargs['request_get']
    file = request.files['file']
    username = session.get('username')
    title = params['title']
    dcript = params['dcript']

    # Produce unique image name with datetime and username
    filename = secure_filename(
        username + '_' +
        datetime.now().strftime("%Y-%m-%dT%H:%M:%S") + '_'
        + file.filename
    )

    # Create path to folder
    path = os.path.join(app.config['UPLOAD_FOLDER'], 'users', username, 'uploads', filename)

    # Establish connection to the database
    connection = db.engine.raw_connection()
    try:
        # Upload image
        file.save(os.path.join(path))

        # Modify the current path to have '/' instead of '\'
        path2 = path.replace("\\", "/")

        # Adds image to database
        with connection.cursor() as cursor:
            cursor.callproc("App_Photos_InsertPhoto", [title, dcript, path2, username])

        # Finalizes the insertion
        connection.commit()

        result = "Photo Added"

    except (FileExistsError, SQLAlchemyError, Exception) as e:
        connection.rollback()
        if os.path.isfile(path):
            os.remove(path)
        result = "Type" + str(type(e)) + str(e)
    finally:
        connection.close()

    return jsonify({'result': result})


@photos.route('/remove-photo', methods=['POST'])
@uploader_only("photo_id")
@make_request_get
def remove_photo(**kwargs):
    param = kwargs['request_get']
    pid = param['photo_id']
    user = session['username']

    # Establish connection to the database
    connection = db.engine.raw_connection()
    try:
        # Remove the photo from the database
        with connection.cursor() as cursor:
            cursor.callproc("App_Photos_DeletePhoto", [user, pid])
            result = cursor.fetchone()[0]

        # Result is not the file path
        if result in ["User does not exist", "Photo does not exist/User is not uploader"]:
            raise Exception(result)

        # Sets the path to picture to have os separator
        result = result.replace("/", os.sep)

        # Remove photo for directory
        path = os.path.join(os.getcwd(), result)
        os.remove(path)

        # Set the result
        result = "Photo has been removed"

        # Finalize the Deletion
        connection.commit()
    except (FileNotFoundError, SQLAlchemyError, Exception) as e:
        connection.rollback()
        result = "Type" + str(type(e)) + str(e)
    finally:
        connection.close()

    return jsonify({'result': result})


""" Profile Picture Section """
@photos.route('/add-new-profile-pic', methods=['POST'])
@login_required
@check_file_type('file')
def add_new_profile_pic():
    """
    Adds a new profile picture to the user's folder and into the database
    :return: Result of whether this was successful or not
    """
    # Get variables
    file = request.files['file']
    username = session.get('username')

    # Produce unique image name with datetime and username
    filename = secure_filename(
        username + '_' +
        datetime.now().strftime("%Y-%m-%dT%H:%M:%S") + "_" +
        file.filename
    )

    # Create path to folder
    path = os.path.join(app.config['UPLOAD_FOLDER'], 'users', username, 'profile_pic', filename)

    # Establish connection to the database
    connection = db.engine.raw_connection()
    try:

        # Upload image
        file.save(path)

        # Modify the current path to have '/' instead of '\'
        path2 = path.replace("\\", "/")

        # Save image to database
        with connection.cursor() as cursor:
            cursor.callproc("App_Users_InsertNewProfilePic", [path2, username])

        # Finalizes the insertion
        connection.commit()

        result = "Profile Pic added"
    except (FileExistsError, SQLAlchemyError, Exception) as e:
        connection.rollback()
        if os.path.isfile(path):
            os.remove(path)
        result = "Type" + str(type(e)) + str(e)
    finally:
        connection.close()

    return jsonify({'result': result})


""" Tag Section """
@photos.route('/add-tag-to-photo', methods=["POST"])
@login_required
@uploader_only("photo_id")
@html_escape_values
def add_tag_to_photo(**kwargs):
    """
    Adds a tag to the specified photo that the user uploaded themselves. Limit of 5 tags per photo and only unique tags only.
    :param kwargs: kwargs['request_get'] is a dictionary of html safe parameters
    :return: A Json response with whether or not this function succeeded
    """
    # Get variables
    params = kwargs['request_get']
    pid = params['photo_id']
    tname = params['tag_name']

    # Establish connection to the database
    connection = db.engine.raw_connection()
    try:
        # Adds image to database
        with connection.cursor() as cursor:
            cursor.callproc("App_Photos_AddTagToPhoto", [pid, tname])
            result = cursor.fetchone()[0]

            # Finalizes the insertion
            connection.commit()
    except (SQLAlchemyError, Exception) as e:
        connection.rollback()
        result = "Type" + str(type(e)) + str(e)
    finally:
        connection.close()

    return jsonify({'result': result})


""" Comment Section """
@photos.route('/add-comment-to-photo', methods=['POST'])
@login_required
@html_escape_values
@keyword_exist(['photo_id', 'comment'])
def add_comment_photo(**kwargs):
    """
    Adds a comment to a specified photo
    :param kwargs: kwargs['request_get'] is a dictionary of html safe parameters
    :return: A Json response with whether or not this function succeeded
    """

    # Get the variables
    params = kwargs['request_get']
    pid = params['photo_id']
    comment = params['comment']
    user = session['username']

    # Establish connection to the database
    connection = db.engine.raw_connection()
    try:
        # Add the comment to the database
        with connection.cursor() as cursor:
            cursor.callproc("App_Users_CommentPhoto", [user, comment, pid])
            result = cursor.fetchone()[0]

        # Finalizze the insertion
        connection.commit()
    except (SQLAlchemyError, Exception) as e:
        connection.rollback()
        result = "Type" + str(type(e)) + str(e)
    finally:
        connection.close()

    return jsonify({'result': result})


@photos.route('/comments/<pid>')
def get_photo_comments(pid):
    # Retrieve username
    username = None
    if session.get('logged_in'):
        username = session['username']

    # Retrieve comments
    comments = ppc.query.with_entities(ppc.comment_text, ppc.comment_date, ppc.commenter, ppc.uploader, ppc.comment_id,
                                       ppc.commenter_profile_pic).filter_by(photo_id=pid).all()
    output = ppcs(many=True).dump(comments)
    db.session.close()

    if comments:
        for comm in output:
            # Modify date time
            date = datetime.strptime(comm['comment_date'], "%Y-%m-%dT%H:%M:%S")
            comm['comment_date'] = date.strftime("%m/%d/%Y %H:%M:%S")

            # Modify default profile pic
            if comm['commenter_profile_pic'].split('/')[0] == '':
                comm['commenter_profile_pic'] = 'static/images' + comm['commenter_profile_pic']
                comm['pixelated'] = True
            else:
                comm['pixelated'] = False
    else:
        return jsonify({'result': 'No comments'})

    return jsonify({'result': output, 'user': username if username else 'Not logged in'})


@photos.route('/remove-comment', methods=['POST'])
@make_request_get
@uploader_commenter_only("comment_id")
def remove_comment(**kwargs):
    # Get the variables
    params = kwargs['request_get']
    cid = params['comment_id']
    user = session['username']

    # Establish connection to the database
    connection = db.engine.raw_connection()
    try:
        # Remove the comment from the database
        with connection.cursor() as cursor:
            cursor.callproc("App_Users_DeleteComment", [user, cid])
            result = cursor.fetchone()[0]

        # Finalizze the Deletion
        connection.commit()
    except (SQLAlchemyError, Exception) as e:
        connection.rollback()
        result = "Type" + str(type(e)) + str(e)
    finally:
        connection.close()

    return jsonify({'result': result})
