# Stock Music Sorting Utility
# Released by Squirrel Logic under the MIT License.

# Function: Tag Mode

# "sorter-config.ps1" is the configuration file. Edit that file to change genres, tags, and category/project folder names.

# Don't edit the source code in this file unless you know what you are doing. 

function Invoke-TagSort {
    Write-Host ""
    Write-Host "====== Tag Sort ======" -ForegroundColor Green
    Write-Host ""
    Write-Host "What tagless folder do you want to sort? This will be a subfolder" -ForegroundColor Green
    Write-Host "of your destination folder." -ForegroundColor Green
    Write-Host ""

    $taglessFolder = Read-Host "> Folder"

    $songs = Get-ChildItem -Path "$destinationFolder/$taglessFolder" -Include "*.flac", "*.ogg", "*.mp3", "*.wav", "*.aiff", "*.aac", "*.wma", "*.alac" -Recurse

    # Only ask for tag and rating. It will use that folder name as the genre and create a new folder with " - tag"
    foreach ($song in $songs) {
        $doneWithSong = $FALSE
        $tagSelections = New-Object boolean[] $tags.Length

        Invoke-Expression 'start "$song"'
    
        while (!$doneWithSong) {
            Show-Tags
    
            $userSelection = Show-SelectionPrompt
            $foundCode = Set-Selection -NoGenre

            if (!$foundCode) {
                switch ($userSelection) {
                    "clear" {
                        $tagSelections = New-Object boolean[] $tags.Length
                    }
                    "awesome" {
                        try {
                            Move-SongTagMode -File $song -Rating "Awesome" -ErrorAction Stop
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
                            Move-SongTagMode -File $song -Rating "Good" -ErrorAction Stop
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
                            Move-SongTagMode -File $song -Rating "Meh" -ErrorAction Stop
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
}