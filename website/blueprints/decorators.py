from werkzeug.utils import secure_filename

from website import app
from flask import session, url_for, redirect, request, escape
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


def check_file_type(param):
    def decorator(f):
        @wraps(f)
        def decorated_function(*args, **kwargs):
            if request.method == 'POST':
                file = request.files[param]
                filename = file.filename
                if file and filename == '' and \
                        '.' in filename and filename.rsplit('.', 1)[1].lower() in app.config['ALLOWED_EXTENSIONS']:
                    return f(*args, **kwargs)
            return redirect(url_for('photos.invalid_file'))
        return decorated_function
    return decorator


def html_escape_values(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if request.method == "GET":
            params = request.args.to_dict()
            for key, value in params.items():
                params[key] = escape(value)
            kwargs['request_get'] = params
        elif request.method == "POST":
            json_data = request.get_json()
            for key, value in json_data.items():
                json_data[key] = escape(value)
            kwargs['request_get'] = json_data
        return f(*args, **kwargs)
    return decorated_function
