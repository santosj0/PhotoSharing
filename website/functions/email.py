def get_username():
    with open('login.txt') as login:
        file = login.read().splitlines()
    return file[4]


def get_password():
    with open('login.txt') as login:
        file = login.read().splitlines()
    return file[5]
