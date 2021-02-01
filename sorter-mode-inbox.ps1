# Stock Music Sorting Utility
# Released by Squirrel Logic under the MIT License.

# Function: Inbox Sort Mode

# "sorter-config.ps1" is the configuration file. Edit that file to change genres, tags, and category/project folder names.

# Don't edit the source code in this file unless you know what you are doing. 

function Invoke-InboxSort {

    $songs = Get-ChildItem -Path "$sortFolder" -Include "*.flac", "*.ogg", "*.mp3", "*.wav", "*.aiff", "*.aac", "*.wma", "*.alac" -Recurse

    foreach ($song in $songs) {
        $doneWithSong = $FALSE
        $genreSelections = New-Object boolean[] $genres.Length
        $tagSelections = New-Object boolean[] $tags.Length
        $specialCategorySelections = New-Object boolean[] $specialCategories.Length

        Invoke-Expression 'start "$song"'
    
        while (!$doneWithSong) {
            Show-Genres
    
            $userSelection = Show-SelectionPrompt
            $foundCode = Set-Selection

            if (!$foundCode) {
                switch ($userSelection) {
                    "clear" {
                        $genreSelections = New-Object boolean[] $genres.Length
                        $tagSelections = New-Object boolean[] $tags.Length
                        $specialCategorySelections = New-Object boolean[] $specialCategories.Length
                    }
                    "awesome" {
                        try {
                            Move-Song -File $song -Rating "Awesome" -ErrorAction Stop
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
                            Move-Song -File $song -Rating "Good" -ErrorAction Stop
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
                            Move-Song -File $song -Rating "Meh" -ErrorAction Stop
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