# -*- coding: utf-8 -*-
"""
Created on Mon Mar 22 18:43:10 2021

@author: thoma
"""

from mrjob.job import MRJob
from mrjob.step import MRStep #import mr.job and MR.Step

class SortedCustomerSpending(MRJob): #sort the steps 
    def steps(self):
        return [
            MRStep(mapper=self.mapper,
                   reducer=self.reducer),
            MRStep(mapper=self.mapper_sort,
                   reducer = self.output)
        ]
        
    def mapper(self, _, line):
        (CustomerID, ItemID, AmountSpent) = line.split(',')
        yield CustomerID, float(AmountSpent) #only pull the customer ID and the amount spent
        
    def reducer(self, CustomerID, AmountSpent):
        yield CustomerID, sum(AmountSpent) #sum the total amount spent per customer

    def mapper_sort(self, CustomerID, AmountSpent): #sort it
        yield '%04.02f'%float(AmountSpent), CustomerID

    def output(self, AmountSpent, CustomerIDs):
        for CustomerID in CustomerIDs:
            yield AmountSpent, CustomerID #output it

if __name__ == '__main__':
    SortedCustomerSpending.run()

# !python SortedScript.py buad5132-m3-individual-dataset.csv > SortedAmount.txt