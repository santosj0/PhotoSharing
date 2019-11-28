from website.models import TaggedPhotos as tp, TaggedPhotosSchema as tps, DefaultProfPics as dpp, \
    DefaultProfPicsSchema as dpps
from flask import Blueprint, render_template, abort
from website.blueprints.decorators import login_required, not_logged
from website import db
from datetime import datetime

routes = Blueprint('routes', __name__)


@routes.route('/')
def index():
    tagged_photos = tp.query\
        .with_entities(tp.photo_id, tp.picture_name, tp.upload_path, tp.uploader, tp.description)\
        .order_by(tp.upload_date.desc())\
        .limit(20)
    photo_schema = tps(many=True)
    output = photo_schema.dump(tagged_photos)
    db.session.close()
    return render_template('/partials/forms/home.html', title="Home", photos=output)


@routes.route('/login')
@not_logged
def login():
    return render_template('/partials/forms/login.html', title="Login")


@routes.route('/register')
@not_logged
def register():
    prof_pic = dpp.query \
        .with_entities(dpp.photo_id, dpp.upload_path) \
        .all()
    prof_schema = dpps(many=True)
    output = prof_schema.dump(prof_pic)
    db.session.close()
    return render_template('/partials/forms/register.html', title="Register", photos=output)


@routes.route('/upload')
@login_required
def upload():
    return render_template('/partials/forms/upload.html', title="Upload Photo")


@routes.route('/photo/<pid>')
def display_photo(pid):
    photo = tp.query.filter_by(photo_id=pid).first()
    ps = tps()
    output = ps.dump(photo)
    db.session.close()
    if photo:
        date = datetime.strptime(output['upload_date'], "%Y-%m-%dT%H:%M:%S")
        output['upload_date'] = date.strftime("%m/%d/%Y %H:%M:%S")
        return render_template('/partials/forms/photo.html', title=output['picture_name'], photo=output)
    else:
        return abort(404)


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
