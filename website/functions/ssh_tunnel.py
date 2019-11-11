from sshtunnel import SSHTunnelForwarder


def tunnelServer():
    """
    Creates a tunnel to a server
    :return: Server information
    """

    # Get network information
    with open('login.txt') as login:
        file = login.read().splitlines()
        host = file[0]
        port = int(file[1])
        username = file[2]
        password = file[3]

    # Retrieve server information
    server = SSHTunnelForwarder(
        (host, port),
        ssh_username=username,
        ssh_password=password,
        remote_bind_address=('127.0.0.1', 3306)
    )

    # Starts the server
    server.start()

    return server
