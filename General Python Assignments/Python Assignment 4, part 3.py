# -*- coding: utf-8 -*-
"""
Created on Mon Sep 20 19:15:39 2021

@author: thoma
"""

d = {}
message_freq = []

with open("C://Users//thoma//OneDrive//Documents//AI//M4//buad5802-m3-python-assignment-data-file (1).txt") as emails: #load in your data

    for data in emails: #begin your loop
        data = data.lower().split() #split the files
        try: #begin
            if data[0] == 'from': #if the data contains the word from
                d[data[1]] = d.get(data[1],0) + 1 #add one to the list
        except:
            pass

message_freq = []; #create a list of frequencies

for key, val in d.items():
    message_freq.append((val,key)); #add the values from your dictionary to your list

message_freq.sort(reverse=True) #reverse your values

print ('The email address with the most amount of messages is:', message_freq[0][1], ' with ', message_freq[0][0], 'messages') #print statement