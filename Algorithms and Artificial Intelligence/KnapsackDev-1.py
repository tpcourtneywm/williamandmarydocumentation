# -*- coding: utf-8 -*-
"""
@author: tpcourtney
"""
# Determine start time
import time
start = time.time()

# Need itertools and combinations to form all combinations of items.
from itertools import combinations

def load_knapsack(supplies,backpack_size):
       
    
    items_to_pack = []   
    in_knapsack = 0.0
    current = 0.0            
               
      
    item_list = [[k,v,float(v[1])/v[0]] for k,v in supplies.items()]
    j = lambda x:x[2]
    item_list=sorted(item_list,key=j,reverse=True)
    
    item_keys = [item[0] for item in item_list]
   
    for i in range(len(item_keys)):
        if current <= backpack_size:
            pack_item = item_keys[i]
            current += supplies[pack_item][0]
            if current <= backpack_size:
                items_to_pack.append(pack_item)
                current += supplies[pack_item][0]
                in_knapsack += supplies[pack_item][1]
    return items_to_pack 
 
def anycomb(items):
    # Creates all possible combinations of items.
    return ( comb
             for r in range(1, len(items)+1)
             for comb in combinations(items, r)
             )
 
def totalvalue(comb):
    # Calculate the total value and check feasibility of a combination of items.
    totwt = totval = 0
    for item, wt, val in comb:
        totwt  += wt
        totval += val
    return (totval, -totwt) if totwt <= cap else (0, 0)


# Items a collection of = ((Item Name, Volume, Value), ...)

# Data Set 10:
items = (
    ("Item 1", 382745, 825594), ("Item 2", 799601, 1677009), ("Item 3", 909247, 1676628), ("Item 4", 729069, 1523970), ("Item 5", 467902, 943972), ("Item 6", 44328, 97426), ("Item 7", 34610, 69666), ("Item 8", 698150, 1296457), ("Item 9", 823460, 1679693), ("Item 10", 903959, 1902996), ("Item 11", 853665, 1844992), ("Item 12", 551830, 1049289), ("Item 13", 610856, 1252836), ("Item 14", 670702, 1319836), ("Item 15", 488960, 953277), ("Item 16", 951111, 2067538), ("Item 17", 323046, 675367), ("Item 18", 446298, 853655), ("Item 19", 931161, 1826027), ("Item 20", 31385, 65731), ("Item 21", 496951, 901489), ("Item 22", 264724, 577243), ("Item 23", 224916, 466257), ("Item 24", 169684, 369261),
    )
cap = 6404180

bagged = max( anycomb(items), key=totalvalue)

MyUsername = "Tpcourtney"
myNickname = "BaldGuy"

print(MyUsername)
print(myNickname)
print("Knapsack contains the following items\n  " +
      '\n  '.join(sorted(item for item,_,_ in bagged)))
val, wt = totalvalue(bagged)
print("For a total value of %i and a total volume of %i" % (val, -wt))

# Determine ending time
end = time.time()

# Print total time.
print("For a total time in seconds of ")
print(end - start)

MyUsername = "Tpcourtney"
myNickname = "BaldGuy"




