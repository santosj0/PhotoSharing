import os
from website.functions.ssh_tunnel import tunnelServer
from website.functions.email import get_username, get_password


# Path to the project folder
basedir = os.path.abspath(os.path.dirname(__file__))
print(basedir)


class BaseConfig(object):
    # Flask settings
    ENV = 'development'
    DEBUG = True

    # Bcrypt
    SECRET_KEY = 'my_precious'

    # SQLAlchemy
    SQLALCHEMY_DATABASE_URI = 'mysql+pymysql://santosj0:smartvacuum@127.0.0.1:{}/santosj0' \
        .format(tunnelServer().local_bind_port)
    SQLALCHEMY_TRACK_MODIFICATIONS = False

    # Mail
    MAIL_SERVER = 'smtp.googlemail.com'
    MAIL_PORT = 465
    MAIL_USE_TLS = False
    MAIL_USE_SSL = True
    MAIL_USERNAME = '{}'.format(get_username())
    MAIL_PASSWORD = '{}'.format(get_password())
    MAIL_DEFAULT_SENDER = '{}'.format(get_username())
