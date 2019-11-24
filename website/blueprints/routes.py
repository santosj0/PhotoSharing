from flask import Blueprint, render_template
from website.blueprints.decorators import login_required, not_logged

routes = Blueprint('routes', __name__)


# Homepage
@routes.route('/')
def index():
    return "<h1>Hello world!</h1>"


@routes.route('/login')
@not_logged
def login():
    return render_template('/partials/forms/login.html')


@routes.route('/register')
@not_logged
def register():
    return render_template('/partials/forms/registration.html')


@routes.route('/upload')
@login_required
def upload():
    return render_template('/partials/forms/upload.html')


@routes.route('/upload-profile-picture')
@login_required
def upload_prof_pic():
    return render_template('/partials/forms/upload-profile-pic.html')


@routes.route('/add-tag-to-photo')
@login_required
def add_tag_route():
    return render_template('/partials/forms/add-tag.html')


@routes.route('/add-comment-to-photo')
@login_required
def add_comment_route():
    return render_template('/partials/forms/comment-photo.html')


@routes.route('/activate')
def world():
    return render_template('/partials/emails/activation.html')
