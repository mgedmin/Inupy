import logging
import os
import re
import time

from mako.lookup import TemplateLookup
from webob import Request

from utils import check_ipfilter

try:
    import thread
except ImportError:
    thread = None

try:
    import json
except ImportError:
    json = None


here_dir = os.path.dirname(os.path.abspath(__file__))


class Logview(object):
    def __init__(self, app, config=None, loglevel='DEBUG', **kwargs):
        """Stores logging statements per request, and includes a bar on
        the page that shows the logging statements

        ''loglevel''
            Default log level for messages that should be caught.

            Note: the root logger's log level also matters!  If you do
            logging.getLogger('').setLevel(logging.INFO), no DEBUG messages
            will make it to Logview's handler anyway.

        """
        self.app = app
        tmpl_dir = os.path.join(here_dir, 'templates')
        self.mako = TemplateLookup(directories=[tmpl_dir])

        self.inupy_config = config

        if loglevel is None:
            self.loglevel = logging.getLogger('').level
        elif isinstance(loglevel, basestring):
            self.loglevel = getattr(logging, loglevel)
        else:
            self.loglevel = loglevel

        reqhandler = RequestHandler()
        reqhandler.setLevel(self.loglevel)
        logging.getLogger('').addHandler(reqhandler)
        self.reqhandler = reqhandler

        self.logger = logging.getLogger(__name__)
        self.logger.propagate = False
        self.logger.setLevel(self.loglevel)
        self.logger.addHandler(reqhandler)


    def __call__(self, environ, start_response):
        if thread:
            tok = thread.get_ident()
        else:
            tok = None

        req = Request(environ)
        start = time.time()
        self.logger.log(self.loglevel, 'request started')
        response = req.get_response(self.app)

        if self.inupy_config['ipfilter'] and not check_ipfilter(environ,
                self.inupy_config['ipfilter']):
            # then we want to filter on ip and this one failed
            pass
        else:
            self.logger.log(self.loglevel, 'request finished')
            tottime = time.time() - start
            reqlogs = self.reqhandler.pop_events(tok)
            if 'content-type' in response.headers and \
               response.headers['content-type'].startswith('text/html'):
                logbar = self.render_html('/logbar.mako', events=reqlogs,
                                     logcolors=self.inupy_config['log_colors'], tottime=tottime,
                                     start=start)
                response.body = re.sub(r'<body([^>]*)>', r'<body\1>%s' % logbar, response.body)

            elif 'content-type' in response.headers and json and \
               response.headers['content-type'].startswith('application/json'):
                response.body = self.render_json(response.body, events=reqlogs,
                                     logcolors=self.inupy_config['log_colors'], tottime=tottime,
                                     start=start)

        return response(environ, start_response)

    def render_html(self, name, **vars):
        tmpl = self.mako.get_template(name)
        return tmpl.render(**vars)

    def render_json(self, json_body, **vars):
        """Append the log info into _inupy_logview object in json response"""

        # @todo figure out how to do this, duplicate timing code, might want
        # json diff format vs html though.
        def format_time(record, start, prev_record=None):
            if prev_record:
                delta_from_prev = (record.created - prev_record.created) * 1000
                return '%+dms' % delta_from_prev
            else:
                time_from_start = (record.created - start) * 1000
                return '%+dms' % time_from_start

        prev_event = None
        event_list = []

        for event in vars['events']:
            event_list.append({'time': format_time(event, vars['start'], prev_event),
                   'level': event.levelname,
                   'model': event.name,
                   'message': event.getMessage()})

            prev_event = event

        resp = json.loads(json_body)
        resp['_inupy_logview'] = event_list
        return json.dumps(resp)


class RequestHandler(logging.Handler):
    """
    A handler class which only records events if its set as active for
    a given thread/process (request). Log history per thread must be
    removed manually, preferably at the end of the request. A reference
    to the RequestHandler instance should be retained for this access.

    This handler otherwise works identically to a request-handler,
    except that events are logged to specific 'channels' based on
    thread id when available.

    """
    def __init__(self):
        """Initialize the handler."""
        logging.Handler.__init__(self)
        self.buffer = {}

    def emit(self, record):
        """Emit a record.

        Append the record. If shouldFlush() tells us to, call flush() to process
        the buffer.
        """
        self.buffer.setdefault(record.thread, []).append(record)

    def pop_events(self, thread_id):
        """Return all the events logged for particular thread"""
        if thread_id in self.buffer:
            return self.buffer.pop(thread_id)
        else:
            return []

    def flush(self):
        """Kills all data in the buffer"""
        self.buffer = {}

    def close(self):
        """Close the handler.

        This version just flushes and chains to the parent class' close().
        """
        self.flush()
        logging.Handler.close(self)
