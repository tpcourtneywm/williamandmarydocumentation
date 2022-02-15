# -*- coding: utf-8 -*-
"""
Created on Mon Sep 20 18:34:42 2021

@author: thoma
"""

lovepoem = open("C://Users//thoma//OneDrive//Documents//AI//M4//buad5802-m4-python-assignment-data-file-romeo.txt")
#fh = open(fname)
list = list()                       # create a list to eventually print
for line in lovepoem:                    # read line from text file
    text= line.rstrip().split()    # turn each line into a list of words
    for element in text:           # check every element in your list of words   
        if element in list:         # confirm that the element is not repeated
            continue               # do nothing
        else :                     # if the element is repeated
            list.append(element)    # append from the list
list.sort()                         # sort the list 
print (list)                          # print the list