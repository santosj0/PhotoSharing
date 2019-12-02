import website.models as wm
from flask import Blueprint, render_template, abort, session
from website.blueprints.decorators import login_required, not_logged
from website import db
from datetime import datetime

routes = Blueprint('routes', __name__)


@routes.route('/')
def index():
    tp = wm.TaggedPhotos
    tagged_photos = tp.query\
        .with_entities(tp.photo_id, tp.picture_name, tp.upload_path, tp.uploader, tp.description)\
        .order_by(tp.upload_date.desc())\
        .limit(20)
    photo_schema = wm.TaggedPhotosSchema(many=True)
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
    dpp = wm.DefaultProfPics
    prof_pic = dpp.query \
        .with_entities(dpp.photo_id, dpp.upload_path) \
        .all()
    prof_schema = wm.DefaultProfPicsSchema(many=True)
    output = prof_schema.dump(prof_pic)
    db.session.close()
    return render_template('/partials/forms/register.html', title="Register", photos=output)


@routes.route('/upload')
@login_required
def upload():
    return render_template('/partials/forms/upload.html', title="Upload Photo")


@routes.route('/photo/<pid>')
def display_photo(pid):
    photo = wm.TaggedPhotos.query.filter_by(photo_id=pid).first()
    ps = wm.TaggedPhotosSchema()
    output = ps.dump(photo)
    db.session.close()
    if photo:
        date = datetime.strptime(output['upload_date'], "%Y-%m-%dT%H:%M:%S")
        output['upload_date'] = date.strftime("%m/%d/%Y %H:%M:%S")
        return render_template('/partials/forms/photo.html', title=output['picture_name'], photo=output)
    else:
        return abort(404)


@routes.route('/<username>/album')
def user_album(username):
    # Determines if user exists
    user = wm.UserInformation.query.with_entities(wm.UserInformation.username).filter_by(username=username).first()

    # Generate the title for the webpage
    title = username + "'s Album"

    # Retrieve the photos of the specified user
    photo = wm.TaggedPhotos.query.filter_by(uploader=username).all()
    output = wm.TaggedPhotosSchema(many=True).dump(photo)
    db.session.close()
    if user:
        return render_template('/partials/forms/album.html', title=title, photos=output, uname=username)
    else:
        abort(404)


@routes.route('/account')
@login_required
def user_account():
    """
    TODO: Finish the accounts page
    :return:
    """
    # Retrieve user information
    uname = session['username']
    user = wm.UserInformation.query.filter_by(username=uname).first()
    output = wm.UserInformationSchema().dump(user)

    # Page title
    title = uname + "'s Account"

    return render_template('/partials/forms/account.html', title=title, user=output)


""" Bad form section """
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
