#!/usr/bin/env python
# coding: utf-8

# In[3]:


import requests
from lxml import objectify

from xml.etree import ElementTree as et

parameter = 'Average Temperature'
state = 'Virginia'
month = 'August'
year='2018'

url="https://www.ncdc.noaa.gov/cag/statewide/rankings"
Virginia = '44'
Average_Temperature = 'tavg'
August = '08'



# In[4]:


query_template="%s/%s-%s-%s%s.xml"
URL4 = query_template % (url, Virginia,Average_Temperature,year,August )

# Apply query and read data
response = requests.get(URL4).content
root=objectify.fromstring(response)


# In[5]:


value=root.data[4].value #4 because python lists begin at zero
mean=root.data[4].mean
departure=root.data[4].departure
lowRank=root.data[4].lowRank
highRank=root.data[4].highRank

# Assign my W&M user name for the print out
myname="tpcourtney"

# Print out values as per assignment

print(myname)
print(value)
print(mean)
print(departure)
print(lowRank)
print(highRank)


# In[ ]:




