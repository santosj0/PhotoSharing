import website.functions.folders as fd
import website.models as wm
import website.functions.tokens as f_token
import os
from website import db, bcrypt
from website.blueprints.decorators import login_required, not_logged, validate_eaddress, validate_text_numbers, \
    make_request_get, validate_number_range, keyword_exist
from website.functions.email import send_mail
from smtplib import SMTPException
from itsdangerous.exc import SignatureExpired, BadTimeSignature
from flask import jsonify, Blueprint, session, render_template, request
from sqlalchemy.exc import SQLAlchemyError


# Set up users blueprint
users = Blueprint('users', __name__)


@users.route('/login', methods=['POST'])
@not_logged
@make_request_get
@keyword_exist(['login_name', 'password'])
@validate_text_numbers('login_name', 'Username can only be numbers, letters, hypens, and/or underscores')
def login_user(**kwargs):
    """
    Logs the user to allow access to restricted pages
    :param kwargs: 'request_get' is a dictionary of html safe parameters
    :return: Status of login
    TODO: Check to also make sure that the user is verified
    """
    # Retrieve Form Data
    params = kwargs['request_get']
    login_name = params.get('login_name')
    password = params.get('password')

    # UserLogin View
    user_login = wm.UserLogin

    # Determine if the user exists
    user = user_login.query.with_entities(user_login.password, user_login.is_verified).filter_by(username=login_name).first()
    output = wm.UserLoginSchema().dump(user)

    # Ends the session with the database
    db.session.close()

    # Makes sure that the user exists and that the password matches
    if user:
        if bcrypt.check_password_hash(output['password'], password) and output['is_verified'] is True:
            session['logged_in'] = True
            session['username'] = login_name
            result = 'Logged in'
        else:
            result = "Username or Password does not match or User not verified"
    else:
        result = 'Username or Password does not match'

    return jsonify({'result': result})


@users.route('/logout')
@login_required
def logout_user():
    """
    Removes a user from the session
    :return: Result of whether or not the user was able to be logged out
    """
    if session.get('logged_in'):
        session.pop('username')
        session.pop('logged_in')
        result = 'Logged Out'
    else:
        result = 'Unable to log out the user'

    return jsonify({'result': result})


@users.route('/update-email', methods=['POST'])
@login_required
@make_request_get
@keyword_exist(['email'])
@validate_eaddress('email')
def update_email(**kwargs):
    email = kwargs['request_get']['email']
    uname = session['username']

    # Establish connection to the database
    connection = db.engine.raw_connection()
    try:
        # Add the user to the database
        with connection.cursor() as cursor:
            cursor.callproc("App_Users_UpdateEmail", [uname, email])
            result = cursor.fetchone()[0]

        # Add everything to the database
        connection.commit()
    except (SQLAlchemyError, Exception) as e:
        connection.rollback()
        result = "Type" + str(type(e)) + str(e)
    finally:
        connection.close()

    return jsonify({'result': result})


@users.route('/register', methods=['POST'])
@not_logged
@make_request_get
@keyword_exist(['username', 'password', 'email', 'profile_pic'])
@validate_text_numbers('username', message="Invalid Username")
@validate_eaddress('email')
@validate_number_range('profile_pic', start=1, end=8, message="Invalid Profile Picture")
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
    profile_pic = params['profile_pic']

    # Establish connection to the database
    connection = db.engine.raw_connection()
    try:
        # Add the user to the database
        with connection.cursor() as cursor:
            cursor.callproc("App_Users_InsertUser", [username, password, email, profile_pic])
            result = cursor.fetchone()[0]

        if result == 0:
            raise SQLAlchemyError("Username already exists")

        # Generate the folders
        # Make function to make sure that folders don't exist
        path = os.path.join(os.getcwd(), "static", "images", "users")
        result = fd.generate_user_folders(path, username)

        if result == 0:
            raise FileExistsError("User Folders Already Exist")

        # Serializes/Generates the token
        # Suppose to use email, but since email is not unique, we use username
        token = f_token.generate_token(username)

        # Sends the mail
        result = send_mail('PhotoSharing - Please activate your account',
                           email,
                           html='/partials/emails/activation.html',
                           links={'confirmation_token': 'http://localhost:5000/api/users/confirm-user/' + token})

        if result == 0:
            raise SMTPException("Email not valid")

        # Add everything to the database
        connection.commit()
        result = "User is registered"

    # Rollback in case anything happens
    except (FileExistsError, FileNotFoundError, SQLAlchemyError, SMTPException) as e:
        # Store the error
        result = str(e)

        # Remove the information from the database
        connection.rollback()

    # Closes the connection to the database
    finally:
        connection.close()

    return jsonify({'result': result})


@users.route('/confirm-user/<token>')
@not_logged
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
        username = f_token.validate_token(token, expiration=86400)  # Token lasts for 1 day
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


@users.route('/send-password-reset', methods=['POST'])
@not_logged
@make_request_get
@validate_text_numbers('username')
def send_password_reset(**kwargs):
    # Grab the variables
    params = kwargs['request_get']
    uname = params['username']

    # UserLogin View
    user_login = wm.UserLogin

    # Determine if the user exists
    user = user_login.query.with_entities(user_login.email).filter_by(username=uname).first()
    output = wm.UserLoginSchema().dump(user)

    # Ends the session with the database
    db.session.close()

    if user:
        try:
            # Serializes/Generates the token
            token = f_token.generate_token(uname)

            # Sends the mail
            result = send_mail('PhotoSharing - Password Reset',
                               output['email'],
                               html='/partials/emails/password-change.html',
                               links={'reset_token': 'http://localhost:5000/api/users/reset-password/' + token})

            if result == 0:
                raise SMTPException("Email not valid")

            result = "Email sent"

        except (SMTPException, Exception) as e:
            result = str(e)

    else:
        result = 'Username does not exist'

    return jsonify({'result': result})


@users.route('/reset-password/<token>', methods=['GET', 'POST'])
@not_logged
@make_request_get
def validate_reset_password(token, **kwargs):
    # Verifies that the token is valid
    uname = None
    try:
        uname = f_token.validate_token(token, expiration=600)  # Token lasts for 5 minutes
        result = "Valid"
    except SignatureExpired:
        result = "Token is expired"
    except BadTimeSignature:
        result = "Token provided is not valid"

    if request.method == "GET":
        if result is not "Valid" or uname is None:
            return jsonify({'result': result})
        else:
            return render_template('/partials/bad_forms/reset-password.html')

    elif request.method == "POST":
        if result is not "Valid" or uname is None:
            return jsonify({'result': result})
        else:
            params = kwargs['request_get']
            password = bcrypt.generate_password_hash(params['password']).decode('utf-8')

            # Establish connection to the database
            connection = db.engine.raw_connection()
            try:
                with connection.cursor() as cursor:
                    cursor.callproc("App_Users_ResetPassword", [uname, password])
                    result = cursor.fetchone()[0]

                # Add everything to the database
                connection.commit()
            except (SQLAlchemyError, Exception) as e:
                connection.rollback()
                result = str(e)

            return jsonify({'result': result})

    else:
        return jsonify({'result': 'GET and POST only methods'})
