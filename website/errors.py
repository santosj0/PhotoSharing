from flask import render_template
from website import app, db


def page_not_found(e):
    return render_template('/partials/errors/404.html'), 404


def internal_error(e):
    db.session.rollback()
    return render_template('/partials/errors/500.html'), 500
