#!/bin/bash
# testdiv.sh: Checks divisibility, validates input, and handles division by zero.

# Function to check if the input is an integer
function checkint {
    if [[ "$1" =~ ^-?[0-9]+$ ]]; then
        if [ "$1" -eq 0 ]; then
            echo "$1 is zero."
        else
            if [ $1 -lt 0 ]; then
                echo "$1 is negative."
            else
                echo "$1 is positive."
            fi
        fi
    else
        echo "$1 is not an integer" >&2
        exit 1
    fi
}

# Read inputs from the user
read -p "Enter an integer: " INT
read -p "Enter the divisor: " DIV

# Check both inputs
checkint "${INT}"
checkint "${DIV}"

# Prevent division by zero
(( DIV == 0 )) && echo "Cannot divide by zero!" && exit 2

# Check divisibility
REMAIN=$(( INT % DIV ))
if [ ${REMAIN} -eq 0 ]; then
    echo "${INT} is divisible by ${DIV}."
else
    echo "${INT} is not divisible by ${DIV}."
fi
