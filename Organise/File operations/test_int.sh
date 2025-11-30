#!/bin/bash
# test-integer: evaluate the value of an integer
INT=$1
if [[ "${INT}" =~ ^-?[0-9]+$ ]]; then
    if [ "${INT}" -eq 0 ]; then
        echo "${INT} is zero."
    else
        if [ ${INT} -lt 0 ]; then
            echo "${INT} is negative"
        else
            echo "${INT} is positive"
        fi
    fi
else
    echo "${INT} is not an integer" >&2; exit 1
fi
