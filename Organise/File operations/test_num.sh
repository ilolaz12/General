#!/bin/bash
# test-number: evaluate the value of a number (integer or floating-point)

NUMBER=$1

# Regular expression for integer or floating-point numbers
if [[ "${NUMBER}" =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then
    if (( $(echo "${NUMBER} == 0" | bc -l) )); then
        echo "${NUMBER} is zero."
    else
        if (( $(echo "${NUMBER} < 0" | bc -l) )); then
            echo "${NUMBER} is negative."
        else
            echo "${NUMBER} is positive."
        fi
    fi
else
    echo "${NUMBER} is not a valid number" >&2; exit 1
fi
