# Stock Music Sorter

Sort your music library by genre, tags, and rating into subfolders for better searching.

This script was originally created by [Squirrel Logic LLC](https://www.squirrellogic.dev/) and released under The MIT License. See `license.txt` for details.

---

This tool is intended for video and podcast producers who have an internal library of stock music that they can use for their content. Genres, tags, project folders, and rating levels are user configurable. It does not use metadata to sort music files. It literally just copies the files into a subfolder structure so you can audition music based on your own preferences.

It is written in PowerShell, and is intended to work on Windows computers that have music playback software installed. The script will open the media file using whatever your default app is for that file.

## How to Install

First, make sure you can run PowerShell scripts on your computer. (Do a quick Google search on "How to run a PowerShell Script.)

Download the scripts and place them in a scripts folder. The name of the scripts folder doesn't matter. By default, the script expects you to put the folder with the scripts in the root folder of your music library, which will be your output folder. The output folder is configurable (which we'll do in a second).

Here's an example of default folder setup. Again, the script folder name doesn't matter, and it's relation to the Music Library Folder is configurable.

```
/Music Library Root Folder
    /__scripts            <-- Put all script files here.
    /__Inbox              <-- Music files to be sorted.
    /_Folder Name         <-- Folders ignored by rating sort mode start with "_"
    /Genre 1 - Tag 1      <-- Script will create these directories when necessary
    /Genre 1 - Tag 2      <-- ''
    /Genre 2 - Tag 1      <-- ''
```

Once you've figured out a directory structure you are comfortable with (the location of the script folder, the inbox folder, and the root music library output folder), configure those location in the `sorter-config.ps1` file.

Next, configure the genres, tags, and special category names you want to sort your songs into.

The sorting of music follows this pattern:

```
/Genre - Tag/Rating/Song Name.ext
```

## Genre

Pretty self explanatory. It's a genre of music, but more specifically, it's your top-level sorting. It is the prefix for the folder name.

## Tag

A tag is the suffix for the folder name. I generally use emotions or stages of a story arc as the tag, as I find them more useful for how I edit video and podcast.

## Special Category

These are special categories or genres that don't have tags assigned to them. This is very useful for when I feel like a song is perfect for a specific project, or fits into a genre that doesn't have much in the way of emotional breadth (such as Gregorian chant).

## How to Configure

As you scroll down the `sorter-config.ps1` file, past the folder setup, you'll see arrays of genres, tags, and special categories. This is where you can figure them to your liking.

Here's an example of one of the entries in the arrays.

```powershell
("1", "Ambient", "DarkCyan"),
```

The first value is the string that you need to type in order to tag the song with that genre/tag/project. Multiple characters are allowed. In this example, the user has to press `1` and then `ENTER` to tag the song with the Ambient genre.

The name of the genre/tag/category is the second item in the array.

The third item in the array is the color that the text will appear in the interface. You can only use the following colors in PowerShell:

```
Blue      Green      Cyan      Red      Magenta      Yellow      White
DarkBlue  DarkGreen  DarkCyan  DarkRed  DarkMagenta  DarkYellow  Gray
                                                                 DarkGray
```

I consider DarkBlue and DarkGray to be too dark with the default PowerShell theme. If you are using a terminal such as ConEmu with custom color scheme you'll have to decide on your own which colors yous shouldn't use.

## Running the Script

Once you have that configured you can start running the script.

To run the script in Windows, right-click on the `sorter.ps1` file and select `Run with PowerShell`.

You will be prompted to run the script in different modes.

Full mode does full sorting, pulling songs in from your inbox folder and sorting them based on genre, tag, special categories, and ratings.

The other two modes (tag and rating) are for pre-existing libraries that need further sorting. In tag mode, it assumes you have your top-level sorting done, but need tag and rating sorting. In rating mode, it is assuming you have your top- and second-level sorting done, and only need rating sorting. You will be prompted to type in the folder that you want to sort.

When you are sorting songs, you can assign multiple genres, tags, and special categories. The song will be duplicated into these folders. You can only have one rating value per song.

Once the song has been copied, it is removed from your inbox.

## What is the `empty.flac` file for?

This is a blank file that is played so that the target song in the file system is freed up so it can be manipulated. It's a poor man's way of releasing that file because we don't have a dedicated player where we can tell to stop playing. You can configure this to be any audio file you want, but it should be long enough so that any file operations have time to complete.

---
