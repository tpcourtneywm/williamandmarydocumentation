# -*- coding: utf-8 -*-
"""
Created on Mon Oct  4 22:53:11 2021

@author: thoma
"""
import pandas as pd #import pandas
import matplotlib.pyplot as plt   #import matplotlib

df = pd.read_csv("buad5802-m6-python-assignment-data-file.csv")#read in file as a pandas dataframe
month  = df ['Month#'].tolist()#convert the month values to a list
bathsoap   = df ['Bath_Soap'].tolist() #convert variable to list
facewash   = df ['Face_Wash'].tolist() #convert variable to list

f,plot = plt.subplots(2, sharex=True) #set it to two plots
plot[0].plot(month, bathsoap) #plot bathsoap
plot[0].set_title('Bathing Soap') #title bath soap
plot[1].plot(month, facewash) #plot facewash
plot[1].set_title('Face Wash') #title facewash

plt.xlabel('Month Number') #label x axis
plt.ylabel('Units Sold') #label y axis
plt.show() #print plot


