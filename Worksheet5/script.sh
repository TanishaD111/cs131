
lines=$(awk -F "," '$8 == "United States"' 'Global YouTube Statistics.csv')

# Iterate over each line and put every category in a separate file
IFS=$'\n'
for line in $lines; do
    category=$(echo "$line" | cut -d ',' -f 5)
    output_file="UnitedStates/${category}.txt"

    # Check if the line already exists in the file
    if grep "$line" "$output_file" >/dev/null 2>/dev/null; then
        continue
    fi

    # If line does not exist, append it to the file
    echo "$line" >> "$output_file"
done

categories=("Music" "Entertainment" "Gaming" "Comedy")

for category in "${categories[@]}"; do
    # Check if the category already exists in ws5.txt
    if grep "$category" ws5.txt >/dev/null 2>/dev/null; then
        continue
    fi
    
    # Get the word count for the corresponding text file if it does not exist
    wc -l "UnitedStates/$category.txt" >> ws5.txt
done

