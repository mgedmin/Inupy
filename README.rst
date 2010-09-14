inupy fork/port of Dozer
==========================

**inupy** is meant to be a combination of the tools of `Dozer`_ into a single user
panel. You enabled it by adding it to your `middleware.py` in a Pylons project
like so:

::

    import inupy
    app = inupy.setup(app, config)
    
    # config is the pylons environment config
    # config = load_environment(global_conf, app_conf)


Your application config should have options set for the various tools you wish
to enable.

::

    set inupy.profiler = true
    set inupy.logview = true
    set inupy.profile_path = /home/user/tmp/profiles
    inupy.color.sqlalchemy = #faa
    inupy.color.pylons.templating = #bfb


Some goals are to embed a version of jQuery into it's own namespace so it
doesn't collide with the installed applications, but gives us some tools for
some animations/etc. Example screenshot of the control panel pop down.

http://lh3.ggpht.com/_MbJoFDKjoVk/TI1rVgf7xpI/AAAAAAAAAKY/8-jVptqp_Sk/s800/dozer_menu.png


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
