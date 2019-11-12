import website.functions.folders as fd
import website.models as wm
from os import getcwd
from flask import jsonify, Blueprint, request, render_template
from website import db, bcrypt, mail
from flask_mail import Message
from smtplib import SMTPException
from sqlalchemy.exc import SQLAlchemyError

# Set up Blueprint
api = Blueprint('api', __name__)


def send_mail(subject, recipient, body=None, html=None):
    """
    General template for sending emails
    :param subject: Email subject as a string
    :param recipient: The user being sent the mail to
    :param body: Optional. Email body as a string
    :param html: Optional. Path location where the html will be rendered
    :return: Integer result whether or not this succeeded
    """
    try:
        msg = Message(subject,
                      recipients=[recipient])

        if html is not None:
            html = render_template(html)
            msg.html = html

        if body is not None:
            msg.body = body

        mail.send(msg)

        result = 1
    except SMTPException:
        result = 0

    return result


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
            raise SQLAlchemyError("Error with the Procedure")

        # Generate the folders
        # Make function to make sure that folders don't exist
        path = fd.move_up(getcwd(), "\\", 1) + "\\static\\images\\users"
        upath = fd.make_folder(path, "\\" + username)
        fd.make_folder(upath, "\\profile_pic")
        fd.make_folder(upath, "\\uploads")

        result = send_mail('PhotoSharing - Please activate your account', email, html='/partials/emails/activation.html')

        if result == 0:
            raise SMTPException()

        # Add everything to the database
        connection.commit()

    # Rollback in case anything happens
    except (FileExistsError, FileNotFoundError, SQLAlchemyError, SMTPException) as e:
        result = 0
        connection.rollback()
        print(e)

    # Closes the connection to the database
    finally:
        connection.close()

    return jsonify({'result': result})


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
