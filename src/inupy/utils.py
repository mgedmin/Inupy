import os

def check_ipfilter(environ, ipfilter):
    """Only display the logview info if the user's ip is a valid one
    
    :param environ: the wsgi environ property
    :param ipfilter: list of ip addresses to check against

    """
    if 'HTTP_X_FORWARDED_FOR' in environ:
        user_ip = environ['HTTP_X_FORWARDED_FOR']
    else:
        user_ip = environ['REMOTE_ADDR']

    if user_ip in self.ipfilter:
        return True
    else:
        return False

def get_js_code(tmpl_dir):
    """Just to load up the custom jquery as DV so we can use it"""
    return open(os.path.join(tmpl_dir, 'inupy.js')).read()
