#!/usr/bin/env python
# coding: utf-8

# In[295]:


from gurobipy import *


# In[321]:


m = Model("4")
m.ModelSense = GRB.MAXIMIZE # tell gurobi to maximize the objective function. We want to maximize profit here
m.setParam('TimeLimit',7200)     #sets a time limit on execution to some number of seconds


# In[322]:


dvars = []
for i in range(4):
    dvars.append(m.addVar(vtype=GRB.CONTINUOUS, name = "o" + str(i), lb = 0.0))
m.update()


# In[323]:


greqsum = 8 * (dvars[0] + dvars[1])
horeqsum = 6 * (dvars[2] + dvars[3])


# In[324]:


m.addConstr(dvars[0] + dvars[2], GRB.LESS_EQUAL, 5000, "available crude oil 1")
m.addConstr(dvars[1] + dvars[3], GRB.LESS_EQUAL, 10000, "available crude oil 2")
m.addConstr(5 * dvars[1] + 10 * dvars[0] , GRB.GREATER_EQUAL, greqsum, "Quality Constraint- Gas")
m.addConstr(5 * dvars[3] + 10 * dvars[2], GRB.GREATER_EQUAL, horeqsum, "Quality Constraint- Heating Oil")

m.update()



# In[325]:


m.setObjective(((dvars[0] + dvars[1]) * 75) + ((dvars[2] + dvars[3]) * 60), GRB.MAXIMIZE)
m.ModelSense = GRB.MAXIMIZE
m.update


# In[326]:


m.optimize()


# In[329]:


for var in m.getVars():
    print("Chandler Blending should blend %s barrels of %s" % (var.x, var.varName))


# In[320]:


prices = [40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
#cleaned up indexing and parenthesis
revenue = []
for i in range(len(prices)): 
    m.setObjective(((dvars[0] + dvars[1]) * prices[i] + ((dvars[2] + dvars[3]) * 60)), GRB.MAXIMIZE)
    m.update()
    m.optimize()
    revenue.append(m.objVal)
print(revenue)


# In[331]:


plt.plot(prices, revenue)


# In[ ]:





# In[ ]:




