from website.models import TaggedPhotos as tp, TaggedPhotosSchema as tps
from flask import Blueprint, render_template
from website.blueprints.decorators import login_required, not_logged
from website import db

routes = Blueprint('routes', __name__)


# Homepage
@routes.route('/')
def index():
    tagged_photos = tp.query\
        .with_entities(tp.photo_id, tp.picture_name, tp.upload_path, tp.uploader, tp.description)\
        .order_by(tp.upload_date.desc())\
        .all()
    photo_schema = tps(many=True)
    output = photo_schema.dump(tagged_photos)
    db.session.close()
    return render_template('/partials/forms/home.html', title="Home", photos=output)


@routes.route('/login')
@not_logged
def login():
    return render_template('/partials/forms/login.html')


@routes.route('/register')
@not_logged
def register():
    return render_template('/partials/bad_forms/registration.html')


@routes.route('/upload')
@login_required
def upload():
    return render_template('/partials/bad_forms/upload.html')


@routes.route('/upload-profile-picture')
@login_required
def upload_prof_pic():
    return render_template('/partials/bad_forms/upload-profile-pic.html')


@routes.route('/add-tag-to-photo')
@login_required
def add_tag_route():
    return render_template('/partials/bad_forms/add-tag.html')


@routes.route('/add-comment-to-photo')
@login_required
def add_comment_route():
    return render_template('/partials/bad_forms/comment-photo.html')


@routes.route('/forgot-password')
@not_logged
def forgot_password():
    return render_template('/partials/bad_forms/forgot-password.html')


@routes.route('/activate')
def world():
    return render_template('/partials/emails/activation.html')
