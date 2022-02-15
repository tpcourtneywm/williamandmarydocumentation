# -*- coding: utf-8 -*-
"""
Created on Mon Oct  4 20:32:00 2021

@author: thoma
"""
import pandas as pd #import pandas
import matplotlib.pyplot as plt  #import matplotlib

df = pd.read_csv("buad5802-m6-python-assignment-data-file.csv")#read in file as a pandas dataframe
profit = df ['Profit'].tolist()#convert profit to a list
month  = df ['Month#'].tolist()#convert the month values to a list
plt.plot(month, profit) #plot values
plt.xlabel('Month Number') #label x axis
plt.ylabel('Total Profit') #label y axis
plt.show() #show plot