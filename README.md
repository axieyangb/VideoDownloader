# UI-Based Video Downloader

This tool utilizes yt-dlp.exe for downloading videos in a user-friendly manner through a graphical user interface (UI).

## Usage Instructions
The easiest way to execute the command is by opening `index.html`, generating the command from the URL, and then executing it.

If you prefer to execute the command directly without using the HTML page, navigate to the directory where the scripts are located and follow the instructions below.

## Windows

To run the download script on Windows:

1. Open PowerShell with administrative privileges.
2. Run the following command:

   ```powershell
   PowerShell.exe -ExecutionPolicy Bypass -File download.ps1 <URL> <THREAD NUM>
   ```

Replace <URL> with the YouTube video URL and <THREAD NUM> with the desired number of threads.

## Linux

To run the download script on Linux:

1. Open a terminal.

2. Navigate to the directory containing `download.sh`.

3. Run the following command:

   ```bash
   ./download.sh <URL> <THREAD NUM>
   ```

Replace <URL> with the YouTube video URL and <THREAD NUM> with the desired number of threads.

Notes
- Ensure that the `yt-dlp` executable (`yt-dlp.exe` on Windows) is located in the appropriate directory (`./bin/`) relative to the script.
- The script automatically determines the output folder based on the domain name of the video.
- The thread number parameter is optional and defaults to 10 if not specified.