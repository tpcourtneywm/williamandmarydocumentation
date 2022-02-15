# -*- coding: utf-8 -*-
"""
Created on Wed Sep  1 08:17:11 2021

@author: thoma
"""

from math import *

def ladder_length():
    print("Determine the length of a ladder required to reach a given height when leaned against a house. ")
    #directions
    height = eval(input("In total feet, how high does the ladder need to go "))
    #input the height
    angle_degrees = eval(input("In degrees, at what angle will you be placing the ladder? "))
    #input the angle that the ladder will be at
    angle_radians = ((pi / 180) * angle_degrees)
    #switch from degrees to radians
    ladder_length = (height / sin(angle_radians))
    #use the calculation to detemine the length of ladder
    print("the ladder should be ", ladder_length, "feet")
    #print result

ladder_length()