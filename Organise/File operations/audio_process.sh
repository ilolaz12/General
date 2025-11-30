#!/bin/bash
# Description: File to process audiofiles saved to ~/dailyingest folder (line for Directories) 
# into ~/audio/byDate/ and possibly create some symbolic links
# To schedule:
# add cron job: crontab -e
# add schedule: 0 0 0 1 * /path_to/audio_process.sh
# check: rontab -l

# Default directories - compare to actual directory
DAILY_INGEST="${1:-~/dailyingest}"
AUDIO_DIR="${2:-~/audio}"
BADFILES_DIR="${3:-~/badfiles}"

# Define valid topics and contributors
VALID_TOPICS=("sport" "politics" "business" "technology")
VALID_CONTRIBUTORS=("Stan" "Livia" "William")

# Initialize counters
total_files=0
valid_files=0
invalid_files=0
symbolic_links=0

# Function to validate filename
validate_filename() {
  local filename=$1
  if [[ $filename =~ ^[0-9]{8}-([a-z]+)-([A-Za-z]+)-.*\.mp3$ ]]; then
    local topic="${BASH_REMATCH[1]}"
    local contributor="${BASH_REMATCH[2]}"
    if [[ " ${VALID_TOPICS[*]} " =~ " $topic " && " ${VALID_CONTRIBUTORS[*]} " =~ " $contributor " ]]; then
      return 0 # Valid file
    fi
  fi
  return 1 # Invalid file
}

# Ensure required directories exist
mkdir -p "$AUDIO_DIR/byDate"
mkdir -p "$BADFILES_DIR"

# Process files
if [[ -z "$(ls -A "$DAILY_INGEST" 2>/dev/null)" ]]; then
  echo "No files found in $DAILY_INGEST. Nothing to process."
  exit 0
fi

for file in "$DAILY_INGEST"/*.mp3; do
  [[ -e "$file" ]] || continue # Skip if no files found
  total_files=$((total_files + 1))
  filename=$(basename "$file")

  if validate_filename "$filename"; then
    valid_files=$((valid_files + 1))

    # Extract components from filename
    DATE=$(echo "$filename" | cut -d'-' -f1)
    TOPIC=$(echo "$filename" | cut -d'-' -f2)
    CONTRIBUTOR=$(echo "$filename" | cut -d'-' -f3)

    # Ensure contributor and topic directories exist
    mkdir -p "$AUDIO_DIR/byContributor/$CONTRIBUTOR"
    mkdir -p "$AUDIO_DIR/byTopic/$TOPIC"

    # Move file to byDate
    mv "$file" "$AUDIO_DIR/byDate/"

    # Create symbolic links with error handling
    if ln -s "$AUDIO_DIR/byDate/$filename" "$AUDIO_DIR/byContributor/$CONTRIBUTOR/$filename"; then
      symbolic_links=$((symbolic_links + 1))
    else
      echo "Failed to create symbolic link for contributor $CONTRIBUTOR"
    fi

    if ln -s "$AUDIO_DIR/byDate/$filename" "$AUDIO_DIR/byTopic/$TOPIC/$filename"; then
      symbolic_links=$((symbolic_links + 1))
    else
      echo "Failed to create symbolic link for topic $TOPIC"
    fi

  else
    invalid_files=$((invalid_files + 1))
    # Invalid file, move to badfiles
    mv "$file" "$BADFILES_DIR/"
    echo "Invalid file: $filename moved to badfiles" >&2
  fi
done

# Output summary
echo " "
echo "Processing complete."
echo "Total files processed: $total_files"
echo "Valid files processed: $valid_files"
echo "Invalid files moved to badfiles: $invalid_files"
echo "Total symbolic links created: $symbolic_links"
