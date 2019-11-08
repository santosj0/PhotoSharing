#!/bin/python

""" Flask Application """
from flask import Flask, make_response
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow
from website.config import BaseConfig

# Configure the application
app = Flask(__name__)
app.config.from_object(BaseConfig)

# Create Object Variables
ma = Marshmallow(app)
db = SQLAlchemy(app)

# Import Blueprints
from website.blueprints.routes import routes
from website.blueprints.api import api

# Register Blueprints
app.register_blueprint(routes)
app.register_blueprint(api, url_prefix="/api")


if __name__ == "__main__":
    app.run()
