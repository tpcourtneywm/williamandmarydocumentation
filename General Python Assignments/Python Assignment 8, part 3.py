# -*- coding: utf-8 -*-
"""
Created on Mon Oct  4 22:37:21 2021

@author: thoma
"""
import pandas as pd #import pandas
import matplotlib.pyplot as plt   #import matplotlib

df = pd.read_csv("buad5802-m6-python-assignment-data-file.csv")#read in file as a pandas dataframe
month  = df ['Month#'].tolist()#convert the month values to a list
facecream   = df ['Face_Cream'].tolist() #convert variable to list
facewash   = df ['Face_Wash'].tolist() #convert variable to list
toothpaste = df ['Toothpaste'].tolist() #convert variable to list
bathsoap   = df ['Bath_Soap'].tolist() #convert variable to list
shampoo  = df ['Shampoo'].tolist() #convert variable to list
moisturizer = df ['Moisturizer'].tolist() #convert variable to list

plt.plot(month, facecream,   label = 'Face Cream') #plot variable
plt.plot(month, facewash,   label = 'Face Wash') #plot variable
plt.plot(month, toothpaste, label = 'ToothPaste') #plot variable
plt.plot(month, bathsoap, label = 'Bath Soap') #plot variable
plt.plot(month, shampoo, label = 'Shampoo') #plot variable
plt.plot(month, moisturizer, label = 'Moisturizer') #plot variable

plt.xlabel('Month Number') #label x axis
plt.ylabel('Units Sold') #label y axis
plt.legend() #add a legend
plt.show() #print the plot