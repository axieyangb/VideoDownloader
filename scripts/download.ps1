# Set paths and defaults
# Get the directory where the script is located
$ScriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path

# Construct the absolute path to yt-dlp.exe
$BinaryFile = Join-Path -Path $ScriptDirectory -ChildPath ".\bin\yt-dlp.exe"

$DefaultThreadNumber = 10

# Error handling for missing yt-dlp.exe
if (!(Test-Path -Path $BinaryFile)) {
  Write-Error "Error: $BinaryFile not found in current directory."
  exit 1
}

# Check for missing URL parameter
if ($args.Length -eq 0) {
  Write-Error "Error: Please provide a YouTube video URL as the first argument."
  exit 1
}

# Remove surrounding double quotes from the URL
$URL = $args[0]
if ($URL[0] -eq '"' -and $URL[-1] -eq '"') {
  $URL = $URL.Substring(1, $URL.Length - 2)
}

# Verify that URL starts with "https://"
$ValidPrefix = "https://"
if (!($URL.StartsWith($ValidPrefix, [StringComparison]::OrdinalIgnoreCase))) {
  Write-Error "Error: URL must start with 'https://'."
  exit 1
}

# Remove the "https://" prefix
$URLWithoutPrefix = $URL.Substring(8)

# Extract domain name without top-level domain, "www.", and ".com" suffix
$Domain = $URLWithoutPrefix
$Domain = $Domain -replace '^www\.', '' # Remove leading "www."
$Domain = $Domain -replace '/.*', ''   # Remove path and query parameters
$Domain = $Domain -replace '\.[^.]*$', '' # Remove domain suffix (e.g., .com, .net)

Write-Host "Domain: $Domain"

# Set default thread number
$ThreadNumber = $DefaultThreadNumber

# Check if optional -N parameter is provided
if ($args.Length -gt 1) {
  $ThreadNumber = [int]::Parse($args[1])
  if ($ThreadNumber -le 0) {
    Write-Error "Error: Invalid thread count. Please provide a positive number."
    exit 1
  }
}

$OutputFolder = ".\$Domain"


# Build the download command
$DownloadCommand = "$BinaryFile `"$URL`" -o `"$OutputFolder\%(title)s.%(ext)s`" -N $ThreadNumber"

# Display the command before executing
Write-Host "Running command: $DownloadCommand"

# Call yt-dlp with the built command
Invoke-Expression $DownloadCommand
