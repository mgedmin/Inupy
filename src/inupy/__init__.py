import logging
import itertools
from paste.deploy.converters import asbool

from inupy import Inupy

log = logging.getLogger(__name__)

def inupy_filter_factory(global_conf, **kwargs):
    log.debug(global_conf)
    log.debug(kwargs)
    def filter(app):
        return Inupy(app, global_conf, **kwargs)
    return filter

def inupy_filter_app_factory(app, global_conf, **kwargs):
    return Inupy(app, global_conf, **kwargs)


def setup(app, config, **kwargs):
    """Determine to setup and modify the wsgi app

    """
    inupy_config = process_config(itertools.chain(config.iteritems(),
                                kwargs.iteritems()))
    app = Inupy(app, inupy_config)

    return app

def process_config(config_values):
    """Provide a dict back of the various config information we might accept

    Examples:
    inupy.colors.sqlalchemy = #faa
    inupy.ipfilter = 127.0.0.1
     or
    inupy.ipfilter = 127.0.0.1,10.10.10.1
    """
    proc_config = {}
    proc_config['log_colors'] = {}
    proc_config['ipfilter'] = False
    proc_config['logview'] = False
    proc_config['profiler'] = False
    proc_config['memory'] = False

    opt = ['logview', 'profiler', 'memory']

    for key, val in config_values:
        if key.startswith('inupy.'):
            our_key = key[6:]

            if our_key == 'ipfilter':
                if ',' in val:
                    proc_config['ipfilter'] = [v.strip() for v in val.split(',')]
                else:
                    proc_config['ipfilter'] = val

            # allow for customizing the colors used for specific log items
            elif our_key.startswith('color.'):
                proc_config['log_colors'][our_key[6:]] = val

            elif our_key == 'logview':
                proc_config['logview'] = asbool(val)

            elif our_key == 'profiler':
                proc_config['profiler'] = asbool(val)

            elif our_key == 'memory':
                proc_config['memory'] = asbool(val)

            else:
                proc_config[key] = val


    return proc_config
