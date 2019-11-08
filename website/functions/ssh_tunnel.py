import getpass
from sshtunnel import SSHTunnelForwarder


def tunnelServer():
    """
    Creates a tunnel to a server
    :return: Server information
    """

    # Get network information
    host = input("Enter host:\n")
    port = int(input("Enter host port:\n"))

    username = input("Network Username:\n")
    try:
        password = getpass.getpass(prompt="Network Password:\n")
    except getpass.GetPassWarning as error:
        exit()

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
