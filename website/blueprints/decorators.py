from werkzeug.utils import secure_filename

from website import app
from flask import session, url_for, redirect, request, jsonify
from functools import wraps
from flask import Markup as mark


# Login Required
def login_required(required=True):
    """
    Returns to the route depending on whether or not a user is
    required to be logged in to access
    :param required: True if login is required, None if it is not required
    :return: Either a redirect or the desired webpage
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
                if file and not filename == '' and \
                        '.' in filename and filename.rsplit('.', 1)[1].lower() in app.config['ALLOWED_EXTENSIONS']:
                    return f(*args, **kwargs)
            return jsonify({'result': 'Invalid file type'})
        return decorated_function
    return decorator


def html_escape_values(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if request.method == "GET":
            params = request.args.to_dict()
            for key, value in params.items():
                params[key] = str(mark.escape(value))
            kwargs['request_get'] = params
        elif request.method == "POST":
            if request.get_json():
                json_data = request.get_json()
                for key, value in json_data.items():
                    json_data[key] = str(mark.escape(value))
                kwargs['request_get'] = json_data
            else:
                form_data = request.form.to_dict()
                for key, value in form_data.items():
                    form_data[key] = str(mark.escape(value))
                kwargs['request_get'] = form_data
        return f(*args, **kwargs)
    return decorated_function


def remove_html_tags(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if request.method == "GET":
            params = request.args.to_dict()
            for key, value in params.items():
                params[key] = mark.striptags(value)
            kwargs['request_get'] = params
        elif request.method == "POST":
            if request.get_json():
                json_data = request.get_json()
                for key, value in json_data.items():
                    json_data[key] = mark.striptags(value)
                kwargs['request_get'] = json_data
            else:
                form_data = request.form.to_dict()
                for key, value in form_data.items():
                    form_data[key] = mark.striptags(value)
                kwargs['request_get'] = form_data
        return f(*args, **kwargs)
    return decorated_function
