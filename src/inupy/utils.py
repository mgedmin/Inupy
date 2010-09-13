def check_ipfilter(self, environ, ipfilter):
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
