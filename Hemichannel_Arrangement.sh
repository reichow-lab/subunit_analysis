#!/bin/bash

# Step 1: Ask for the CSV file
read -p "Enter the name of the CSV file you want to analyze: " csv_file

# Step 2: Determine frequency of column 3 and find corresponding values in column 2
awk -F ',' '{freq[$3]++; values[$3] = values[$3] $2 ","} END {for (id in freq) print id, freq[id], values[id]}' "$csv_file" > frequency.csv

# Step 3: Reorder the comma-separated values in column three to fit the specified sequence and format
awk 'BEGIN {
    # Define the desired sequence
    sequence="0,1,5,7,11,10,9,2,8,6,4,3"
    # Split the sequence into an array
    split(sequence, seq, ",")
}
{
    # Store the values and frequencies
    freq[$1] = $2
    split($3, values, ",")
    delete reordered_values
    # Reorder the values according to the sequence
    for (i=1; i<=length(seq); i++) {
        for (j=1; j<=length(values); j++) {
            if (seq[i] == values[j]) {
                reordered_values[i] = values[j]
                break
            }
        }
    }
    # Reconstruct the reordered string
    reordered_string = ""
    for (k=1; k<=length(seq); k++) {
        if (reordered_values[k] != "") {
            if (reordered_string != "")
                reordered_string = reordered_string "," reordered_values[k]
            else
                reordered_string = reordered_values[k]
        }
    }
    print $1, $2, reordered_string
}' frequency.csv > frequency_reordered.csv

# Step 4: Replace the original frequency.csv with the reordered one
mv frequency_reordered.csv frequency.csv

#echo "Analysis complete. Check 'frequency.csv' for results."


# Step 3: Analyze the frequency.csv file
# Initialize counters for each category
one_away_count=0
two_away_count=0
opposite_count=0
all_three_touching_count=0
two_touching_one_away_count=0
two_touching_two_away_count=0
every_other_count=0
all_four_together_count=0
three_touching_one_away_count=0
doublets_split_by_one_count=0

while IFS=' ' read -r id freq values; do
    # Step 4: Check if column 2 equals 2
    if [ "$freq" -eq 2 ]; then
        # Step 5: Check for "One away"
        if grep -qE '(^|,)(0,10|0,1|1,5|5,7|7,11|11,10|9,3|9,2|2,8|8,6|6,4|4,3)(,|$)' <<< "$values"; then
            one_away_count=$((one_away_count+1))
        fi
        # Step 6: Check for "Two away"
        if grep -qE '(^|,)(0,5|0,11|1,7|1,10|5,11|7,10|9,8|9,4|2,6|2,3|8,4|6,3)(,|$)' <<< "$values"; then
            two_away_count=$((two_away_count+1))
        fi
        # Step 7: Check for "Opposite sides"
        if grep -qE '(^|,)(0,7|1,11|5,10|9,6|2,4|8,3)(,|$)' <<< "$values"; then
            opposite_count=$((opposite_count+1))
        fi
    # Step 8: Check if column 2 equals 3
    elif [ "$freq" -eq 3 ]; then
        # Step 9: Check for "All three touching"
        if grep -qE '(^|,)(0,1,5|1,5,7|5,7,11|7,11,10|0,11,10|0,1,10|9,2,8|2,8,6|8,6,4|6,4,3|9,4,3|9,2,3)(,|$)' <<< "$values"; then
            all_three_touching_count=$((all_three_touching_count+1))
        fi
        # Step 10: Check for "Two touching, One away"
        if grep -qE '(^|,)(0,1,7|1,5,11|5,7,10|0,7,11|1,11,10|0,5,10|9,2,6|2,8,4|8,6,3|9,6,4|2,4,3|9,8,3)(,|$)' <<< "$values"; then
            two_touching_one_away_count=$((two_touching_one_away_count+1))
        fi
        # Step 11: Check for "Two touching, Two away"
        if grep -qE '(^|,)(0,1,11|1,5,10|0,5,7|1,7,11|5,11,10|0,7,10|9,2,4|2,8,3|9,8,6|2,6,4|8,4,3|9,6,3)(,|$)' <<< "$values"; then
            two_touching_two_away_count=$((two_touching_two_away_count+1))
        fi
        # Step 12: Check for "Every other"
        if grep -qE '(^|,)(0,5,11|1,7,10|0,5,11|1,7,10|1,7,10|9,8,4|2,6,3|9,8,4|2,6,3|9,8,4|2,6,3)(,|$)' <<< "$values"; then
            every_other_count=$((every_other_count+1))
        fi
    # Step 13: Check if column 2 equals 4
    elif [ "$freq" -eq 4 ]; then
        # Step 14: Check for "All four together"
        if grep -qE '(^|,)(0,1,5,7|1,5,7,11|5,7,11,10|0,7,11,10|0,1,11,10|0,1,5,10|9,2,8,6|2,8,6,4|8,6,4,3|9,6,4,3|9,2,4,3|9,2,8,3)(,|$)' <<< "$values"; then
            all_four_together_count=$((all_four_together_count+1))
        fi
        # Step 15: Check for "Three touching, One away"
        if grep -qE '(^|,)(0,1,5,11|1,5,7,10|0,5,7,11|1,7,11,10|0,5,11,10|0,1,7,10|9,2,8,4|2,8,6,3|9,8,6,4|2,6,4,3|9,8,4,3|9,2,6,3)(,|$)' <<< "$values"; then
            three_touching_one_away_count=$((three_touching_one_away_count+1))
        fi
        # Step 16: Check for "Doublets split by one"
        if grep -qE '(^|,)(0,1,7,11|1,5,11,10|0,5,7,10|0,1,7,11|1,5,11,10|0,5,7,10|9,2,6,4|2,8,4,3|9,8,6,3|9,2,6,4|2,8,4,3|9,8,6,3)(,|$)' <<< "$values"; then
            doublets_split_by_one_count=$((doublets_split_by_one_count+1))
        fi
    fi
done < frequency.csv

# Print the counts
echo "Hemichannel Arrangement Results:"
echo "One away count: $one_away_count"
echo "Two away count: $two_away_count"
echo "Opposite count: $opposite_count"
echo "All three touching count: $all_three_touching_count"
echo "Two touching, One away count: $two_touching_one_away_count"
echo "Two touching, Two away count: $two_touching_two_away_count"
echo "Every other count: $every_other_count"
echo "All four together count: $all_four_together_count"
echo "Three touching, One away count: $three_touching_one_away_count"
echo "Doublets split by one count: $doublets_split_by_one_count"

echo -e "



                                Key:    X = state of interest, 0 = other state(s)


                         One away                    Two away                     Opposite
                            X                           X                            X
                          0   X                       0   0                        0   0 
                          0   0                       0   X                        0   0 
                            0                           0                            X


        All three touching       Two touching, One away       Two touching, two away         Every other
                X                           X                            X                        X
              0   X                       0   X                        0   X                    0   0 
              0   X                       0   0                        X   0                    X   X
                0                           X                            0                        0


                    All four together       Three touching, One away       Doublets split by one 
                            0                           0                            0
                          X   0                       X   X                        X   X 
                          X   X                       X   0                        X   X
                            X                           X                            0




 "
