# -*- coding: utf-8 -*-
"""
Created on Fri Sep 10 14:56:49 2021

@author: thoma
"""

fname = ("C:\\Users\\thoma\\OneDrive\\Documents\\AI\\M3\\buad5802-m3-python-assignment-data-file.txt") #load in your raw text file
fh = open(fname) #open text file
count = 0 #initialize the count and total as zero
total = 0
for line in fh: #begin your function
    if not line.startswith("X-DSPAM-Confidence:") : continue #if the line does not start with the value, keep on going
    t=line.find("0") #find the values that with the value
    number= float(line[t:]) #keep the number increasing to get all the values
    count = count + 1 #keep counting the number of times you see this value
    total = total + number #get the total number of lines

average = total/count #average the values
print ("Average spam confidence:",average) #print your results