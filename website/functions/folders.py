import os
from shutil import rmtree


def move_up(path, separator, amount):
    """
    Move up the file system
    :param separator: String that will be used to separate directories
    :param path: String where the path starts
    :param amount: Integer of the number of directories you want to move out of
    :return: String indicating where the path is
    """
    return path.rsplit(separator, amount)[0]


def make_folder(start_path, directory):
    """
    Generates a directory at desired path location
    :param start_path: Initial path where the diretory will be created
    :param separator: Delimiter
    :param amount: Number of directories to go up from
    :param directory: Name of the new directory
    :return: Location of the new directory that was created
    """

    # Set the location to make the folders
    location = start_path + directory

    # Creates the folder
    os.mkdir(location, 0o755)

    return location


def generate_user_folders(path, separator, username):
    try:
        upath = make_folder(path, separator + username)
        make_folder(upath, separator + "profile_pic")
        make_folder(upath, separator + "uploads")
    except FileExistsError:
        rmtree(path, separator, username)


def delete_user_folders(path, separator, username):
    rmtree(path + separator + username)


if __name__ == "__main__":
    generate_user_folders(os.getcwd(), '\\', 'tony')
    # delete_user_folders(os.getcwd(), '\\', 'tony')
