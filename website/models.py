from website import db, ma

BASE = db.Model


""" Tables """
# Never use Tables / Views Only


# User Class
class UserLogin(BASE):
    __tablename__ = 'login_register'

    user_id = db.Column('user_id', db.Integer, nullable=False, primary_key=True)
    username = db.Column('username', db.String(45), nullable=False)
    password = db.Column('password', db.String(45), nullable=False)
    email = db.Column('email', db.String(45), nullable=False)
    is_verified = db.Column('is_verified', db.Boolean, nullable=False)
    verified_sent = db.Column('verified_sent', db.DATETIME)

    def __init__(self, username, password, email, is_verified, verified_sent):
        self.username = username
        self.password = password
        self.email = email
        self.is_verified = is_verified
        self.verified_sent = verified_sent


class UserLoginSchema(ma.ModelSchema):
    class Meta:
        model = UserLogin


# Photos with Tags
class TaggedPhotos(BASE):
    __tablename__ = "photos_with_tags"

    photo_id = db.Column('photo_id', db.Integer, nullable=False, primary_key=True)
    picture_name = db.Column('picture_name', db.String(45), nullable=False)
    description = db.Column('description', db.String(255), nullable=False)
    upload_date = db.Column('upload_date', db.DATETIME, nullable=False)
    upload_path = db.Column('path', db.String(255), nullable=False)
    uploader = db.Column('uploader', db.String(45), nullable=False)
    tags = db.Column('tags', db.String)


class TaggedPhotosSchema(ma.ModelSchema):
    class Meta:
        model = TaggedPhotos


# Default Profile Pictures
class DefaultProfPics(BASE):
    __tablename__ = "default_profile_pics"

    photo_id = db.Column('photo_id', db.Integer, nullable=False, primary_key=True)
    upload_path = db.Column('file_path', db.String(255), nullable=False)


class DefaultProfPicsSchema(ma.ModelSchema):
    class Meta:
        model = DefaultProfPics


# Photos with Comments
class CommentedPhotos(BASE):
    __tablename__ = "photos_with_comments"

    photo_id = db.Column('photo_id', db.Integer, nullable=False, primary_key=True)
    picture_name = db.Column('pic_name', db.String(45), nullable=False)
    description = db.Column('description', db.String(255), nullable=False)
    upload_date = db.Column('upload_date', db.DATETIME, nullable=False)
    file_path = db.Column('file_path', db.String(255), nullable=False)
    uploader = db.Column('uploader', db.String(45), nullable=False)
    comment_id = db.Column('comment_id', db.Integer, nullable=False)
    commenter = db.Column('commenter', db.String(45), nullable=False)
    comment_text = db.Column('comment_text', db.String(255), nullable=False)
    comment_date = db.Column('comment_date', db.DATETIME, nullable=False)


class CommentedPhotosSchema(ma.ModelSchema):
    class Meta:
        model = CommentedPhotos
