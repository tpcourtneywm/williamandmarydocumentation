#!/usr/bin/env python
# coding: utf-8

# In[2]:


from gurobipy import *


# In[10]:


m = Model("3")
m.ModelSense = GRB.MINIMIZE # tell gurobi to maximize the objective function. We want to maximize profit here
m.setParam('TimeLimit',7200)     #sets a time limit on execution to some number of seconds


# In[11]:


#set up decision variables
#x1 = savings account
#x2 = Cert. of Deposit
#x3 = Atlantic Lighting
#x4 = Arkansas REIT
#x5 = Bedrock Insurance annuity
#x6 = Norcal Mining Bond
#x7 = Minicomp Systems
#x8 Antony Hotels
x1 = m.addVar(vtype=GRB.CONTINUOUS,name='x1', lb=0.0)
x2 = m.addVar(vtype=GRB.CONTINUOUS,name='x2', lb=0.0)
x3 = m.addVar(vtype=GRB.CONTINUOUS,name='x3', lb=0.0)
x4 = m.addVar(vtype=GRB.CONTINUOUS,name='x4', lb=0.0)
x5 = m.addVar(vtype=GRB.CONTINUOUS,name='x5', lb=0.0)
x6 = m.addVar(vtype=GRB.CONTINUOUS,name='x6', lb=0.0)
x7 = m.addVar(vtype=GRB.CONTINUOUS,name='x7', lb=0.0)
x8 = m.addVar(vtype=GRB.CONTINUOUS,name='x8', lb=0.0)
m.update()


# In[14]:


#set up constraints
m.addConstr(x1+x2+x3+x4+x5+x6+x7+x8, GRB.EQUAL,100000, "Total")
m.addConstr(.04*x1+.052*x2+.071*x3+.1*x4+.082*x5+.065*x6+.2*x7+.125*x8, GRB.GREATER_EQUAL,7500, "Return")
m.addConstr(x1+x2+x5+x7, GRB.GREATER_EQUAL,50000, "A-Rated")
m.addConstr(x1+x3+x4+x7+x8, GRB.GREATER_EQUAL,40000, "Liquid")
m.addConstr(x1+x2, GRB.LESS_EQUAL,30000, "Savings/CD")
m.addConstr(x1+x2+x3+x4+x5+x6+x7+x8, GRB.GREATER_EQUAL,0, "more than zero")


# In[15]:


#set objective function
m.setObjective(25*x3+30*x4+20*x5+15*x6+65*x7+40*x8,GRB.MINIMIZE)
m.update()


# In[16]:


m.optimize()


# In[19]:


for var in m.getVars():
    print ("In investment  %s, I would invest = %s, in dollars" % (var.varName, var.x,))
    optimalvalue = str(var.x)
#how do I get to pull just the optimal values from this print?


# In[45]:


type(optimalvalue)


# In[46]:


optimalvalue


# In[ ]:




