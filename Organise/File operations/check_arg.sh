#!/bin/bash
# arg_check.sh - Script to validate arguments based on conditions
# Argument 1 must be a directory; argument 2 (if provided) must be a regular file

# Check if there are no arguments or more than two arguments
if [ "$#" -eq 0 ] || [ "$#" -gt 2 ]; then
    echo "Error: You must provide 1 or 2 arguments."
    echo "Usage: $0 <directory> [file]"
    exit 1

# Check if there is one argument and it is not a directory
elif [ "$#" -eq 1 ] && [ ! -d "$1" ]; then
    echo "Error: The argument must be a valid directory."
    exit 1

# Check if there are two arguments and the first is not a directory or the second is not a file
elif [ "$#" -eq 2 ] && { [ ! -d "$1" ] || [ ! -f "$2" ]; }; then
    echo "Error: The first argument must be a directory, and the second must be an ordinary file."
    exit 1
fi

# Success message if all conditions are met
echo "Success: You provided valid arguments."
exit 0
