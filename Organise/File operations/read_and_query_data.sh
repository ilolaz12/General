#!/bin/bash
# read_and_query_data.sh: Dynamically query XML, JSON, and CSV files.

# Function to handle XML files
read_xml() {
    echo "Fetching available fields in XML file..."
    local fields=$(xml_grep --wrap --text_only --cond "//*" "$1" | awk '{print $1}' | sort | uniq)
    echo "Available fields:"
    echo "$fields"
    
    read -p "Enter the field you want to display: " FIELD
    echo "Results for field '$FIELD':"
    xml_grep "$FIELD" "$1"
}

# Function to handle JSON files
read_json() {
    echo "Fetching available fields in JSON file..."
    local fields=$(jq -r 'paths | map(tostring) | join(".")' "$1" | sort | uniq)
    echo "Available fields:"
    echo "$fields"

    read -p "Enter the field you want to display: " FIELD
    echo "Results for field '$FIELD':"
    jq ".$FIELD" "$1"
}

# Function to handle CSV files
read_csv() {
    echo "Fetching available fields in CSV file..."
    local fields=$(head -1 "$1" | tr ',' '\n')
    echo "Available fields:"
    echo "$fields"
    
    read -p "Enter the field you want to display: " FIELD
    local column=$(head -1 "$1" | tr ',' '\n' | grep -nx "$FIELD" | cut -d: -f1)
    if [[ -z "$column" ]]; then
        echo "Field '$FIELD' not found in CSV file."
    else
        echo "Results for field '$FIELD':"
        cut -d, -f"$column" "$1"
    fi
}

# Main script logic
echo "Choose the file type:"
echo "1. XML"
echo "2. JSON"
echo "3. CSV"
read -p "Enter your choice (1/2/3): " FILE_TYPE

case $FILE_TYPE in
    1)
        read -p "Enter the XML file path: " FILE_PATH
        if [[ -f "$FILE_PATH" ]]; then
            read_xml "$FILE_PATH"
        else
            echo "File not found: $FILE_PATH"
        fi
        ;;
    2)
        read -p "Enter the JSON file path: " FILE_PATH
        if [[ -f "$FILE_PATH" ]]; then
            read_json "$FILE_PATH"
        else
            echo "File not found: $FILE_PATH"
        fi
        ;;
    3)
        read -p "Enter the CSV file path: " FILE_PATH
        if [[ -f "$FILE_PATH" ]]; then
            read_csv "$FILE_PATH"
        else
            echo "File not found: $FILE_PATH"
        fi
        ;;
    *)
        echo "Invalid choice. Exiting."
        ;;
esac
