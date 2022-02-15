# -*- coding: utf-8 -*-
"""
Created on Wed Sep  1 08:18:19 2021

@author: thoma
"""

how_many = int(input('How many total numbers would you like to get the average of: '))
#starts the program by asking how many numbers you want to take the average of
total = 0
#start your total sum at zero
for n in range(how_many):
    #start your function
    total_numbers = float(input('Enter a number : '))
    #create an input to get the number
    total += total_numbers
    #summing the total
average = float(total/how_many)
#get the average
print('The average of ', how_many, ' numbers is :', average)
#print the final total