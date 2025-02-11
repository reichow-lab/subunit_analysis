#!/bin/bash

#Ask for the CSV file to analyze
read -e -p "Enter the path to the CSV file: " csv_file

# Check if the file exists
if [ ! -f "$csv_file" ]; then
    echo "File does not exist. Exiting."
    exit 1
fi

# Extract the specified column from the CSV and calculate frequency
awk -F',' -v col="3" 'NR==1 { print $col } NR>1 { print $col }' "$csv_file" | sort | uniq -c > frequency_analysis.csv

# Determine the frequency of column 1 from the analysis and sort it
awk '{ print $1 }' frequency_analysis.csv | sort | uniq -c > frequency_results.csv

echo "Results saved to frequency_results.csv"
