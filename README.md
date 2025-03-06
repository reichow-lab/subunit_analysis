# subunit_analysis

READ_ME: Guide for using the Subunit_State_Frequency.sh, Gap_Junction_Splitter.sh and Hemichannel Arrangement.sh bash scripts

These scripts rely on analyzing a .csv file with three columns using metadata extracted from a .cs file generated from CryoSPARC in a specific order: uid, sym_expand/idx and sym_expand/src_uid. 

The intended input for these scripts is metadata that was extracted from a .cs file from gap junction particles that were symmetry expanded and signal subtracted to obtain a connexin monomer and that have gone through 3D classification. Each class’s .cs will need to have its metadata extracted to a .csv file and analyzed by the scripts  individually.


########################################################################


Generating the initial .csv file containing metadata in columns in the following order

Step # 1: Create a directory for the scripts to live in and to do the dataprocessing

Step # 2: Put the scripts into this new directory and give them permissions
```
chmod +x script_name.sh
```

Step # 3: Using the cryosparc GUI export the 3D classification job of interest

Step # 4: In a terminal window, navigate to the export directory of your cryosparc project and copy each class's exported .cs file to your script data processing directory created in Step #1. 
```
 ../exports/jobs/J335_class_3D/J335_particles_class_1/J335_particles_class_1_exported.cs
```

Step # 5: Use the Meta_Extraction.py to extract the metadata from the exported .cs file from a class of interest and generate a .csv file
```
python3 Metadata_Extraction.py
```

By the end of this step a properly formatted .csv file should have been generated containing all the extracted metadata from the particles in the .cs file.

Example lines of properly formatted .csv file
```
$562587597795685328,6,1954348058698591563
$886761612450511318,8,1954348058698591563
$381211677249440013,9,1954348058698591563
$3163205268768835278,11,1954348058698591563
$11953291252703823103,1,3473960013799703934
```
Step # 6: It is essential to confirm that the .csv file is properly formatted before continuing by visually inspecting the file. 

Step # 7: .csv files of classes of similar states can be combined using concatenate commands at this point if necessary
```
cat class1_state_of_interest.csv class2_state_of_interest.csv > combined_classes.csv
```

########################################################################


Using the Subunit_State_Frequency.sh script

This script works on both gap junction and hemichannel (see below) .csv files

Step #8: Load the script
```
./Subunit_State_Frequency.sh
```
Step #9: Enter a .csv file of interest

The script will report the results

Example results below; column 1 = number of occurrences and column 2 = number of subunits in the same gap junction or hemichannel
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

In the example above, 6269 parent gap junction particles have 11 copies of the input state monomer particle in them.


########################################################################


Using the Gap_Junction_Splitter.sh script

This script is given the initial metadata.csv file generated in step #2 and splits the gap junction metadata into hemichannels using their [sym_expand/idx ID](https://discuss.cryosparc.com/t/how-are-sym-expand-idx-ids-assigned-during-symmetry-expansion/13614/2). 

Step #10 Load the script
```
./Gap_Junction_Splitter.sh
```

Step #11: Enter a .csv file of interest

The script should output two new .csv files containing the input gap junctions metadata split into its respective hemichannels named HC1_particles.csv and HC2_particles.csv

The HC1_particles.csv and HC2_particles.csv files can be used with the Subunit_State_Frequency.sh and Hemichannel_Arrangement.sh scripts


########################################################################


Using the Hemichannel_Arrangement.sh script

This script only works for hemichannel metadata. Use the Gap_Junction_Splitter.sh's script HC1_particles.csv and HC2_particles.csv output for this script

This script takes much longer to run than the other scripts

Step #12: Load the script
```
./Hemichannel_Arrangement.sh
```
Step #13: Enter HC1_particles.csv or HC2_particles.csv

The script will report the results

