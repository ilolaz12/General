#!/bin/bash
# Script to demonstrate and test special variables in Bash

# Positional Parameters
echo "Script name (\$0) = $0"
echo "First argument (\$1) = $1"
echo "Second argument (\$2) = $2"
echo "Third argument (\$3) = $3"
echo "Fourth argument (\$4) = $4"
echo "Number of arguments (\$#) = $#"

# All Arguments
echo "All arguments as a single string (\$*) = \"$*\""
echo "All arguments as an array (\$@) = \"$@\""

# Process Information
echo "Process ID of this script (\$$) = $$"
echo "Exit status of the last command (\$?) = $?"
echo "Process ID of the last background command (\$!) = $!"

# Check if any arguments were passed
if [ $# -eq 0 ]; then
    echo "No arguments were provided."
else
    echo "Arguments were provided."
fi

# Loop through all arguments
echo "Looping through arguments using \$@:"
for arg in "$@"; do
    echo "$arg"
done

echo "Looping through arguments using \$*:"
for arg in "$*"; do
    echo "$arg"
done

# End of script
