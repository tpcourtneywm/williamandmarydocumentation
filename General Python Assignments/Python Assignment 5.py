# -*- coding: utf-8 -*-
"""
Created on Mon Sep 27 20:23:17 2021

@author: thoma
"""

import numpy as np #import numpy
a = np.random.random(15) #create a vector with 15 random values
print("Original array:") #print text
print(a) #print original text
a[a.argmax()] = -1 #replace the maximum value with -1
print("Maximum value replaced by -1:") #print text
print(a) #print new vector