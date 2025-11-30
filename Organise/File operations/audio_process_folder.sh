#!/bin/bash

# Base directory for the folder structure
BASE_DIR=~/audio
BADFILES_DIR=~/badfiles

# Topics and contributors
TOPICS=("sport" "politics" "business" "technology")
CONTRIBUTORS=("Stan" "Livia" "William")

# Create base directories
echo "Creating base directories..."
mkdir -p "$BASE_DIR/byDate"
mkdir -p "$BADFILES_DIR"

# Create subdirectories for contributors
echo "Creating contributor directories..."
for contributor in "${CONTRIBUTORS[@]}"; do
    mkdir -p "$BASE_DIR/byContributor/$contributor"
done

# Create subdirectories for topics
echo "Creating topic directories..."
for topic in "${TOPICS[@]}"; do
    mkdir -p "$BASE_DIR/byTopic/$topic"
done

# Display the created structure
echo "Folder structure created:"
tree ~ | grep -A 20 "audio"
