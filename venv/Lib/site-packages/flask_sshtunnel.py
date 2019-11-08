from sshtunnel import SSHTunnelForwarder, create_logger
from flask import current_app

# Find the stack on which we want to store the database connection.
# Starting with Flask 0.9, the _app_ctx_stack is the correct one,
# before that we need to use the _request_ctx_stack.
try:
    from flask import _app_ctx_stack as stack
except ImportError:
    from flask import _request_ctx_stack as stack


class Tunnel(object):
    def __init__(self, app, *args, **kwargs):
        self.tunnel = SSHTunnelForwarder(*args, **kwargs)

        self.app = app
        if app is not None:
            self.init_app(app)

    # Use this method if you're using multiple apps
    # MyExt().init_app(app)
    # Only works if you don't override self.app
    # Don't use self.app but take in an app object each time you connect/teardown
    def init_app(self, app):
        # Use the newstyle teardown_appcontext if it's available,
        # otherwise fall back to the request context
        app.config.setdefault('')
        if hasattr(app, 'teardown_appcontext'):
            app.teardown_appcontext(self.teardown)
        else:
            app.teardown_request(self.teardown)

    def connect(self):
        return self.tunnel

    def teardown(self, exception):
        ctx = stack.top
        if hasattr(ctx, 'ssh_tunnel'):
            print("closing ssh tunnel...")
            ctx.ssh_tunnel.stop()

    @property
    def connection(self):
        ctx = stack.top
        if ctx is not None:
            if not hasattr(ctx, 'ssh_tunnel'):
                ctx.ssh_tunnel = self.connect()
            return ctx.ssh_tunnel
        else:
            print("Context is undefined")
