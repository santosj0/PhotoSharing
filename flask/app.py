#!/bin/python

""" Flask Application """
from flask import Flask, make_response

app = Flask(__name__)


@app.route('/', defaults={'path': ''})
@app.route("/<path:path>")
def index(path):
    return make_response(open('templates/base.html').read())


if __name__ == "__main__":
    app.run(debug=True)
