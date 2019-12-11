# PhotoSharing
> A Photo sharing website where a user is able to browse the collection of images uploaded by other users, or decide to
share their images as well.

[![made-with-python-v3.7](https://img.shields.io/badge/Made%20with-Python%20v3.7-1f425f.svg)](https://www.python.org/)
[![backend-flask](https://img.shields.io/badge/Backend-Flask-darkgreen.svg)](https://flask.palletsprojects.com/en/1.1.x/)
[![database-mysql](https://img.shields.io/badge/Database-MySQL-darkblue.svg)](https://www.mysql.com/)
[![styling-bootstrap](https://img.shields.io/badge/Styling-Bootstrap-purple.svg)](https://getbootstrap.com/)
[![framework-jquery](https://img.shields.io/badge/Framework-jQuery-orange.svg)](https://jquery.com/)
[![GPLv3 license](https://img.shields.io/badge/License-GPLv3-blue.svg)](http://perso.crans.org/besson/LICENSE.html)

<details>
<summary>Table of Content</summary>

## Table of Content
- [PhotoSharing](#photosharing)
    - [Dependencies](#dependencies)
    - [Added Files/Directories](#added-files/directories)
    - [File Descriptions](#file-descriptions)
    - [Future Plans](#future-plans)
</details>

## Dependencies
### Python Dependencies
- Flask
- Flask-Mail
- Flask-sshtunnel
- Flask-Bcrpyt
- Flask-SQLAlchemy
- PyMySQL
- Flask-Marshmallow
- marshmallow-sqlalchemy
### Frontend Dependencies
- Bootstrap
- jQuery

## Added Files/Directories
1. The first file that you will need to add that is not included is a login text file that is stored inside of the 
website directory. This file is called login.txt and the setup is like this:  
Line 1: [Host name of where the database is located] Example: host.location.com  
Line 2: [Port number to tunnel into the network] Example: 22  
Line 3: [Username to access the network] Example: someguy5  
Line 4: [Password tied to the username] Example: somepassword  
Line 5: [Email address for site sending] Example: random@provider.com  
Line 6: [Password tied to the email address] Example somepassword2  

2. A directory called users that is stored under website/static/images. This is the location where the user account 
folders will be stored.

## File Descriptions
### blueprints
- decorators.py  
This file stores the multitude of decorators that can be applied to a flask route to process form information sent, 
check login status, and anything else that needs to be created.
- users_api.py  
This file has the routes that performs work that deals majorly with the users. For example, creating a new user or 
logging them into the system.
- photos_api.py  
This file has the routes that performs work that deals majorly with the photos. For example, uploading a new photo or 
generating a comment for a specific photo.
- routes.py  
This file deals mostly with routing to the html pages that the user will be viewing.

### functions
- email.py  
Functions used for sending emails to the users
- folders.py  
Functions used for creating folders as well as removing them
- read_login_file.py  
Functions used for reading the login.txt file located in the website directory
- ssh_tunnel.py  
Functions used for tunneling into a remote network for accessing the database on that system
- tokens.py  
Functions used for generating tokens when provided with a string

### static
- This directory stores default images used throughout the website, javascript files tied to their respective html 
pages, and stylesheet for website styling

### templates
- This directory stores the main templates used by the partial templates for site rendering 

### \_\_init__.py
- This file handles the registering of the blueprints, setting up different Flask Objects, and error handling

### config.py
- This file handles the Flask configurations. For example, the database uri, mail connection, secret_key, and upload 
parameters

### errors.py
- This file deals with different HTTP errors like 404 and 500

### models.py
- This file handles the modeling of MySQL views from the database

### login.txt
- While not provided by this repository, this file is required to access a remote database through tunneling as well as 
providing email credentials for sending emails to the users

### database.sql
- This file is used to import the tables, views, stored procedures, and dummy data for using this website. As a note, 
when removing dummy data, the first account 'admin' should not be deleted as it is the account where the
default photos are saved. If you decide to modify the code of this project to no longer have the admin account, then 
go for deletion.

## Future Plans
This project is planned to be worked on to add a few features as a learning tool. Such new features are:
- Search Bar/Page
- Photo tags
- Video Support
- Stories/Grouped Albums
    