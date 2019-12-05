from secrets import choice
from string import ascii_letters, digits
from random import randint
from itsdangerous import URLSafeTimedSerializer
from website import app


def generate_random_string(length=randint(50, 100)):
    return ''.join(choice(ascii_letters + digits) for i in range(length))


def generate_token(word=generate_random_string()):
    serializer = URLSafeTimedSerializer(app.config['SECRET_KEY'])
    return serializer.dumps(word, salt=app.config['SECURITY_PASSWORD_SALT'])


def validate_token(token, expiration=3600):
    serializer = URLSafeTimedSerializer(app.config['SECRET_KEY'])
    return serializer.loads(token, salt=app.config['SECURITY_PASSWORD_SALT'], max_age=expiration)


def validate_token_inf(token):
    serializer = URLSafeTimedSerializer(app.config['SECRET_KEY'])
    return serializer.loads(token, salt=app.config['SECURITY_PASSWORD_SALT'])
