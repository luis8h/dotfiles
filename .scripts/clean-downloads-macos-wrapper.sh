#!/bin/bash

# Define a file to store the last run date
TODAY=$(date +%Y-%m-%d)
LAST_RUN_FILE="./.last-clean-download-run"
LOG_DIR="../logs/clean-downloads"
LOG_FILE="$LOG_DIR/${TODAY}_clean-downloads.log"

# Create the directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Create the log file if it doesn't exist and set the correct permissions
if [ ! -f "$LOG_FILE" ]; then
    touch "$LOG_FILE" || { echo "Failed to create log file $LOG_FILE"; exit 1; }
    chmod 644 "$LOG_FILE" || { echo "Failed to set permissions on $LOG_FILE"; exit 1; }
fi

# Function to log messages with a timestamp
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "${LOG_FILE}"
}

# Check if the script has already run today
if [ -f "$LAST_RUN_FILE" ] && [ "$(cat $LAST_RUN_FILE)" == "$TODAY" ]; then
    log_message "Script already ran today, exiting."
    exit 0
fi

# Your script's main logic goes here
log_message "Script is running at $(date)"
sh ./clean-downloads.sh

# Update the last run date
echo $TODAY > $LAST_RUN_FILE
