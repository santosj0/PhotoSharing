from flask import Blueprint, make_response

routes = Blueprint('blueprints', __name__)


@routes.route('/', defaults={'path': ''})
@routes.route("/<path:path>")
def index(path):
    return make_response(open('templates/base.html').read())


@routes.route('/world')
def world():
    return "World"
