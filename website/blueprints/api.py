import website.functions.folders as fd
import website.models as wm
from os import getcwd
from flask import jsonify, Blueprint, request
from website import db
from sqlalchemy.exc import SQLAlchemyError

# Set up Blueprint
api = Blueprint('api', __name__)


@api.route('/insertUser', methods=['POST'])
def insert_user():
    """
    Inserts a new user into the database
    :return: A Json response with whether or not this function succeeded
    """
    # Retreive Form Data
    json_data = request.json
    username = json_data['username']
    password = json_data['password']
    email = json_data['email']
    profile_pic = json_data['profilepic']

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
        path = getcwd() + "\\static\\images\\users"
        upath = fd.make_folder(path, "\\" + username)
        fd.make_folder(upath, "\\profile_pic")
        fd.make_folder(upath, "\\uploads")

        # Add everything to the database
        connection.commit()

    # Rollback in case anything happens
    except (FileExistsError, FileNotFoundError, SQLAlchemyError) as e:
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
