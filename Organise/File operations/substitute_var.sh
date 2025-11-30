#!/bin/bash
# var_sub.sh - Script to demonstrate Bash variable substitution examples

# Check if exactly three arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <string> <search_pattern> <replacement>"
    echo "Example: $0 JPG.JPG JPG jpg"
    exit 1
fi

# Assign arguments to variables for easier reference
input_string="$1"
search_pattern="$2"
replacement="$3"

# Demonstrate different types of Bash variable substitution
echo "Original string: $input_string"

# Substitution: Replace the first occurrence of a pattern
echo "Replace first occurrence of '$search_pattern' with '$replacement':"
echo "${input_string/$search_pattern/$replacement}"

# Substitution: Replace all occurrences of a pattern
echo "Replace all occurrences of '$search_pattern' with '$replacement':"
echo "${input_string//$search_pattern/$replacement}"

# Substitution: Replace pattern only if it appears at the start of the string
echo "Replace pattern at the start of the string (if '$search_pattern' is at the start):"
echo "${input_string/#$search_pattern/$replacement}"

# Substitution: Replace pattern only if it appears at the end of the string
echo "Replace pattern at the end of the string (if '$search_pattern' is at the end):"
echo "${input_string/%$search_pattern/$replacement}"

# Additional Substitution Examples
# Remove shortest match of a pattern from the beginning
echo "Remove shortest match of '$search_pattern' from the beginning:"
echo "${input_string#$search_pattern}"

# Remove longest match of a pattern from the beginning
echo "Remove longest match of '$search_pattern' from the beginning:"
echo "${input_string##$search_pattern}"

# Remove shortest match of a pattern from the end
echo "Remove shortest match of '$search_pattern' from the end:"
echo "${input_string%$search_pattern}"

# Remove longest match of a pattern from the end
echo "Remove longest match of '$search_pattern' from the end:"
echo "${input_string%%$search_pattern}"

# End of script
