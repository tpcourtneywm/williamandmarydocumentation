#!/usr/bin/env python
# coding: utf-8

# In[72]:


import requests
from bs4 import BeautifulSoup
import pandas as pd


html_path = 'http://publicinterestlegal.org/county-list/'

#url = 'https://en.wikipedia.org/wiki/List_of_countries_by_GDP_(nominal)'

headers = {'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36'}


html_doc = requests.get(html_path, headers=headers).content
soup = BeautifulSoup(html_doc, "lxml")
targeted_rows = soup.find_all('tr')


# In[73]:


#print(len(targeted_rows))
#print(type(targeted_rows),'\n')
counties= []
for row in targeted_rows:
    new_row = []
    for x in row.find_all('td'):
        new_row.append(x.text)
        
    counties.append(new_row)
counties=pd.DataFrame(counties)


# In[74]:

print('tpcourtney')
print(len(targeted_rows))
print(counties)


# In[ ]:




