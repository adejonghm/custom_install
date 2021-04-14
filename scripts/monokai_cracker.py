#!/usr/bin/env python3

import fnmatch
from shutil import copyfile
from os import getenv, listdir

path = getenv("HOME") + "/.vscode/extensions/"

for monokai in listdir(path):
    if fnmatch.fnmatch(monokai, 'monokai*'):
        copyfile("../templates/app.js", "{0}/{1}/js/app.js".format(path, monokai))

print("The Monokai Pro theme is cracked.")
