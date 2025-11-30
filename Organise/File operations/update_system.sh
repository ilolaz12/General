#!/bin/bash
# Script to update system packages

# Check if the user has root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root (use sudo)"
  exit 1
fi

# Function to update and upgrade using apt
update_with_apt() {
  echo "Updating package list with apt..."
  apt update -y
  echo "Upgrading packages with apt..."
  apt upgrade -y
  echo "Cleaning up unnecessary packages..."
  apt autoremove -y
  echo "System updated successfully with apt!"
}

# Function to update and upgrade using yum or dnf
update_with_yum() {
  echo "Updating package list with yum/dnf..."
  yum update -y || dnf update -y
  echo "System updated successfully with yum/dnf!"
}

# Check which package manager is available and run the corresponding function
if command -v apt >/dev/null 2>&1; then
  update_with_apt
elif command -v yum >/dev/null 2>&1 || command -v dnf >/dev/null 2>&1; then
  update_with_yum
else
  echo "Error: Unsupported package manager. This script only supports apt, yum, and dnf."
  exit 1
fi

echo "Update process complete."
