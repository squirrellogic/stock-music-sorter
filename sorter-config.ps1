# Stock Music Sorting Utility
# Released by Squirrel Logic under the MIT License.

# Configuration File

# Location of the folder for files to be sorted. This will also grab files in it's subfolders too. (Files in subfolders may be first in the queue.)
$sortFolder = "../zzz-SORT ME"

# Destination folder root, the folder that contains all of the genre/tag folders.
$destinationFolder = "../"

# Skipped Folder
$skippedFolder = "../zzz-SKIPPED"

# Sound file to play between songs. Since a file can't be moved/deleted if it's being played, the $waitSong is played to free up the current song to be moved.
$waitSong = "./empty.flac" 

# Amount of time to wait between stopping current song and moving current song on disk. The time might need to be increased if you have a slower computer.
$waitTimeInMilliseconds = 1300

# Genres of music. This is the top-level of your organization.
$genres = @(
    @("1", "Ambient", "DarkCyan"),
    @("2", "Electronica", "Cyan"),
    @("3", "Folk", "DarkRed"),
    @("4", "Funk", "Magenta"),
    @("5", "Hybrid Cinematic", "Green"),
    @("6", "Jazz", "White"),
    @("7", "Noise", "Gray"),
    @("8", "Orchestral", "Green"),
    @("9", "Pop", "Magenta"),
    @("10", "Rock", "Red"),
    @("11", "Urban", "Yellow"),
    @("12", "World", "DarkYellow")
)

# Tags or emotions of music that are shared between each genre (not including specialCategories). This is the second level of your organization.
$tags = @(
    @("a", "Action", "Red"),
    @("b", "Badass", "Yellow"),
    @("c", "Creeping", "DarkGreen"),
    @("d", "Driving", "Yellow"),
    @("e", "Easy", "Cyan"),
    @("f", "Funky", "Magenta"),
    @("h", "Hope", "White"),
    @("m", "Melancholy", "DarkCyan"),
    @("t", "Montage", "Yellow"),
    @("r", "Revelation", "Cyan"),
    @("t", "Trippy", "Gray"),
    @("w", "Wandering", "DarkCyan")
)

# specialCategories are pseudo "genres" that don't use tags for sorting. These are useful for music intended for certain projects or very specialized genres that have few songs.
$specialCategories = @(
    @("21", "__Project 1", "Gray"),
    @("22", "__Project 2", "White"),
    @("23", "__Project 3", "Yellow"),
    @("41", "_1980s", "Magenta"),
    @("42", "_Gregorian Chant", "Magenta"),
    @("43", "_Glitchy", "DarkCyan"),
    @("44", "_Silly", "White")
)