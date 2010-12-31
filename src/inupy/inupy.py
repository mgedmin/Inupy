import logging
import os
import re

from mako.lookup import TemplateLookup
from webob import Request

here_dir = os.path.dirname(os.path.abspath(__file__))

from utils import check_ipfilter, get_js_code


class Inupy(object):
    def __init__(self, app, config=None, loglevel='DEBUG', **kwargs):
        """ Wrapper object that adds the toolbox ui to the pagesse

        """
        self.app = app
        self.tmpl_dir = os.path.join(here_dir, 'templates')
        self.mako = TemplateLookup(directories=[self.tmpl_dir])

        self.inupy_config = config
        self.logger = logging.getLogger(__name__)
        self.loglevel = getattr(logging, loglevel)

    def __call__(self, environ, start_response):
        req = Request(environ)
        self.logger.log(self.loglevel, 'request started')
        response = req.get_response(self.app)

        if self.inupy_config.get('ipfilter') and not check_ipfilter(environ,
                self.inupy_config['ipfilter']):
            # then we want to filter on ip and this one failed
            pass
        else:
            self.logger.log(self.loglevel, 'request finished')
            if 'content-type' in response.headers and \
               response.headers['content-type'].startswith('text/html'):
                controls_ui = self.render_html('/controls.mako',
                        inupy_config=self.inupy_config)

                replacement = r'<body\1><script type="text/javascript">inupy_js</script>{0}'.format(controls_ui)
                response.body = re.sub(r'<body([^>]*)>', replacement, response.body)
                response.body = response.body.replace('inupy_js', get_js_code(self.tmpl_dir))

        return response(environ, start_response)

    def render_html(self, name, **vars):

        tmpl = self.mako.get_template(name)
        return tmpl.render(**vars)
