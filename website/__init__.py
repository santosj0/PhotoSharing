#!/bin/python

""" Flask Application """
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow
from flask_bcrypt import Bcrypt
from website.config import BaseConfig
from flask_mail import Mail

# Configure the application
app = Flask(__name__)
app.config.from_object(BaseConfig)

# Create Object Variables
ma = Marshmallow(app)
db = SQLAlchemy(app)
bcrypt = Bcrypt(app)
mail = Mail(app)

# Import Blueprints
from website.blueprints.routes import routes
from website.blueprints.users_api import users
from website.blueprints.photos_api import photos

# Register Blueprints
app.register_blueprint(routes)
app.register_blueprint(users, url_prefix="/api/users")
app.register_blueprint(photos, url_prefix="/api/photos")


if __name__ == "__main__":
    app.run()
