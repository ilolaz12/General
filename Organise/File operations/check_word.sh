#!/bin/bash
# check_word.sh - Script to check if a word is in the dictionary (with optional case-insensitive search)

# adjust directory as required
DICTIONARY='/usr/'
SCRIPTNAME=$(basename "$0")

# Check if an optional -i flag is used for case-insensitive search
case_sensitive=true
if [ "$1" == "-i" ]; then
    case_sensitive=false
    shift
fi

# Check that exactly one argument is provided after any options
if [ "$#" -ne 1 ]; then
    echo "Usage: ${SCRIPTNAME} [-i] <word>"
    echo "       -i : Perform a case-insensitive search"
    exit 1
fi

word="$1"
# Choose grep options based on case sensitivity
if $case_sensitive; then
    grep_options="-q"
else
    grep_options="-qi"
fi

# Search for the word
if grep $grep_options "^${word}$" "$DICTIONARY" 2>/dev/null; then
    echo "The word '${word}' is in the dictionary!"
    exit 0
else
    echo "The word '${word}' was not found in the dictionary."
    exit 2
fi
