import os
from flask import Blueprint, request, jsonify, session
from werkzeug.utils import secure_filename
from datetime import datetime
from website.blueprints.decorators import login_required, check_file_type
from website import app, db

# Set up photos blueprint
photos = Blueprint('photos', __name__)


@photos.route('/invalid-file')
def invalid_file():
    return jsonify({'result': 'Invalid file type'})


@photos.route('/add-new-profile-pic', methods=['POST'])
@login_required(True)
@check_file_type('file')
def add_new_profile_pic():
    """
    Adds a new profile picture to the user's folder and into the database
    :return: Result of whether this was successful or not
    TODO: Add the database portion
    """
    # Get variables
    file = request.files['file']
    username = session.get('username')

    # Produce unique image name with datetime and username
    filename = secure_filename(
        file.filename + '_' +
        username + '_' +
        datetime.now().strftime("%Y-%m-%dT%H:%M:%S")
    )

    # Create path to folder
    path = os.path.join(username, 'profile_pic', filename)

    # Establish connection to the database
    connection = db.engine.raw_connection()
    try:

        # Upload image
        file.save(os.path.join(app.config['UPLOAD_FOLDER'], path))

        # Save image to database


        result = True
    except FileExistsError:
        connection.rollback()
        result = "File Already Exists"
    finally:
        connection.close()

    return jsonify({'result': result})


@photos.route('/get-photos')
def get_photos(**kwargs):
    return jsonify({'stuff': kwargs['stuff'], 'GET': kwargs['request_get']})
