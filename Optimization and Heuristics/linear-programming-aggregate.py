#!/usr/bin/env python
# coding: utf-8

# In[1]:


from gurobipy import *
# Create Model
m = Model('2')


# In[7]:


dvars = []
for i in range(6):
    dvars.append(m.addVar(vtype=GRB.CONTINUOUS, name = "r" + str(i), lb = 0.0))
for i in range(6):
    dvars.append(m.addVar(vtype=GRB.CONTINUOUS, name = "o" + str(i), lb = 0.0))
for i in range(5):
    dvars.append(m.addVar(vtype=GRB.CONTINUOUS, name = "i" + str(i), lb = 0.0))
m.update()


# In[8]:


m.addConstr(dvars[0], GRB.LESS_EQUAL, 160, "1reg")
m.addConstr(dvars[1], GRB.LESS_EQUAL, 160, "2reg")
m.addConstr(dvars[2], GRB.LESS_EQUAL, 160, "3reg")
m.addConstr(dvars[3], GRB.LESS_EQUAL, 160, "4reg")
m.addConstr(dvars[4], GRB.LESS_EQUAL, 160, "5reg")
m.addConstr(dvars[5], GRB.LESS_EQUAL, 160, "6reg")

m.addConstr(dvars[6], GRB.LESS_EQUAL, 50, "1ot")
m.addConstr(dvars[7], GRB.LESS_EQUAL, 50, "2ot")
m.addConstr(dvars[8], GRB.LESS_EQUAL, 50, "3ot")
m.addConstr(dvars[9], GRB.LESS_EQUAL, 50, "4ot")
m.addConstr(dvars[10], GRB.LESS_EQUAL, 50, "5ot")
m.addConstr(dvars[11], GRB.LESS_EQUAL, 50, "6ot")

m.addConstr(dvars[0] + dvars[6] - dvars[12], GRB.EQUAL, 105, "w1")
m.addConstr(dvars[1] + dvars[7] + dvars[12] - dvars[13], GRB.EQUAL, 170, "w2")
m.addConstr(dvars[2] + dvars[8] + dvars[13] - dvars[14], GRB.EQUAL, 230, "w3")
m.addConstr(dvars[3] + dvars[9] + dvars[14] - dvars[15], GRB.EQUAL, 180, "w4")
m.addConstr(dvars[4] + dvars[10] + dvars[15] - dvars[16], GRB.EQUAL, 150, "w5")
m.addConstr(dvars[5] + dvars[11] + dvars[16], GRB.EQUAL, 250, "w6")

m.update()


# In[9]:


#Objective Function
# 190(r1 + r2 + r3 + r4 + r5 + r6) + 260(o1 + o2 + o3 + o4 + o5 + o6) + 10(i1 + i2 + i3 + i4 + i5)

m.setObjective(190 * (dvars[0] + dvars[1] + dvars[2] + dvars[3] + dvars[4] + dvars[5]) + 260 * (dvars[6]+ dvars[7] + dvars[8] + dvars[9] + dvars[10] + dvars[11]) + 10* (dvars[12] + dvars[13] + dvars[14] + dvars[15] + dvars[16]), GRB.MINIMIZE)

m.ModelSense = GRB.MINIMIZE

m.update()


# In[10]:


m.optimize()


# In[22]:


for var in m.getVars():
    print("Our production or capacity for variable %s, is %s" % (var.varName, round(var.x, 2)))


# In[ ]:




