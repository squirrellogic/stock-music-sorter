# Stock Music Sorting Utility
# Released by Squirrel Logic under the MIT License.

# Function: Rating Sort Mode

# "sorter-config.ps1" is the configuration file. Edit that file to change genres, tags, and category/project folder names.

# Don't edit the source code in this file unless you know what you are doing. 

function Invoke-RatingSort {
    $songs = Get-ChildItem -Path "$destinationFolder" -Include "*.flac", "*.ogg", "*.mp3", "*.wav", "*.aiff", "*.aac", "*.wma", "*.alac" -Exclude "_*", "stock-music-sorter" -Recurse | Where-Object { $_.FullName -NotMatch "\\Good\\|\\Meh\\|\\Awesome\\|\\$skippedFolder\\|\\_" }
    
    foreach ($song in $songs) {
        $doneWithSong = $FALSE

        Invoke-Expression 'start "$song"'

        while (!$doneWithSong) {
            Clear-Host
            
            # Display current song
            $songName = $song.Name
            Write-Host "Now playing... " -NoNewLine -ForegroundColor DarkGray
            Write-Host "$songName" -ForegroundColor White
            Write-Host "" 
    
            $userSelection = Show-SelectionPrompt -NoClear

            switch ($userSelection) {
                "awesome" {
                    try {
                        Move-SongRatingMode -File $song -Rating "Awesome" -ErrorAction Stop
                        $doneWithSong = $TRUE
                    }
                    catch {
                        Get-Error
                        Write-Host "Sort failed. Try again." -ForegroundColor Red
                        Show-AnyKey
                    }
                }
                "good" {
                    try {
                        Move-SongRatingMode -File $song -Rating "Good" -ErrorAction Stop
                        $doneWithSong = $TRUE
                    }
                    catch {
                        Get-Error
                        Write-Host "Sort failed. Try again." -ForegroundColor Red
                        Show-AnyKey
                    }
                }
                "meh" {
                    try {
                        Move-SongRatingMode -File $song -Rating "Meh" -ErrorAction Stop
                        $doneWithSong = $TRUE
                    }
                    catch {
                        Get-Error
                        Write-Host "Sort failed. Try again." -ForegroundColor Red
                        Show-AnyKey
                    }
                }
                "skip" {
                    Skip-Song $song
                    $doneWithSong = $TRUE
                }
                "exit" {
                    Stop-Script
                }
                default {
                    Write-Host "Didn't recognize command." -ForegroundColor Red
                    Start-Sleep -Milliseconds 500
                }
            }
        }
    }
}