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


@routes.route('/sendMail')
def send_mail():
    try:
        msg = Message('Python Test',
                      recipients=['photosharingrowanuniversity@gmail.com'])
        html = render_template('/partials/emails/activation.html')
        msg.html = html
        mail.send(msg)
        result = 1
    except Exception:
        result = 0

    return result


