#!/bin/bash
# Description: Generates PDF feedback for students based on input files.
# Usage: Run the script in the same directory as the input files and reportTemplate.md.
# Dependencies: Requires OUTPUT folder in same directory and pandoc to be installed. "sudo apt install pandoc"

# Step 1: Verify prerequisites
if [[ ! -r "Students.txt" ]]; then
    echo "Error: Students.txt is missing or cannot be read. Exiting."
    exit 1
fi

if [[ ! -r "Marks.txt" ]]; then
    echo "Error: Marks.txt is missing or cannot be read. Exiting."
    exit 1
fi

if [[ ! -s "Marks.txt" ]]; then
    echo "Error: Marks.txt is empty. Exiting."
    exit 1
fi

if [[ ! -r "reportTemplate.md" ]]; then
    echo "Error: reportTemplate.md is missing or cannot be read. Exiting."
    exit 1
fi

if [[ ! -d "OUTPUT" ]]; then
    echo "Error: OUTPUT directory is missing. Exiting."
    exit 1
fi

# Step 2: Inform the user
echo "Starting PDF generation for students marks..."

# Step 3: Loop through each student
while IFS=',' read -r STUDENT_ID NAME; do
    # Extract marks and comments for the current student
    MARKS_LINE=$(grep "$STUDENT_ID" Marks.txt)
    IFS=',' read -r _ Q1_MARK Q2_MARK Q3_MARK COMMENTS <<< "$MARKS_LINE"
    
    # Calculate total marks
    TOTAL_MARK=$((Q1_MARK + Q2_MARK + Q3_MARK))
    
    # Replace placeholders in reportTemplate.md
    TEMP_MD="${STUDENT_ID}.md"
    sed -e "s/{{NAME}}/$NAME/g" \
        -e "s/{{STUDENT_ID}}/$STUDENT_ID/g" \
        -e "s/{{Q1_MARK}}/$Q1_MARK/g" \
        -e "s/{{Q2_MARK}}/$Q2_MARK/g" \
        -e "s/{{Q3_MARK}}/$Q3_MARK/g" \
        -e "s/{{TOTAL_MARK}}/$TOTAL_MARK/g" \
        -e "s/{{COMMENTS}}/$COMMENTS/g" \
        reportTemplate.md > "$TEMP_MD"
    
    # Generate PDF using pandoc
    pandoc "$TEMP_MD" -o "OUTPUT/${STUDENT_ID}.pdf" >/dev/null 2>&1
    if [[ $? -eq 0 ]]; then
        echo "Generated PDF for $NAME ($STUDENT_ID)."
    else
        echo "Error: Failed to generate PDF for $NAME ($STUDENT_ID)."
    fi
    
    # Cleanup temporary markdown file
    rm -f "$TEMP_MD"
done < Students.txt

# Step 4: Inform the user of completion
echo "All PDFs have been generated and stored in the OUTPUT directory."
