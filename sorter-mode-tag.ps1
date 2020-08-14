# Stock Music Sorting Utility
# Released by Squirrel Logic under the MIT License.

# Function: Tag Sort Mode

# "sorter-config.ps1" is the configuration file. Edit that file to change genres, tags, and category/project folder names.

# Don't edit the source code in this file unless you know what you are doing. 

function Invoke-TagSort {
    Write-Host "Tag Sort" # DEBUG

    # Select any folder that doesn't start with "_" AND doesn't have " - " in the directory name.
    # Use folder name as genre name. Still sort based on rating too.
    # Do a check to see if there's any empty folders and delete them?

}