# -*- coding: utf-8 -*-
"""
Created on Wed Sep  1 16:07:58 2021

@author: thoma
"""

x=5; #set your starting number at 5, the maximum amount of stars you want

#this first part will just start with numbers from 0-4, because that is how python handles the number five
for i in range(x): #start your for loop
    for y in range(i): #for numbers within the range of x
        print ('* ', end="") #put a start
    print('') #print the values


#now we will start going down, start at five which will be our middle all the way down to zero
for i in range(x,0,-1): #start your for loop
    for y in range(i): #identify range
        print('* ', end="") #put a star
    print('') #print

