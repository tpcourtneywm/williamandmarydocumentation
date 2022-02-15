# -*- coding: utf-8 -*-
"""
Created on Wed Sep  1 16:10:14 2021

@author: thoma
"""

datalist = [1452, 11.23, 1+2j, True, 'w3resource', (0, -1), [5, 12], {"class":'V', "section":'A'}] #create your variable
for item in datalist: #start your for loop, for each individual item in your list
   print (item, " is ", type(item)) #print the item in the list, the word is, and the data type for each item