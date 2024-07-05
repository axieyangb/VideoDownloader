# Set paths and defaults
# Get the directory where the script is located
$ScriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path

# Construct the absolute path to yt-dlp.exe
$BinaryFile = Join-Path -Path $ScriptDirectory -ChildPath ".\bin\yt-dlp.exe"

# Error handling for missing yt-dlp.exe
if (!(Test-Path -Path $BinaryFile)) {
  Write-Error "Error: $BinaryFile not found in current directory."
  exit 1
}


# Build the download command
$UpdateCommand = "$BinaryFile --update-to stable"

# Display the command before executing
Write-Host "Running command: $UpdateCommand"

# Call yt-dlp with the built command
Invoke-Expression $UpdateCommand