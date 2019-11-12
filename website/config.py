import os
from website.functions.ssh_tunnel import tunnel_server
from website.functions.read_login_file import get_email_information


# Path to the project folder
basedir = os.path.abspath(os.path.dirname(__file__))
print(basedir)

# Email information
email_information = get_email_information()


class BaseConfig(object):
    # Flask settings
    ENV = 'development'
    DEBUG = True

    # Security
    SECRET_KEY = 'my_precious'
    SECURITY_PASSWORD_SALT = 'my_precious_two'

    # SQLAlchemy
    SQLALCHEMY_DATABASE_URI = 'mysql+pymysql://santosj0:smartvacuum@127.0.0.1:{}/santosj0' \
        .format(tunnel_server().local_bind_port)
    SQLALCHEMY_TRACK_MODIFICATIONS = False

    # Mail
    MAIL_SERVER = 'smtp.googlemail.com'
    MAIL_PORT = 465
    MAIL_USE_TLS = False
    MAIL_USE_SSL = True
    MAIL_USERNAME = email_information[0]
    MAIL_PASSWORD = email_information[1]
    MAIL_DEFAULT_SENDER = email_information[0]
