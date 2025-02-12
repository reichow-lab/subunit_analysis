#!/usr/bin/env python3

#1 import numpy and pandas
import numpy as n
import pandas as pd

#2 Ask what .cs file is wanted for metadata extraction
cs_file = input("Enter the .cs file you want to load: ")

#3 loading .cs file of interest
v = n.load(cs_file)

#4 Reshaped metadata and give each column a unique name
uid = v['uid'].reshape(-1,1)
idx = v['sym_expand/idx'].reshape(-1,1)
src_uid = v['sym_expand/src_uid'].reshape(-1,1)

#5 Combine columns
combined_all_classes = n.concatenate((uid, idx, src_uid), 1)

#6 Convert numpy array to panda DataFrame
df = pd.DataFrame(combined_all_classes)

#7 Convert DataFrame to .csv file
df.to_csv('metadata.csv', index=False)

#8 Remove the first line of the generated metadata.csv file
with open("metadata.csv", "r") as file:
    lines = file.readlines()

with open("metadata.csv", "w") as file:
    file.writelines(lines[1:])

#8 Quit python
exit()
