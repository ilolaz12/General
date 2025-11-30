#!/bin/bash
# To schedule: 
# add cron job: crontab -e
# add schedule: 0 0 1 * * /path/to/monthly_hostname.sh
# check: crontab -l


# List of planet names
PLANETS=("Mercury" "Venus" "Earth" "Mars" "Jupiter" "Saturn" "Uranus" "Neptune" "Pluto" "Haumea" "Gonggong" "Eris" "Sedna")

# Log file for hostname changes
LOG_FILE="$HOME/hostname_change.log"

# Select a random planet name from the list
NEW_HOSTNAME=${PLANETS[$RANDOM % ${#PLANETS[@]}]}

# Change the hostname
echo "Changing hostname to $NEW_HOSTNAME..."
sudo hostnamectl set-hostname "$NEW_HOSTNAME"

# Update /etc/hosts
sudo sed -i "s/127.0.1.1.*/127.0.1.1   $NEW_HOSTNAME/" /etc/hosts

# Log the change with a timestamp
echo "$(date): Hostname changed to $NEW_HOSTNAME" >> "$LOG_FILE"

# Notify user
echo "Hostname successfully changed to $NEW_HOSTNAME. Check $LOG_FILE for history."
