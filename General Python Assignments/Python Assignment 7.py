# -*- coding: utf-8 -*-
"""
Created on Mon Sep 27 19:03:56 2021

@author: thoma
"""




import numpy as np #import numpy
randarray=np.random.randint(0,9,size=(3,3,3)) #create a random 3 x 3 x 3 array
print(randarray) #print the array
print("Most frequent value in the above array:",np.argmax(np.bincount(randarray.flat))) #print the most frequent value in the above array