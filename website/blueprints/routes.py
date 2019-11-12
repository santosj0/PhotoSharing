from flask import Blueprint, make_response, render_template, send_file, url_for
from website import mail
from flask_mail import Message

routes = Blueprint('blueprints', __name__)


# Angular Redirect
@routes.route('/', defaults={'path': ''})
@routes.route("/<path:path>")
def index(path):
    return make_response(open('templates/base.html').read())


@routes.route('/activate')
def world():
    return render_template('/partials/emails/activation.html')
