# -*- coding: utf-8 -*-
"""
Created on Fri Feb  3 19:15:56 2017

@author: ronakshah
"""

import shutil
import os

def CopyFilesOutSideFolder (sourcepath) :
    textfiles = []
    for path, subdirs, files in os.walk(sourcepath):
        for name in files:
            textfiles.append(os.path.join(path, name))
            
    
    for f in textfiles :
        shutil.copy(f, sourcepath)