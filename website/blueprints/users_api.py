import website.functions.folders as fd
import website.models as wm
import os
from website import db, bcrypt
from website.blueprints.decorators import login_required, html_escape_values
from website.functions.email import send_mail
from smtplib import SMTPException
import website.functions.tokens as fd_token
from itsdangerous.exc import SignatureExpired, BadTimeSignature
from flask import jsonify, Blueprint, request, session
from sqlalchemy.exc import SQLAlchemyError


# Set up users blueprint
users = Blueprint('users', __name__)


@users.route('/login', methods=['POST'])
@login_required(None)
@html_escape_values
def login_user(**kwargs):
    """
    Logs the user to allow access to restricted pages
    :param kwargs: 'request_get' is a dictionary of html safe parameters
    :return: Status of login
    """
    # Retrieve Form Data
    params = kwargs['request_get']
    login_name = params.get('login_name')
    password = params.get('password')

    # UserLogin View
    user_login = wm.UserLogin

    # Determine if the user exists
    password2 = user_login.query.with_entities(user_login.password).filter_by(username=login_name).first()

    # Ends the session with the database
    db.session.close()

    # Makes sure that the user exists and that the password matches
    if password2 and bcrypt.check_password_hash(password2[0], password):
        session['logged_in'] = True
        session['username'] = login_name
        result = 'Logged in'
    else:
        result = 'Username or Password does not match'

    return jsonify({'result': result})


@users.route('/logout')
@login_required()
def logout_user():
    """
    Removes a user from the session
    :return: Result of whether or not the user was able to be logged out
    """
    if session.get('logged_in'):
        for key in session.key():
            session.pop(key)
        result = 'Logged Out'
    else:
        result = 'Unable to log out the user'

    return jsonify({'result': result})


@users.route('/register', methods=['POST'])
@login_required(None)
@html_escape_values
def insert_user(**kwargs):
    """
    Inserts a new user into the database
    :param kwargs: 'request_get' is a dictionary of html safe parameters
    :return: A Json response with whether or not this function succeeded
    """
    # Retrieve Form Data
    params = kwargs['request_get']
    username = params['username']
    password = bcrypt.generate_password_hash(params['password']).decode('utf-8')
    email = params['email']
    profile_pic = params['profilepic']

    # Establish connection to the database
    connection = db.engine.raw_connection()
    try:
        # Add the user to the database
        with connection.cursor() as cursor:
            cursor.callproc("App_Users_InsertUser", [username, password, email, profile_pic])
            result = cursor.fetchone()[0]

        if result == 0:
            raise SQLAlchemyError("Username or Password Exists")

        # Generate the folders
        # Make function to make sure that folders don't exist
        path = os.path.join(os.getcwd(), "static", "images", "users")
        result = fd.generate_user_folders(path, username)

        if result == 0:
            raise FileExistsError("User Folders Already Exist")

        # Serializes/Generates the token
        # Suppose to use email, but since email is not unique, we use username
        token = fd_token.generate_confirmation_token(username)

        # Sends the mail
        result = send_mail('PhotoSharing - Please activate your account',
                           email,
                           html='/partials/emails/activation.html',
                           links={'confirmation_token': 'http://localhost:5000/api/confirm_user/' + token})

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


@users.route('/confirm_user/<token>')
@login_required(None)
def validate_user(token):
    """
    Validates the user
    :param token: Token provided via email when the user created his account
    :return: Result of validation
    """
    # Establish connection to the database
    connection = db.engine.raw_connection()
    try:
        # Update Users Verification
        username = fd_token.confirm_token(token, expiration=86400) # Token lasts for 1 day
        with connection.cursor() as cursor:
            cursor.callproc("App_Users_UpdateVerification", [username])
            result = cursor.fetchone()[0]

        # Add everything to the database
        connection.commit()
    except SignatureExpired:
        result = "Token is expired"
    except BadTimeSignature:
        result = "Token provided is not valid"
    except SQLAlchemyError:
        connection.rollback()
        result = "Database error"
    finally:
        connection.close()

    return result


@users.route('/getUsers')
@login_required()
def get_users():
    """
    Example for getting all the users
    :return: Json of the user information
    """
    users = wm.UserLogin.query.all()
    users_schema = wm.UserLoginSchema(many=True)
    output = users_schema.dump(users)
    db.session.close()

    return jsonify({'Users': output})