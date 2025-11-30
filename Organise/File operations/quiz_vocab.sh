#!/bin/bash
# Description: Language quiz 
# Usage: "./quiz_vocab.sh -hm language-to-language.txt"
# Dependencies: Requires language-to-language.txt file (in same directory) to run

# Function to print usage instructions
usage() {
    echo "Usage: $0 [-h] [-m] <language-to-language-file>"
    echo "  -h    Allow users to ask for a hint (first letter of the answer)"
    echo "  -m    Allow multiple attempts for each question"
    exit 1
}

# Parse options
ALLOW_HINTS=0
ALLOW_MULTIPLE_ATTEMPTS=0
while getopts "hm" opt; do
    case $opt in
        h) ALLOW_HINTS=1 ;;
        m) ALLOW_MULTIPLE_ATTEMPTS=1 ;;
        *) usage ;;
    esac
done
shift $((OPTIND - 1))

# Validate input file
if [ $# -ne 1 ]; then
    usage
fi

WORD_PAIRS_FILE="$1"
if [ ! -f "$WORD_PAIRS_FILE" ]; then
    echo "Error: File '$WORD_PAIRS_FILE' not found."
    exit 1
fi

# Check if the file has valid content
if ! grep -q '^[^,]\+,[^,]\+$' "$WORD_PAIRS_FILE"; then
    echo "Error: File '$WORD_PAIRS_FILE' must contain word pairs in 'word,translation' format."
    exit 1
fi

# Check if the file is empty
if [[ ! -s "$WORD_PAIRS_FILE" ]]; then
    echo "Error: File '$WORD_PAIRS_FILE' is empty."
    exit 1
fi

# Shuffle the word pairs and read them into an array
WORD_PAIRS=($(shuf "$WORD_PAIRS_FILE"))

# Initialize variables
TOTAL_QUESTIONS=${#WORD_PAIRS[@]}
CORRECT_ANSWERS=0
QUESTION_NUMBER=0
INCORRECT_ATTEMPTS=0
START_TIME=$(date +%s)

# Start quiz
for PAIR in "${WORD_PAIRS[@]}"; do
    QUESTION_NUMBER=$((QUESTION_NUMBER + 1))
    
    # Split the pair into English and foreign words
    IFS=',' read -r ENGLISH_WORD FOREIGN_WORD <<< "$PAIR"
    
    # Ask the question
    echo "$QUESTION_NUMBER/$TOTAL_QUESTIONS. What is the translation for \"$ENGLISH_WORD\"?"
    
    while true; do
        # Get the user's answer
        read -p "Your answer: " USER_ANSWER
        USER_ANSWER=$(echo "$USER_ANSWER" | tr '[:upper:]' '[:lower:]')
        
        # Handle exit command
        if [[ "$USER_ANSWER" == "exit" ]]; then
            echo "Exiting the quiz..."
            break 2
        fi
        
        # Handle hints
        if [[ "$ALLOW_HINTS" -eq 1 && "$USER_ANSWER" == "help" ]]; then
            echo "HELP: the first letter is \"${FOREIGN_WORD:0:1}\""
            continue
        fi
        
        # Check if the answer is correct
        if [[ "$USER_ANSWER" == "$FOREIGN_WORD" ]]; then
            CORRECT_ANSWERS=$((CORRECT_ANSWERS + 1))
            echo "Correct! ( $CORRECT_ANSWERS / $QUESTION_NUMBER )"
            break
        else
            echo "Incorrect!"
            INCORRECT_ATTEMPTS=$((INCORRECT_ATTEMPTS + 1))
            
            # If multiple attempts are allowed
            if [[ "$ALLOW_MULTIPLE_ATTEMPTS" -eq 1 ]]; then
                echo "Please try again or type 'skip' to skip."
                
                # Handle skip
                if [[ "$USER_ANSWER" == "skip" ]]; then
                    echo "Skipping to the next question."
                    break
                fi
            else
                # Single attempt mode: move to the next question
                break
            fi
        fi
    done
done

# Calculate total time taken
END_TIME=$(date +%s)
TIME_TAKEN=$((END_TIME - START_TIME))

# Display results
echo "Quiz complete!"
echo "You answered $CORRECT_ANSWERS out of $TOTAL_QUESTIONS questions correctly."
echo "Total incorrect attempts: $INCORRECT_ATTEMPTS"
echo "Time taken: $TIME_TAKEN seconds."
