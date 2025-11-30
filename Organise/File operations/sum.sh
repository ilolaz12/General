#!/bin/bash
# sum.sh: Calculates the sum of two arguments.

# Validate arguments
if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <number1> <number2>"
    exit 1
fi

# Perform addition
SUM=$(( $1 + $2 ))
echo "${SUM}"
