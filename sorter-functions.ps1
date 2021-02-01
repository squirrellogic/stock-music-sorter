# Stock Music Sorting Utility
# Released by Squirrel Logic under the MIT License.

# Functions

# "sorter-config.ps1" is the configuration file. Edit that file to change genres, tags, and category/project folder names.

# Don't edit the source code in this file unless you know what you are doing. 

function Show-AnyKey {
    Write-Host "Press any key to close..."  -ForegroundColor DarkGray
    $null = $Host.UI.RawUI.ReadKey('NoEcho, IncludeKeyDown');
}

function Close-Song {
    Invoke-Expression 'start $waitSong'
    Write-Host "Closing Song..." -ForegroundColor DarkGray
    Start-Sleep -Milliseconds $waitTimeInMilliseconds
}

function Stop-Script {
    Write-Host "Exiting..." -ForegroundColor Red
    Start-Sleep -Milliseconds 1000
    exit
}

function Write-TheseManySpaces {
    param (
        [int] $spaces
    )
    for ($i = 0; $i -lt $spaces; $i++) {
        Write-Host " " -NoNewline
    }
}

function Test-Selection {
    <#
    .SYNOPSIS
    Returns $TRUE if an array of booleans (e.g. a selection) has any true value.

    .PARAMETER Selection
    Specifices the array of boolean values representing the user selection.
    #>

    param ([boolean[]]$Selection)

    for ($i = 0; $i -lt $Selection.Count; $i++) {
        if ($Selection[$i]) {
            return $TRUE
        }
    }
    return $FALSE
}

function Show-Genres {
    <#
    .SYNOPSIS
    Displays the genre, tag, and special category lists.
    #>

    Clear-Host

    # Display current song
    $songName = $song.Name
    Write-Host "Now playing... " -NoNewLine -ForegroundColor DarkGray
    Write-Host "$songName" -ForegroundColor White
    Write-Host "" 
    
    # Find longest genre and tag names
    $longestGenre = 0
    $longestTag = 0
    foreach ($genre in $genres) {
        if ($genre[1].length -gt $longestGenre) {
            $longestGenre = $genre[1].length
        }
    }
    foreach ($tag in $tags) {
        if ($tag[1].length -gt $longestTag) {
            $longestTag = $tag[1].length
        }
    }

    # Display Header
    Write-Host "Genre" -NoNewline -ForegroundColor DarkGray
    Write-TheseManySpaces (5 + $longestGenre)
    Write-Host "Tags" -NoNewline -ForegroundColor DarkGray
    Write-TheseManySpaces (6 + $longestTag)
    Write-Host "Special Categories (tagless)" -ForegroundColor DarkGray
    Write-Host ""

    # Display all genres, tags and specialCategories codes.
    for ($i = 0; ($i -lt $genres.Count) -or ($i -lt $tags.Count) -or ($i -lt $specialCategories.Count); $i++) {
        # Genre
        if ($i -lt $genres.Count) {
            Write-Host "[" -NoNewline -ForegroundColor DarkGray
            if ($genreSelections[$i]) {
                Write-Host "X" -NoNewline -ForegroundColor $genres[$i][2]
            }
            else {
                Write-Host " " -NoNewline
            }
            Write-Host "]" -NoNewline -ForegroundColor DarkGray
            Write-Host " " -NoNewline
            if ($genres[$i][0].length -eq 1) {
                Write-Host " " -NoNewline
            }
            Write-Host $genres[$i][0] -NoNewline -ForegroundColor $genres[$i][2]
            Write-Host ". " -NoNewline -ForegroundColor $genres[$i][2]
            Write-Host $genres[$i][1] -NoNewline -ForegroundColor $genres[$i][2]
            Write-TheseManySpaces ($longestGenre - $genres[$i][1].length + 2)
        }
        else {
            Write-TheseManySpaces (10 + $longestGenre)
        }

        # Tag
        if ($i -lt $tags.Count) {
            Write-Host "[" -NoNewline -ForegroundColor DarkGray
            if ($tagSelections[$i]) {
                Write-Host "X" -NoNewline -ForegroundColor $tags[$i][2]
            }
            else {
                Write-Host " " -NoNewline
            }
            Write-Host "]" -NoNewline -ForegroundColor DarkGray
            Write-Host " " -NoNewline
            if ($tags[$i][0].length -eq 1) {
                Write-Host " " -NoNewline
            }
            Write-Host $tags[$i][0] -NoNewline -ForegroundColor $tags[$i][2]
            Write-Host ". " -NoNewline -ForegroundColor $tags[$i][2]
            Write-Host $tags[$i][1] -NoNewline -ForegroundColor $tags[$i][2]
            Write-TheseManySpaces ($longestTag - $tags[$i][1].length + 2)
        }
        else {
            Write-TheseManySpaces (10 + $longestTag)
        }
        
        # specialCategories
        if ($i -lt $specialCategories.Count) {
            Write-Host "[" -NoNewline -ForegroundColor DarkGray
            if ($specialCategorySelections[$i]) {
                Write-Host "X" -NoNewline -ForegroundColor $specialCategories[$i][2]
            }
            else {
                Write-Host " " -NoNewline
            }
            Write-Host "]" -NoNewline -ForegroundColor DarkGray
            Write-Host " " -NoNewline
            if ($specialCategories[$i][0].length -eq 1) {
                Write-Host " " -NoNewline
            }
            Write-Host $specialCategories[$i][0] -NoNewline -ForegroundColor $specialCategories[$i][2]
            Write-Host ". " -NoNewline -ForegroundColor $specialCategories[$i][2]
            Write-Host $specialCategories[$i][1] -ForegroundColor $specialCategories[$i][2]
        }
        else {
            Write-Host ""
        }
    }
    Write-Host "" 
}

function Show-Tags {
    <#
    .SYNOPSIS
    Displays the tag lists.
    #>

    Clear-Host

    # Display current song
    $songName = $song.Name
    Write-Host "Now playing... " -NoNewLine -ForegroundColor DarkGray
    Write-Host "$songName" -ForegroundColor White
    Write-Host "" 
    
    # Find longest tag names
    $longestTag = 0
    foreach ($tag in $tags) {
        if ($tag[1].length -gt $longestTag) {
            $longestTag = $tag[1].length
        }
    }

    # Display Header
    Write-Host "Tags" -ForegroundColor DarkGray

    # Display all tags.
    for ($i = 0; ($i -lt $tags.Count); $i++) {
        # Tag
        if ($i -lt $tags.Count) {
            Write-Host "[" -NoNewline -ForegroundColor DarkGray
            if ($tagSelections[$i]) {
                Write-Host "X" -NoNewline -ForegroundColor $tags[$i][2]
            }
            else {
                Write-Host " " -NoNewline
            }
            Write-Host "]" -NoNewline -ForegroundColor DarkGray
            Write-Host " " -NoNewline
            if ($tags[$i][0].length -eq 1) {
                Write-Host " " -NoNewline
            }
            Write-Host $tags[$i][0] -NoNewline -ForegroundColor $tags[$i][2]
            Write-Host ". " -NoNewline -ForegroundColor $tags[$i][2]
            Write-Host $tags[$i][1] -ForegroundColor $tags[$i][2]
        }
    }
    Write-Host "" 
}

function Show-SelectionPrompt {
    <#
    .SYNOPSIS
    Displays the selection prompt. Returns user input as a string.
    #>

    param (
        [Switch]$NoClear
    )

    Write-Host "--------------------------------------------------------------------------------" -ForegroundColor DarkGray

    if (!$NoClear) {
        Write-Host "Type a code and press Enter to tag a song." -ForegroundColor White
    
        Write-Host "Type " -NoNewline -ForegroundColor Gray
        Write-Host "clear " -NoNewLine -ForegroundColor Red
        Write-Host "to start over." -ForegroundColor Gray
    }

    Write-Host "Type " -NoNewLine -ForegroundColor Gray
    Write-Host "awesome " -NoNewLine -ForegroundColor Cyan
    Write-Host "to sort the best songs." -ForegroundColor Gray

    Write-Host "Type " -NoNewLine -ForegroundColor Gray
    Write-Host "good " -NoNewLine -ForegroundColor Green
    Write-Host "to sort good songs." -ForegroundColor Gray

    Write-Host "Type " -NoNewLine -ForegroundColor Gray
    Write-Host "meh " -NoNewLine -ForegroundColor Yellow
    Write-Host "to sort passable songs." -ForegroundColor Gray

    Write-Host "Type " -NoNewLine -ForegroundColor Gray
    Write-Host "skip " -NoNewLine -ForegroundColor White
    Write-Host "to sort song into skipped folder to be delt with later." -ForegroundColor Gray

    Write-Host "--------------------------------------------------------------------------------" -ForegroundColor DarkGray

    Write-Host ""
    Return Read-Host "> Enter command"
}

function Set-Selection {
    <#
    .SYNOPSIS
    Returns $TRUE if $userSelection matches any of the input codes found in the genre, tag and special category lists.
    #>

    param (
        [Switch]$NoGenre,
        [Switch]$NoTag,
        [Switch]$NoRating
    )

    $local:foundCode = $FALSE
    for ($i = 0; ($i -lt $genres.Count) -or ($i -lt $tags.Count) -or ($i -lt $specialCategories.Count); $i++) {
        # Genre
        if (!$NoGenre) {
            if ($i -lt $genres.Count) {
                if ($userSelection -eq $genres[$i][0]) {
                    $genreSelections[$i] = !$genreSelections[$i]
                    $foundCode = $TRUE
                }
            }
        }
        # Tag
        if (!$NoTag) {
            if ($i -lt $tags.Count) {
                if ($userSelection -eq $tags[$i][0]) {
                    $tagSelections[$i] = !$tagSelections[$i]
                    $foundCode = $TRUE
                }
            }
        }
        # specialCategories
        if (!$NoRating) {
            if ($i -lt $specialCategories.Count) {
                if ($userSelection -eq $specialCategories[$i][0]) {
                    $specialCategorySelections[$i] = !$specialCategorySelections[$i]
                    $foundCode = $TRUE
                }
            }
        }
    }
    return $foundCode
}

function Copy-Song {
    <#
    .SYNOPSIS
    Copies a song into the specified subfolder of destinationFolder

    .PARAMETER Subfolder
    Subfolder that the songs will go into.

    .PARAMETER Rating
    Sub-subfolder that the songs will go into.
    #>

    param (
        [string]$Subfolder,
        [string]$Rating
    )
    
    if (!(Test-Path -Path "$destinationFolder/$Subfolder")) {
        New-Item -Path "$destinationFolder" -Name "$Subfolder" -ItemType "directory" | Out-Null
    }
    if (!(Test-Path -Path "$destinationFolder/$Subfolder/$Rating")) {
        New-Item -Path "$destinationFolder/$Subfolder" -Name "$Rating" -ItemType "directory" | Out-Null
    }

    try {
        Copy-Item $File -Destination "$destinationFolder/$Subfolder/$Rating" -ErrorAction Stop | Out-Null
    }
    catch {
        Get-Error
        Write-Host "Copy wasn't successful for some reason. See above error." -ForegroundColor Red
        Write-Host "Because it wouldn't copy, this is a critical error and the script will now quit." -ForegroundColor Red
        Show-AnyKey
        exit
    }
}

function Move-Song {
    <#
    .SYNOPSIS
    Moves the song based on the user selections.

    .PARAMETER File
    The URL (string) of the target song to be moved.

    .PARAMETER Rating
    The rating subfolder that the song will be moved into.
    #>

    param (
        [parameter(mandatory = $true)][string]$File,
        [string]$Rating
    )

    # Check to see if a genre selection has been made.
    if (!((Test-Selection -Selection $genreSelections) -or (Test-Selection -Selection $specialCategorySelections))) {
        Write-Host "No genres or special categories where selected." -ForegroundColor Red
        Start-Sleep -s 1
        throw "No genres or special categories where selected."
    }

    # Go through genres
    for ($i = 0; $i -lt $genreSelections.Count; $i++) {
        if ($genreSelections[$i]) {
            # When there's a tag
            for ($j = 0; $j -lt $tagSelections.Count; $j++) {
                $currentGenre = $genres[$i][1]
                $currentTag = $tags[$j][1]
                if ($tagSelections[$j]) {
                    Copy-Song -Subfolder "$currentGenre - $currentTag" -Rating $Rating
                }
            }
            # If there's no tags
            if (!(Test-Selection -Selection $tagSelections)) {
                $currentGenre = $genres[$i][1]
                Copy-Song -Subfolder "$currentGenre" -Rating $Rating
            }
        }
    }

    # Go through specialCategories
    for ($i = 0; $i -lt $specialCategorySelections.Count; $i++) {
        if ($specialCategorySelections[$i]) {
            $currentSpecialCategory = $specialCategories[$i][1]
            Copy-Song -Subfolder "$currentSpecialCategory" -Rating $Rating
        }
    }

    # TODO: A way to check to see if the file has actually copied before deleting the source.
   
    Close-Song
    Remove-Item $File
}

function Move-SongTagMode {
    <#
    .SYNOPSIS
    Moves the song based on the user selections using Tag and Rating Only.

    .PARAMETER File
    The URL (string) of the target song to be moved.

    .PARAMETER Rating
    The rating subfolder that the song will be moved into.
    #>

    param (
        [parameter(mandatory = $true)][string]$File,
        [string]$Rating
    )

    # Check to see if a tag selection has been made.
    if (!(Test-Selection -Selection $tagSelections)) {
        Write-Host "No tags were selected." -ForegroundColor Red
        Start-Sleep -s 1
        throw "No tags where selected."
    }

    # Go through tags
    for ($j = 0; $j -lt $tagSelections.Count; $j++) {
        $currentTag = $tags[$j][1]
        if ($tagSelections[$j]) {
            Copy-Song -Subfolder "$taglessFolder - $currentTag" -Rating $Rating
        }
    }

    # TODO: A way to check to see if the file has actually copied before deleting the source.
   
    Close-Song
    Remove-Item $File
}

function Move-SongRatingMode {
    <#
    .SYNOPSIS
    Moves the song based on the user selections using Rating Only.

    .PARAMETER File
    The URL (string) of the target song to be moved.

    .PARAMETER Rating
    The rating subfolder that the song will be moved into.
    #>

    param (
        [parameter(mandatory = $true)][string]$File,
        [string]$Rating
    )
   
    Close-Song

    $songParentPath = Split-Path -Path "$File"

    if (!(Test-Path -Path "$songParentPath/$Rating")) {
        New-Item -Path "$songParentPath" -Name "$Rating" -ItemType "directory" | Out-Null
    }

    Write-Host "Moving Song to Rating Folder..." -ForegroundColor Yellow
    try {
        Move-Item -Path $File -Destination "$songParentPath/$Rating" -ErrorAction Stop
    }
    catch {
        Write-Host ""
        Get-Error
        Write-Host ""
        Write-Host "Couldn't move file. Trying again..." -ForegroundColor Red
        Write-Host "(Consider increasing waitTimeInMilliseconds.)" -ForegroundColor DarkRed
        Write-Host ""
        Show-AnyKey
        try {
            Move-Item -Path $File -Destination "$songParentPath/$Rating" -ErrorAction Stop
        }
        catch {
            Write-Host ""
            Get-Error
            Write-Host ""
            Write-Host "Still couldn't move file. Something else might be wrong." -ForegroundColor Red
            Show-AnyKey
        }
    }
}

function Skip-Song {
    <#
    .SYNOPSIS
    Moves song to the skipped folder.

    .PARAMETER File
    The URL (string) of the target song to be skipped
    #>

    param (
        [parameter(mandatory = $true)][string]$File
    )

    Close-Song

    if (!(Test-Path -Path "$skippedFolder")) {
        New-Item -Path "$destinationFolder" -Name "$skippedFolder" -ItemType "directory" | Out-Null
    }
    
    Write-Host "Moving Song..." -ForegroundColor Yellow
    try {
        Move-Item -Path $song -Destination "$destinationFolder/$skippedFolder" -ErrorAction Stop
    }
    catch {
        Write-Host ""
        Get-Error
        Write-Host ""
        Write-Host "Couldn't move file. Trying again..." -ForegroundColor Red
        Write-Host "(Consider increasing waitTimeInMilliseconds.)" -ForegroundColor DarkRed
        Write-Host ""
        Show-AnyKey
        try {
            Move-Item -Path $song -Destination "$destinationFolder/$skippedFolder" -ErrorAction Stop
        }
        catch {
            Write-Host ""
            Get-Error
            Write-Host ""
            Write-Host "Still couldn't move file. Something else might be wrong." -ForegroundColor Red
            Show-AnyKey
        }
    }
}
