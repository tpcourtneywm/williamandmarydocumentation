# -*- coding: utf-8 -*-
"""
Created on Fri Sep 10 14:51:05 2021

@author: thoma
"""

string = 'X-DSPAM-Confidence: 0.8475'

colon_pos = string.find(':')# Finds the position of the colon 
value = string[colon_pos + 1:] # Extracts portion  we want
num = float(value) # Converts to floating 
print(num) #prints the number
print(type(num)) #prints the type