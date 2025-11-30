#!/bin/bash
# file_info.sh - Script to display information about a file or directory

# Function to check if the provided argument is a file and count lines
count_file_lines() {
    local file="$1"
    # Use command substitution to count lines
    local lines=$(wc -l < "$file")
    echo "The file '$file' contains $lines lines."
}

# Function to check if the provided argument is a directory and count files and subdirectories
count_dir_contents() {
    local dir="$1"
    # Use command substitution to count files and directories
    local file_count=$(find "$dir" -type f | wc -l)
    local dir_count=$(find "$dir" -type d | wc -l)
    echo "The directory '$dir' contains $file_count files and $((dir_count - 1)) subdirectories."
}

# Main script logic

# Check that exactly one argument is provided
if [ "$#" -ne 1 ]; then
    echo "Error: You must enter exactly one argument (file or directory name)."
    exit 1
fi

# Assign the argument to a variable for easier reference
arg="$1"

# Check if the argument is a file
if [ -f "$arg" ]; then
    count_file_lines "$arg"

# Check if the argument is a directory
elif [ -d "$arg" ]; then
    count_dir_contents "$arg"

# If the argument is neither a file nor a directory
else
    echo "Error: '$arg' is not a valid file or directory."
    exit 1
fi

# Exit the script
exit 0
