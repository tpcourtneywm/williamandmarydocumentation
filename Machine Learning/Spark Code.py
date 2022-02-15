# -*- coding: utf-8 -*-
"""
Created on Thu Apr  1 20:14:32 2021

@author: thoma
"""

from pyspark import SparkConf, SparkContext #boilerplate information

conf = SparkConf().setMaster("local").setAppName("MaxTemperatures")
sc = SparkContext(conf = conf)

def parseLine(line): #bring in the fields from the CSV and give the fields names
    fields = line.split(',')
    College = fields[0]
    Status = fields[1]
    Apps = float(fields[2]) #switch numeric fields from string to floats to be able to calculate them
    Accept = float(fields[3])
    Enroll = float(fields[4])
    Grad_Rate = float(fields[18])
    Status=Status.replace("Yes", "Private") #replace 'yes' with private to identify the difference between public and private schools
    Status=Status.replace("No", "Public") #replace 'no' with public to identify the difference between public and private schools
    return (College, Status, Apps, Accept, Enroll, Grad_Rate) #bring all the fields in


lines = sc.textFile("buad5132-m5-individual-data-set.csv") #get data
parsedLines = lines.map(parseLine) #parse the lines
#PART 1
acceptance_rate_data = parsedLines.map(lambda x: (x[1], (x[3], x[2]))) #pull in school status, number of acceptances and the number of applications
values = acceptance_rate_data.reduceByKey(lambda x, y: (x[0]+y[0],x[1]+y[1])) #this returns the sum of acceptances and applications by public and private schools
results = values.collect() #collects those values
for result in results:
    print(result[0],result[1][0]/result[1][1]) #prints public or private and divides the acceptance by the applications to return the acceptance rate

#PART 2
applicants = parsedLines.filter(lambda x: x[2]>10000) #return schools who had more than 10,000 applications
grad_rate_values = applicants.map(lambda x: (x[5], x[0])) #get the grad rate and the school name when schools had more than 10K apps
sorted_grad_rate = grad_rate_values.sortByKey(False) #sort by the grad rate
results = sorted_grad_rate.collect() #collect the results
for result in results:
    print(result) #print

#PART 3
grad_rate = parsedLines.filter(lambda x: x[5]>70.0) #filter to get only schools with a 70% grad rate
enrollment_rate_values = grad_rate.map(lambda x: (x[4], x[0], x[5])) #grab the enroll, school name and grad rate
sorted_enrollment_rate = enrollment_rate_values.sortByKey(False) #sort by enroll
topten = sorted_enrollment_rate.take(10) #grab the top ten
#results = topten.collect()
for result in topten:
    print(result)
    
#!spark-submit Homework_4_11.py
#suggestions, work out sudo code for how you are going to go about this
#

