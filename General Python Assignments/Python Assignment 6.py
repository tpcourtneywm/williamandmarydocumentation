# -*- coding: utf-8 -*-
"""
Created on Mon Sep 27 20:22:13 2021

@author: thoma
"""

import numpy as np #import numpy
a = np.random.rand(10, 4) #create array
print("Original array: ") #print text
print(a) #print array
b= a[:5, :] #create a variable where the first five rows of the original array are stored
print("First 5 rows of the above array:") #print text
print(b) #print first five rows