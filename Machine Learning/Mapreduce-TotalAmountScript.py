"""
Created on Mon Mar 22 18:37:26 2021

@author: thoma
"""

from mrjob.job import MRJob #import MRJob

class Total(MRJob): #run the script

    def mapper(self, _, line): #run the mapper to separate the different IDs
        (CustomerID, ItemID, AmountSpent) = line.split(',')
        yield CustomerID, float(AmountSpent) #only pull the customer ID and the amount spent
        
    def reducer(self, CustomerID, AmountSpent):
        yield CustomerID, sum(AmountSpent) #sum the total amount spent per customer

if __name__ == '__main__':
    Total.run()
    
#!python TotalAmountScript.py buad5132-m3-individual-dataset.csv > TotalAmount.txt