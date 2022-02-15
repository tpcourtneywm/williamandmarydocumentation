#!/usr/bin/env python
# coding: utf-8

# In[24]:


from gurobipy import *


# In[25]:


m = Model("1")
m.ModelSense = GRB.MINIMIZE # tell gurobi to maximize the objective function. We want to maximize profit here
m.setParam('TimeLimit',7200)     #sets a time limit on execution to some number of seconds


# In[26]:


#set up decision variables
#x1 = Sunday
#x2 = Monday
#x3 = Tuesday
#x4 = Wednesday
#x5 = Thursday
#x6 = Friday
#x7 = Saturday
x1 = m.addVar(vtype=GRB.INTEGER,name='x1', lb=0.0)
x2 = m.addVar(vtype=GRB.INTEGER,name='x2', lb=0.0)
x3 = m.addVar(vtype=GRB.INTEGER,name='x3', lb=0.0)
x4 = m.addVar(vtype=GRB.INTEGER,name='x4', lb=0.0)
x5 = m.addVar(vtype=GRB.INTEGER,name='x5', lb=0.0)
x6 = m.addVar(vtype=GRB.INTEGER,name='x6', lb=0.0)
x7 = m.addVar(vtype=GRB.INTEGER,name='x7', lb=0.0)
m.update()


# In[27]:


#set up constraints
m.addConstr(x1+x4+x5+x6+x7, GRB.GREATER_EQUAL,8, "Sunday")
m.addConstr(x1+x2+x5+x6+x7, GRB.GREATER_EQUAL,6, "Monday")
m.addConstr(x1+x2+x3+x6+x7, GRB.GREATER_EQUAL,5, "Tuesday")
m.addConstr(x1+x2+x3+x4+x7, GRB.GREATER_EQUAL,4, "Wednesday")
m.addConstr(x1+x2+x3+x4+x5, GRB.GREATER_EQUAL,6, "Thursday")
m.addConstr(x2+x3+x4+x5+x6, GRB.GREATER_EQUAL,7, "Friday")
m.addConstr(x3+x4+x5+x6+x7, GRB.GREATER_EQUAL,9, "Saturday")


# In[28]:


#set objective function
m.setObjective(x1+x2+x3+x4+x5+x6+x7,GRB.MINIMIZE)
m.update()


# In[29]:


m.optimize()


# In[50]:


for var in m.getVars():
    print ("On day %s, %s, lifeguards should begin their shift." % (var.varName, var.x))
    optimalvalue = str(var.x)
#how do I get to pull just the optimal values from this print?


# In[45]:


type(optimalvalue)


# In[46]:


optimalvalue


# In[ ]:




