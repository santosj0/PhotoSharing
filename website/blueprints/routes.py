from flask import Blueprint, render_template
from website.blueprints.decorators import login_required

routes = Blueprint('routes', __name__)


# Homepage redirect
@routes.route('/')
def index():
    return "<h1>Hello world!</h1>"


@routes.route('/login')
@login_required(None)
def login():
    return render_template('/partials/forms/login.html')


@routes.route('/register')
@login_required(None)
def register():
    return render_template('/partials/forms/registration.html')


@routes.route('/upload')
@login_required(True)
def upload():
    return render_template('/partials/forms/upload.html')


@routes.route('/upload-profile-picture')
@login_required(True)
def upload_prof_pic():
    return render_template('/partials/forms/upload-profile-pic.html')


@routes.route('/activate')
def world():
    return render_template('/partials/emails/activation.html')
