from website import db, ma

BASE = db.Model


""" Tables """
# Never use Tables / Views Only


# User Class
class User(BASE):
    __tablename__ = 'users'

    user_id = db.Column('user_id', db.Integer, nullable=False, primary_key=True)
    username = db.Column('username', db.String(45), nullable=False)
    password = db.Column('password', db.String(45), nullable=False)
    email = db.Column('email', db.String(45), nullable=False)

    def __init__(self, username, password, email):
        self.username = username
        self.password = password
        self.email = email


class UserSchema(ma.ModelSchema):
    class Meta:
        model = User
