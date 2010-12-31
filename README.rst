inupy fork/port of Dozer
==========================

**inupy** is meant to be a combination of the tools of `Dozer`_ into a single
WSGI middleware providing a combined user panel.  The tools are:

* memory profiler
* CPU profiler
* capture of logging messages


Setup
-----

You can enable inupy for your application by editing your WSGI factory
function, or your PasteDeploy configuration file.

Option 1: add this to your ``development.ini`` (or whatever you call your
PasteDeploy config file)::

    [filter-app:inupy]
    use = egg:Inupy
    # ... options ...
    next = main
    # assuming your main wsgi app is [app:main]

and then to use it, run ``paster serve development.ini -n inupy``.  If you do
not specify the ``-n`` bit, inupy is disabled.

Option 2: change your ``development.ini`` like this::

    [filter:inupy]
    use = egg:Inupy
    # ... options ...

    [pipeline:main]
    pipeline =
        inupy
        ...
        yourapp
    # assuming your main wsgi app is [app:yourapp]

this way ``inupy`` is always availabe.

Option 3: edit your ``middleware.py`` (assuming a Pylons style project) like
this::

    import inupy

    def make_app(...):
        ...
        if asbool(config['debug']):
            app = inupy.setup(app, config)
        app.config = config
        return app

this way it is enabled only if you have ``debug = true`` in your
``development.ini``.

Your application config should have options set for the various tools you wish
to enable, e.g. ::

    set inupy.profiler = true
    set inupy.logview = true
    set inupy.profile_path = /home/user/tmp/profiles
    inupy.color.sqlalchemy = #faa
    inupy.color.pylons.templating = #bfb


Goals
-----

Some goals are to embed a version of jQuery into it's own namespace so it
doesn't collide with the installed applications, but gives us some tools for
some animations/etc. Example screenshot of the control panel pop down.

.. image:: http://lh3.ggpht.com/_MbJoFDKjoVk/TI1rVgf7xpI/AAAAAAAAAKY/8-jVptqp_Sk/s800/dozer_menu.png


Credits
-------
- `Dozer`_
- `Marius's fork of Dozer`_

- `Distribute`_
- `Buildout`_
- `modern-package-template`_

.. _Dozer: http://bitbucket.org/bbangert/dozer/overview
.. _`Marius's fork of Dozer`: http://bitbucket.org/mgedmin/dozer/overview
.. _Buildout: http://www.buildout.org/
.. _Distribute: http://pypi.python.org/pypi/distribute
.. _`modern-package-template`: http://pypi.python.org/pypi/modern-package-template
