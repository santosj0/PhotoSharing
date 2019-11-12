from sshtunnel import SSHTunnelForwarder
from website.functions.read_login_file import get_database_information, get_network_information


def tunnel_server():
    """
    Creates a tunnel to a server
    :return: Server information
    """

    # Get network information
    host, port = get_database_information()
    username, password = get_network_information()

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
