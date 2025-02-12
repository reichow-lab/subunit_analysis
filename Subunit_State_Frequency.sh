#!/bin/bash

#1 Ask for the CSV file to analyze
read -e -p "Enter a .csv file of interest: " csv_file

#2 Check if the file exists
if [ ! -f "$csv_file" ]; then
    echo "File does not exist. Exiting."
    exit 1
fi

#3 Extract the specified column from the CSV and calculate frequency (silent processing)
awk -F',' -v col="3" 'NR>1 { print $col }' "$csv_file" | sort | uniq -c > /dev/null

#4 Determine the frequency of column 1 from the analysis, sort it, and print it
echo -e "\nSubunit Frequency Results:"
awk -F',' -v col="3" 'NR>1 { print $col }' "$csv_file" | sort | uniq -c | awk '{ print $1 }' | sort | uniq -c
