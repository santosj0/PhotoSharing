import os
from flask import Blueprint, request, jsonify, session
from sqlalchemy.exc import SQLAlchemyError
from werkzeug.utils import secure_filename
from datetime import datetime
from website.blueprints.decorators import login_required, check_file_type, html_escape_values
from website import app, db

# Set up photos blueprint
photos = Blueprint('photos', __name__)


@photos.route('/add-new-picture', methods=['POST'])
@login_required(True)
@check_file_type('file')
@html_escape_values
def add_new_picture(**kwargs):
    """

    :param kwargs:
    :return:
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


@photos.route('/add-new-profile-pic', methods=['POST'])
@login_required(True)
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


@photos.route('/get-photos')
def get_photos(**kwargs):
    return jsonify({'stuff': kwargs['stuff'], 'GET': kwargs['request_get']})
