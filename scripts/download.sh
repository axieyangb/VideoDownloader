#!/bin/bash

# Set paths and defaults
# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Define the path to yt-dlp relative to the script's location
BinaryFile="$SCRIPT_DIR/bin/yt-dlp"

DefaultThreadNumber=10

# Error handling for missing yt-dlp
if [ ! -f "$BinaryFile" ]; then
  echo "Error: $BinaryFile not found in current directory."
  exit 1
fi

# Check for missing URL parameter
if [ "$#" -eq 0 ]; then
  echo "Error: Please provide a YouTube video URL as the first argument."
  exit 1
fi

# Remove surrounding double quotes from the URL
URL="${1%\"}"
URL="${URL#\"}"

# Verify that URL starts with "https://"
ValidPrefix="https://"
if [[ ! "$URL" == "$ValidPrefix"* ]]; then
  echo "Error: URL must start with 'https://'."
  exit 1
fi

# Remove the "https://" prefix
Domain=$(echo "$URL" | sed -E 's|https?://(www\.)?([^.]+).*|\2|')
echo "Domain: $Domain"

# Set default thread number
ThreadNumber=$DefaultThreadNumber

# Check if optional second parameter is provided for thread count
if [ "$#" -gt 1 ]; then
  ThreadNumber="$2"
  if ! [[ "$ThreadNumber" =~ ^[0-9]+$ ]] || [ "$ThreadNumber" -le 0 ]; then
    echo "Error: Invalid thread count. Please provide a positive number."
    exit 1
  fi
fi

OutputFolder="./$Domain"

if [[ ! -d ${OutputFolder} ]]; then
	mkdir -p ${OutputFolder}
fi

# Build the download command
DownloadCommand="$BinaryFile \"$URL\" -o \"$OutputFolder/%(title)s.%(ext)s\" -N $ThreadNumber"

# Display the command before executing
echo "Running command: $DownloadCommand"

# Execute the command
eval "$DownloadCommand"

