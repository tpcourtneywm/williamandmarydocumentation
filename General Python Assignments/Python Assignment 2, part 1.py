# -*- coding: utf-8 -*-
"""
Created on Wed Sep  1 16:02:45 2021

@author: thoma
"""
#this program will find all numbers between 1500 and 2700 that are divisable by 5 and 7
numbersl=[] #make an empty list that all numbers that fit that category will go into
for z in range(1500, 2701): #set the range of values you want to look at
    if (z%5==0) and (z%7==0): #create your if statement, so if it is disable by both
        numbersl.append(str(z)) #if it meets the critera, it goes into your numbers list
print (','.join(numbersl)) #print the list with commas inbetween