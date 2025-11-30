#!/bin/bash
# callsum.sh: Calls sum.sh to compute the sum of two numbers.

# Read inputs
read -p "Enter the first number: " NUM1
read -p "Enter the second number: " NUM2

# Call sum.sh and capture the output
RESULT=$(bash sum.sh "${NUM1}" "${NUM2}")

# Check for errors
if [[ $? -eq 0 ]]; then
    echo "The sum of ${NUM1} and ${NUM2} is ${RESULT}."
else
    echo "Error occurred while summing the numbers."
    exit 1
fi
