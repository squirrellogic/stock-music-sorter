# Stock Music Sorting Utility
# Released by Squirrel Logic under the MIT License. See license.txt for details.

# "sorter-config.ps1" is the configuration file. Edit that file to change genres, tags, and category/project folder names.

# Don't edit the source code in this file unless you know what you are doing!

$ErrorActionPreference = "Stop"

. "./sorter-config.ps1"
. "./sorter-functions.ps1"
. "./sorter-mode-inbox.ps1"
. "./sorter-mode-tag.ps1"
. "./sorter-mode-rating.ps1"

# Mode Select

$validSortMode = $FALSE
$sortModeSelectionMessage = ""

while (!$validSortMode) {
    Clear-Host

    if ($sortModeSelectionMessage) {
        Write-Host $sortModeSelectionMessage -ForegroundColor Red
        Write-Host ""
        $sortModeSelectionMessage = ""
    }
    
    Write-Host "====== Stock Music Sorter - Mode Selection ======" -ForegroundColor Green
    Write-Host "Press Ctrl-C any time to stop the sorting script." -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "Enter in the sorting mode you want to use."
    Write-Host ""
    Write-Host "inbox " -NoNewline -ForegroundColor Green
    Write-Host "to sort your inbox folder into genres, tags, and ratings." -ForegroundColor White
    Write-Host "tag " -NoNewline -ForegroundColor Green
    Write-Host "to sort songs in destination that are not tagged." -ForegroundColor White
    Write-Host "rating " -NoNewline -ForegroundColor Green
    Write-Host "to sort songs that don't have a rating." -ForegroundColor White
    Write-Host ""

    $sortModeSelection = Read-Host "> Enter mode"

    switch ($sortModeSelection) {
        "inbox" { 
            $validSortMode = $TRUE
            Invoke-InboxSort
        }
        "tag" { 
            $validSortMode = $TRUE
            Invoke-TagSort
        }
        "rating" { 
            $validSortMode = $TRUE
            Invoke-RatingSort
        }
        default {
            $sortModeSelectionMessage = "Command not recognized. Please type a valid mode."
        }
    }
}


# All Done

Write-Host ""
Write-Host "No more songs to sort. Closing Script"  -ForegroundColor Green
Write-Host ""
Show-AnyKey
