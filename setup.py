from setuptools import setup, find_packages
import sys, os

here = os.path.abspath(os.path.dirname(__file__))
README = open(os.path.join(here, 'README.rst')).read()
NEWS = open(os.path.join(here, 'NEWS.txt')).read()


version = '0.1'

install_requires = [
    "Paste>=1.6",
    "WebOb>=0.9.2",
    "mako",
]

setup(name='inupy',
    version=version,
    description="Set of wsgi middleware for debug tools for Pylons",
    long_description=README + '\n\n' + NEWS,
    classifiers=[
      # Get strings from http://pypi.python.org/pypi?%3Aaction=list_classifiers
    ],
    keywords='pylons wsgi profile logging',
    author='Richard Harding',
    author_email='rharding@mitechie.com',
    url='',
    license='',
    packages=find_packages('src'),
    package_dir = {'': 'src'},include_package_data=True,
    zip_safe=False,
    install_requires=install_requires,
    entry_points="""
        [paste.filter_factory]
        inupy = inupy:inupy_filter_factory
        [paste.filter_app_factory]
        inupy = inupy:inupy_filter_app_factory
    """,
)
