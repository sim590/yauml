#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import setuptools
import yauml

setuptools.setup(
    name             = yauml.__name__,
    version          = yauml.__version__,
    packages         = setuptools.find_packages(),
    entry_points     = {
        'console_scripts': [ 'yauml = yauml.yauml:main' ]
    },
    data_files = [
        ('man/man1', ['doc/yauml.1']),
        ('share/bash-completion/completions', ['misc/bash-completion/yauml'])
    ],
    include_package_data = True,
    # metadata to display on PyPI
    author           = yauml.__author__,
    author_email     = yauml.__email__,
    description      = yauml.__description__,
    license          = yauml.__license__,
    keywords         = "uml yaml diagram object oriented",
    url              = "https://github.com/yauml/yauml",
    project_urls     = {
        "Source Code": "https://github.com/yauml/yauml",
    }
)

#  vim: set sts=4 ts=8 sw=4 tw=120 et :

