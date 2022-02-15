# -*- coding: utf-8 -*-
"""
Created on Wed Sep  1 16:13:02 2021

@author: thoma
"""

for x in range(51): #for a range of values between 0-50
    if x % 3 == 0 and x % 5 == 0: # if it is divisable by 3 and 5
        print("fizzbuzz") # print it as fizzbuzz
        continue 
    elif x % 3 == 0: #if just divisable by 3
        print("fizz") #print fizz
        continue
    elif x % 5 == 0: #if divisable by five
        print("buzz") #print buzz
        continue
    print(x) #print x a list that includes the different variables