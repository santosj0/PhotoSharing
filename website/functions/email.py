from flask_mail import Message
from flask import render_template
from website import mail
from smtplib import SMTPException


def send_mail(subject, recipient, body=None, html=None, links=None):
    """
    General template for sending emails
    :param subject: Email subject as a string
    :param recipient: The user being sent the mail to
    :param body: Optional. Email body as a string
    :param html: Optional. Path location where the html will be rendered
    :param links: A dictionary of links with the format:
    {
        {
            '<LINK-NAME>' : '<LINK-URL>',
            '<LINK-NAME>' : '<LINK-URL>'
        }
    }
    """
    try:
        # Create the message body
        msg = Message(subject,
                      recipients=[recipient])

        # Add html to the page
        if html is not None:
            if links is not None:
                html = render_template(html, **links)
            else:
                html = render_template(html)
            msg.html = html

        # Add a body to the page
        if body is not None:
            msg.body = body

        # Send the message
        mail.send(msg)

        result = 1
    except SMTPException:
        result = 0

    return result
