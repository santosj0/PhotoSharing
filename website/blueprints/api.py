import website.functions.folders as fd
import website.models as wm
from os import getcwd
from flask import jsonify, Blueprint, request
from website import db, bcrypt
from smtplib import SMTPException
from sqlalchemy.exc import SQLAlchemyError
from website.functions.email import send_mail
import website.functions.tokens as fd_token
from itsdangerous.exc import SignatureExpired, BadTimeSignature

# Set up Blueprint
api = Blueprint('api', __name__)


@api.route('/register', methods=['GET', 'POST'])
def insert_user():
    """
    Inserts a new user into the database
    :return: A Json response with whether or not this function succeeded
    """
    # Retreive Form Data
    if request.method == 'POST':
        json_data = request.json
        username = json_data['username']
        password = bcrypt.generate_password_hash(json_data['password']).decode('utf-8')
        email = json_data['email']
        profile_pic = json_data['profilepic']
    else:
        params = request.args
        username = params.get('username')
        password = bcrypt.generate_password_hash(params.get('password')).decode('utf-8')
        email = params.get('email')
        profile_pic = params.get('profilepic')

    # Establish connection to the database
    connection = db.engine.raw_connection()
    try:
        # Add the user to the database
        cursor = connection.cursor()
        cursor.callproc("App_Users_InsertUser", [username, password, email, profile_pic])
        result = cursor.fetchone()[0]
        cursor.close()

        if result == 0:
            raise SQLAlchemyError("Username or Password Exists")

        # Generate the folders
        # Make function to make sure that folders don't exist
        path = getcwd() + "\\static\\images\\users"
        result = fd.generate_user_folders(path, '\\', username)

        if result == 0:
            raise FileExistsError("User Folders Already Exist")

        # Serializes/Generates the token
        # Suppose to use email, but since email is not unique, we use username
        token = fd_token.generate_confirmation_token(username)

        # Sends the mail
        result = send_mail('PhotoSharing - Please activate your account',
                           email,
                           html='/partials/emails/activation.html',
                           links={'confirmation_token': 'http://localhost:5000/api/confirm_email/' + token})

        if result == 0:
            raise SMTPException("Email not valid")

        # Add everything to the database
        connection.commit()
        result = 1

    # Rollback in case anything happens
    except (FileExistsError, FileNotFoundError, SQLAlchemyError, SMTPException) as e:
        # Store the error
        result = e

        # Remove the information from the database
        connection.rollback()

    # Closes the connection to the database
    finally:
        connection.close()

    return jsonify({'result': result})


@api.route('/confirm_user/<token>')
def validate_user(token):
    try:
        username = fd_token.confirm_token(token, expiration=86400)
    except SignatureExpired:
        return "Token is expired"
    except BadTimeSignature:
        return "Token provided is not valid"

    return "The token is successful"


@api.route('/getUsers')
def get_users():
    """
    Example for getting all the users
    :return: Json of the user information
    """
    users = wm.User.query.all()
    users_schema = wm.UserSchema(many=True)
    output = users_schema.dump(users)
    db.session.close()

    return jsonify({'Users': output})
