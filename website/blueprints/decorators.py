from flask import session, url_for, redirect
from functools import wraps


# Login Required
def login_required(required=True):
    """
    Returns to the route depending on whether or not a user is
    required to be logged in to access
    :param required: True if loggin is required, None if it is not required
    :return:
    """
    def decorator(f):
        @wraps(f)
        def decorated_function(*args, **kwargs):
            if session.get('logged_in') is required:
                return f(*args, **kwargs)
            return redirect(url_for('routes.index'))
        return decorated_function
    return decorator
