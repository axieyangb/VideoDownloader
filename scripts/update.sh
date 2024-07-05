#!/bin/bash

# Get script directory
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Construct yt-dlp path
yt_dlp_path="$script_dir/bin/yt-dlp"

# Check if yt-dlp exists and exit on error
if [[ ! -f "$yt_dlp_path" ]]; then
  echo "Error: yt-dlp not found in '$yt_dlp_path'"
  exit 1
fi

# Build update command
update_command="$yt_dlp_path --update-to stable"

# Display and execute update command
echo "Running command: $update_command"
# Execute the command
eval "$update_command"
