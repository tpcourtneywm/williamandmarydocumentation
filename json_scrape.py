#!/usr/bin/env python
# coding: utf-8

# In[151]:


import requests
from __future__ import division

search_url = 'https://buckets.peterbeshai.com/api/?player=201939&season=2015'

headerText = {"User-Agent": "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36"}
response = requests.get(search_url, headers=headerText)
root=response.json()
response = requests.get(search_url, headers=headerText)
json = response.json()
type(json)
i = 0


# In[152]:


json


# In[153]:


number_of_JS = []
for i in range (len(json)):
    if json[i]['ACTION_TYPE'] == ('Jump Shot'):
       number_of_JS.append(i)
number_of_JS_makes = []
for i in range (len(json)):
    if json[i]['ACTION_TYPE'] == ('Jump Shot') and json[i]['EVENT_TYPE'] == ('Made Shot'):
       number_of_JS_makes.append(i)


# In[155]:


print('tpcourtney')
print(len(number_of_JS))
print(len(number_of_JS_makes))
print("{:.0%}".format(len(number_of_JS_makes)/len(number_of_JS)))


# In[144]:





# In[145]:





# In[ ]:





# In[ ]:




