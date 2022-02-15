# -*- coding: utf-8 -*-
"""
Created on Mon Sep 20 18:49:36 2021

@author: thoma
"""

daysdict = {} #create your dictionary
dayslist = [] #create your list

with open("C://Users//thoma//OneDrive//Documents//AI//M4//buad5802-m3-python-assignment-data-file (1).txt") as emails: #load in your data
  for data in emails: #start your list
    dayslist = data.split() #split the data into individual words
    if len(dayslist) > 3 and data.startswith('From'): #if there is less than three words after the word from
      day = dayslist[2] #create the list
      if day not in daysdict: #don't add the number
        daysdict[day] = 1
      else:
        daysdict[day] += 1 #add more to the count
  print (daysdict) #print the dictionary