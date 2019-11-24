import website.models as wm
import re
from website import app, db
from flask import session, url_for, redirect, request, jsonify
from functools import wraps
from flask import Markup as mark


def validate_number_range(param, start=1, end=10, message="Invalid Parameter"):
    """
    Makes sure that the parameter is a number in the specified range
    :param param: The name of the parameter that holds the string to be validated
    :param start: The start of the range
    :param end: The end of the range
    :param message: Error message to be sent
    :return: The desired route or an error response
    """
    def decorated(f):
        @wraps(f)
        def decorated_function(*args, **kwargs):
            # Get email string based on param
            if kwargs['request_get']:
                number = kwargs['request_get'][param]
            else:
                if request.method == "GET":
                    number = request.get(param)
                elif request.method == "POST":
                    if request.get_json():
                        number = request.get_json().get(param)
                    else:
                        number = request.form[param]
                else:
                    return jsonify({'result': "Allowed methods: GET, POST"})

            # Checks to make sure number is in range
            if re.fullmatch(r'[' + str(start) + '-' + str(end) + ']', number):
                return f(*args, **kwargs)
            else:
                return jsonify({'result': message})
        return decorated_function
    return decorated


def validate_text_numbers(param, message="Invalid Parameter"):
    """
    Validates a string to only have numbers, letters, hyphens, and underscores only
    :param param: The name of the parameter that holds the string to be validated
    :param message: Error message to be sent
    :return: The desired route or an error response
    """
    def decorated(f):
        @wraps(f)
        def decorated_function(*args, **kwargs):
            # Get email string based on param
            if kwargs['request_get']:
                string = kwargs['request_get'][param]
            else:
                if request.method == "GET":
                    string = request.get(param)
                elif request.method == "POST":
                    if request.get_json():
                        string = request.get_json().get(param)
                    else:
                        string = request.form[param]
                else:
                    return jsonify({'result': "Allowed methods: GET, POST"})

            # Letters and numbers only
            if re.fullmatch(r'[\w-]+$', string):
                return f(*args, **kwargs)
            else:
                return jsonify({'result': message})
        return decorated_function
    return decorated


def validate_eaddress(param):
    """
    This function determines if the provided email is valid
    :param param: The name of the parameter that holds the email
    :return: The desired route or an error response
    """

    def decorated(f):
        @wraps(f)
        def decorated_function(*args, **kwargs):
            # Get email string based on param
            if kwargs['request_get']:
                email = kwargs['request_get'][param]
            else:
                if request.method == "GET":
                    email = request.get(param)
                elif request.method == "POST":
                    if request.get_json():
                        email = request.get_json().get(param)
                    else:
                        email = request.form[param]
                else:
                    return jsonify({'result': "Allowed methods: GET, POST"})

            # Valid - word@word.word
            if re.fullmatch(r'^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w+)+$', email):
                return f(*args, **kwargs)
            else:
                return jsonify({'result': "Invalid Email Address"})
        return decorated_function
    return decorated


def make_request_get(f):
    """
    Adds request_get to kwargs without any modifications
    :return: The desired route or an error response
    """
    @wraps(f)
    def decorated_function(*args, **kwargs):
        # Retrieves the data
        if request.method == "GET":
            params = request.args.to_dict()
        elif request.method == "POST":
            if request.get_json():
                params = request.get_json()
            else:
                params = request.form.to_dict()
        else:
            return jsonify({'result': "Allowed methods: GET, POST"})

        # Sets the parameters to kwargs
        kwargs['request_get'] = params
        return f(*args, **kwargs)
    return decorated_function


def login_required(f):
    """
    Returns to the route if the user is logged_in. Otherwise, redirects to login page
    :return: Either a redirect or the desired webpage
    """

    @wraps(f)
    def decorated_function(*args, **kwargs):
        if session.get('logged_in'):
            return f(*args, **kwargs)
        return redirect(url_for('routes.login'))

    return decorated_function


def not_logged(f):
    """
    Only non-logged in users may access this page
    :return: The desired route or a redirect to the homepage
    """

    @wraps(f)
    def decorated_function(*args, **kwargs):
        if session.get('logged_in') is None:
            return f(*args, **kwargs)
        return redirect(url_for('routes.index'))

    return decorated_function


def uploader_only(param):
    """
    Allows only the uploader of the specified photo allowed to the route
    :param param: Name of the parameter that holds the photo_id
    :return: The desired route, the failure results, or a redirect to login
    """

    def decorator(f):
        @wraps(f)
        def decorated_function(*args, **kwargs):
            # Logged In users only
            if session.get('logged_in'):

                # Get photo_id based on param
                if request.method == "GET":
                    pid = request.get(param)
                elif request.method == "POST":
                    if request.get_json():
                        pid = request.get_json().get(param)
                    else:
                        pid = request.form[param]
                else:
                    return jsonify({'result': "Allowed methods: GET, POST"})

                username = session['username']

                # Get the uploader based on the photo
                tagp = wm.TaggedPhotos
                uname = tagp.query.with_entities(tagp.uploader).filter_by(photo_id=pid).first()
                output = wm.TaggedPhotosSchema().dump(uname)

                # Ends the session with the database
                db.session.close()

                # Check to make sure photo exists and user is the uploader
                if uname:
                    if output['uploader'] == username:
                        return f(*args, **kwargs)
                    else:
                        return jsonify({'result': "You're not the uploader"})
                else:
                    return jsonify({'result': "Photo does not exist"})
            else:
                return redirect(url_for('routes.login'))

        return decorated_function

    return decorator


def check_file_type(param):
    """
    Checks the parameters sent to the route and makes sure that the file is valid
    :param param: The parameter name for the file
    :return: The route if the file is valid or a result saying that it is not valid
    """

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


def html_escape_values_params(pmeter):
    """
    Escape only the specified parameters
    :param pmeter: List of parameter names
    :return: A dictionary of the modified parameters in the kwargs tied to the key 'requeest_get'. To get the information,
    use kwargs['request_get'] to get the parameter dictionary
    """

    def decorator(f):
        @wraps(f)
        def decorated_function(*args, **kwargs):
            # Get the parameters
            if request.method == "GET":
                params = request.args.to_dict()
            elif request.method == "POST":
                if request.get_json():
                    params = request.get_json()
                else:
                    params = request.form.to_dict()
            else:
                return jsonify({'result': "Allowed methods: GET, POST"})

            # Convert parameters based on list provided
            for p in pmeter:
                params[p] = str(mark.escape(params[p]))

            # Add the modified parameters to kwargs
            kwargs['request_get'] = params
            return f(*args, **kwargs)

        return decorated_function

    return decorator


def html_escape_values(f):
    """
    Converts the html elements in the request data and converts it to html entities
    :return: A dictionary of the modified parameters in the kwargs tied to the key 'requeest_get'. To get the information,
    use kwargs['request_get'] to get the parameter dictionary
    """

    @wraps(f)
    def decorated_function(*args, **kwargs):
        # Retrieves the data
        if request.method == "GET":
            params = request.args.to_dict()
        elif request.method == "POST":
            if request.get_json():
                params = request.get_json()
            else:
                params = request.form.to_dict()
        else:
            return jsonify({'result': "Allowed methods: GET, POST"})

        # Modifies the data
        for key, value in params.items():
            params[key] = str(mark.escape(value))
        kwargs['request_get'] = params

        return f(*args, **kwargs)

    return decorated_function


def remove_html_tags_params(pmeter):
    """
    Strip only the specified parameters
    :param pmeter: List of parameter names
    :return: A dictionary of the modified parameters in the kwargs tied to the key 'requeest_get'. To get the information,
    use kwargs['request_get'] to get the parameter dictionary
    """

    def decorator(f):
        @wraps(f)
        def decorated_function(*args, **kwargs):
            # Get the parameters
            if request.method == "GET":
                params = request.args.to_dict()
            elif request.method == "POST":
                if request.get_json():
                    params = request.get_json()
                else:
                    params = request.form.to_dict()
            else:
                return jsonify({'result': "Allowed methods: GET, POST"})

            # Convert parameters based on list provided
            for p in pmeter:
                params[p] = mark.striptags(params[p])

            # Add the modified parameters to kwargs
            kwargs['request_get'] = params
            return f(*args, **kwargs)

        return decorated_function

    return decorator


def remove_html_tags(f):
    """
    Removes the html elements in the request data
    :return: A dictionary of the modified parameters in the kwargs tied to the key 'requeest_get'. To get the information,
    use kwargs['request_get'] to get the parameter dictionary
    """

    @wraps(f)
    def decorated_function(*args, **kwargs):
        # Gets the data
        if request.method == "GET":
            params = request.args.to_dict()
        elif request.method == "POST":
            if request.get_json():
                params = request.get_json()
            else:
                params = request.form.to_dict()
        else:
            return jsonify({'result': "Allowed methods: GET, POST"})

        # Converts the data
        for key, value in params.items():
            params[key] = mark.striptags(value)
        kwargs['request_get'] = params

        return f(*args, **kwargs)

    return decorated_function
