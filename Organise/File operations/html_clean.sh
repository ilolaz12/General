#!/bin/bash
# clean_html.sh: Cleans an HTML file using tidy

# Prompt user for input file name
read -p "Enter the name of the input HTML file (in the 'input' folder): " INPUT_FILE

# Verify the input file exists in the 'in' folder
if [[ ! -f "input/${INPUT_FILE}" ]]; then
    echo "Error: File 'iputn/${INPUT_FILE}' does not exist."
    exit 1
fi

# Prompt user for output file name
read -p "Enter the name of the output HTML file (to be saved in the 'output' folder): " OUTPUT_FILE

# Use tidy to clean the input file and save to the output file
tidy -i -o "output/${OUTPUT_FILE}" "input/${INPUT_FILE}" 2>stderr.log

# Check if tidy encountered any warnings or errors
if [[ -s stderr.log ]]; then
    echo "Tidy completed with warnings/errors. See 'stderr.log' for details."
else
    echo "Tidy completed successfully. Output saved to 'output/${OUTPUT_FILE}'."
fi

# Clean up log file if no errors
rm -f stderr.log
