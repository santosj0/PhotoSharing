from flask import jsonify, Blueprint
from website import db
import website.models as wm


# Set up Blueprint
api = Blueprint('api', __name__)


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
