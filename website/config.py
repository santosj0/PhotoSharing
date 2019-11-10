import os
from website.functions.ssh_tunnel import tunnelServer


# Path to the project folder
basedir = os.path.abspath(os.path.dirname(__file__))
print(basedir)


class BaseConfig(object):
    SECRET_KEY = 'my_precious'
    ENV = 'development'
    DEBUG = True
    SQLALCHEMY_DATABASE_URI = 'mysql+pymysql://santosj0:smartvacuum@127.0.0.1:{}/santosj0' \
        .format(tunnelServer().local_bind_port)
    SQLALCHEMY_TRACK_MODIFICATIONS = False
