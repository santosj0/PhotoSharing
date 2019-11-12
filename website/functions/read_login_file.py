def get_database_information():
    with open('login.txt') as login:
        file = login.read().splitlines()
    return file[0], int(file[1])


def get_network_information():
    with open('login.txt') as login:
        file = login.read().splitlines()
    return file[2], file[3]


def get_email_information():
    with open('login.txt') as login:
        file = login.read().splitlines()
    return file[4], file[5]
