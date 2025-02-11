#!/bin/bash

# Step 1: Ask for the CSV file to analyze
read -p "Enter the name of the CSV file you want to analyze: " filename

# Check if the file exists
if [ ! -f "$filename" ]; then
    echo "File not found!"
    exit 1
fi

# Step 2: Create new CSV files
touch HC1_particles.csv
touch HC2_particles.csv

# Step 3: Read the CSV file and copy rows based on the values in the first 3 columns
while IFS=',' read -r col1 col2 col3 _; do
    if [[ "$col2" == 0 || "$col2" == 1 || "$col2" == 5 || "$col2" == 7 || "$col2" == 10 || "$col2" == 11 ]]; then
        echo "$col1,$col2,$col3" >> HC1_particles.csv
    elif [[ "$col2" == 2 || "$col2" == 3 || "$col2" == 4 || "$col2" == 6 || "$col2" == 8 || "$col2" == 9 ]]; then
        echo "$col1,$col2,$col3" >> HC2_particles.csv
    fi
done < "$filename"

echo "Analysis complete. Results saved in HC1_particles.csv and HC2_particles.csv"
