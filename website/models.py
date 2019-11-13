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
