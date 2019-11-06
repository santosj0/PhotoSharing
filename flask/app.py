#!/bin/python

""" Flask Application """
from flask import Flask, url_for

app = Flask(__name__)


@app.route("/")
def home():
    a = url_for('test')
    return "<h1>Hello World!</h1><a href='" + a + "'>Link for test</a>"


@app.route("/test")
def test():
    a = url_for('home')
    return "<h1>Test</h1><a href='" + a + "'>Link for home</a>"


if __name__ == "__main__":
    app.run(debug=True)
