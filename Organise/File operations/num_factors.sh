#!/bin/bash
# factors.sh: Finds factors of a number and displays them.

# Function to check if input is a valid number in the range
function is_valid_number {
    if [[ "$1" =~ ^[0-9]+$ ]] && [ "$1" -ge 50 ] && [ "$1" -le 1000 ]; then
        return 0  # Valid number
    else
        return 1  # Invalid number
    fi
}

# Prompt user for input until a valid number is provided
while true; do
    read -p "Enter a number between 50 and 1000: " NUM
    if is_valid_number "$NUM"; then
        break
    else
        echo "Invalid input. Please enter a number between 50 and 1000."
    fi
done

# Find and print factors of the number
echo "Factors of $NUM:"
for i in {1..20}; do
    if (( NUM % i != 0 )); then
        continue  # Skip if not a factor
    fi
    FACTOR=$(( NUM / i ))
    echo "$NUM is $i times $FACTOR"
done
