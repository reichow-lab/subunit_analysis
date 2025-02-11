# subunit_analysis

#READ_ME: Guide for using the Subunit_State_Frequency.sh, Gap_Junction_Splitter.sh and Hemichannel Arrangement.sh bash scripts

#These scripts rely on analyzing a .csv file with three columns using metadata extracted from a .cs file generated from CryoSPARC in a specific order: uid, sym_expand/idx and sym_expand/src_uid. 

#The intended input for these scripts is metadata that was extracted from a .cs file from gap junction particles that were symmetry expanded and signal subtracted to obtain a connexin monomer and that have gone through 3D classification. Each class’s .cs will need to have its metadata extracted to a .csv file and analyzed by the scripts  individually.


########################################################################


#Generating the initial .csv file containing metadata in columns in the following order
```
uid, sym_expand/idx, sym_expand/src_uid
```
#Load CryoSPARC’s interactive python shell
```
cryosparcm icli
```
#Import numpy
```
import numpy as n
```
#Import pandas
```
import pandas as pd
```
#Naviagate to the directory with the .cs file of interest and load the .cs file
```
v = n.load('your_cryosparc_file.cs')
```
#Reshape columns of interest and give them identifiable names
```
uid = v['uid'].reshape(-1,1)
idx = v['sym_expand/idx'].reshape(-1,1)
src_uid = v['sym_expand/src_uid'].reshape(-1,1)
 ```
#Combine the columns
```
combined_all_classes = n.concatenate((uid, idx, src_uid), 1)
```
#convert numpy array to panda DataFrame
```
df = pd.DataFrame(combined_all_classes)
```
#Convert DataFrame to csv file type
```
df.to_csv('/full/direct/path/to/where/you/want/the/csv_file.csv', index=False)
```
#Exit the cryosparc python shell
```
Crtl + d
```
#By the end of this step a properly formatted .csv file should have been generated containing all the extracted metadata from the particles in the .cs file.

#Example lines of properly formatted .csv file
```
#1,2,3
$562587597795685328,6,1954348058698591563
$886761612450511318,8,1954348058698591563
$381211677249440013,9,1954348058698591563
$3163205268768835278,11,1954348058698591563
$11953291252703823103,1,3473960013799703934
```
#It is essential to confirm that the .csv file is properly formatted before continuing by visually inspecting the file, the first line of the .csv file may need to be deleted if it has no relevant metadata (e.g., 1,2,3) like the example does 

#.csv files of classes of similar states can be combined using concatenate commands at this point if necessary
```
cat class1_state_of_interest.csv class2_state_of_interest.csv > combined_classes.csv
```

########################################################################


#Using the Subunit_State_Frequency.sh script
#this script works on both gap junction and hemichannel (see below) .csv files

#Load the script
```
./ Subunit_State_Frequency.sh
```
#Give it the path to a .csv file of interest

#Check the frequency_results.csv file for the results

#Example results below; column 1 = number of occurrences and column 2 = number of subunits in the same gap junction or hemichannel
```
$    15 1
$ 14765 10
$  6269 11
$  1312 12
$    63 2
$   407 3
$  1549 4
$  4411 5
$ 10023 6
$ 17053 7
$ 22406 8
$ 21736 9
```

#In the example above, 6269 parent gap junction particles have 11 copies of the input state monomer particle in them.


########################################################################


#Using the Gap_Junction_Splitter.sh script
#This script is given the initial .csv file generated above and splits the gap junction metadata into hemichannels using their sym_expand/idx ID. 

#Load the script
```
./Gap_Junction_Splitter.sh
```

#Give it the path to a .csv file of interest

#The script should output two new .csv files containing the input gap junctions metadata split into its respective hemichannels named HC1_particles.csv and HC2_particles.csv

#The HC1_particles.csv and HC2_particles.csv files can be used with the Subunit_State_Frequency.sh and Hemichannel_Arrangement.sh scripts


########################################################################


#Using the Hemichannel_Arrangement.sh script
#This script only works for hemichannel metadata. Use the Gap_Junction_Splitter.sh script HC1_particles.csv and HC2_particles.csv output for this script
#This script takes much longer to run than the other scripts

#Load the script
```
$./ Hemichannel_Arrangement.sh
```
#Give it the path to a .csv file of interest

#The script will report the results

