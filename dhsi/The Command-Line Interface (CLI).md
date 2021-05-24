---
author: John D. Muccigrosso
title: The Command-Line Interface (CLI)
date: Saturday, 14 January 2017
css: /Users/john_muccigrosso/Documents/github/local/css/clean_notes.css
...

# Using the Command Line Interface

## Intro to the CLI

1. The **command-line interface** is another way (pre-1984 Apple Macintosh) to access your computer (or a remote one, in this case). It's also called the **terminal** after the machines (called "terminals") that were used to access big mainframe computers back in the 20th century.
1. You must type in commands to do things, including running programs or looking at files and folders.
1. There's no `undo`, so be careful!

### Using commands

1. Type a command and hit the return key.
1. Try `date` and `whoami` to see what output you get.

### Playing with the file system

#### Directories (a.k.a. folders)

1. Whenever you're logged in, you are located in a folder on the computer, but we're going to call those folders *directories* now.
1. Where are you now? Try `pwd` for "present working directory".
1. Are there files in this directory? List them with `ls`.
1. Let's get some more info on them by adding an option (or switch or flag) to the command: `ls -l`.
1. Let's make another directory inside this one (a "subdirectory") and call it "practice": `mkdir practice`. (Guess what `mkdir` is short for.)
1. Let's change the directory we're in to that new one: `cd practice`.
1. Let's list the files here with the more complete method `ls -al`.
	- There are no files yes, but still you can see two entries with dot names. Those are shorthands for the current directory (`.`) and the directory that contains it (`..`).
	- So you can use the shorthand to move back to the containing directory: `cd ..`.
	- Now go back to the "practice" directory.

#### Files

1. Let's make a new file in "practice". There are lots of ways to do this, but the command `touch` will update the modification date on any file, creating it if it doesn't yet exist, so try `touch temp.txt`.
1. Copy it via `cp temp.txt newtemp.txt` and rename it via `mv newtemp.txt test.txt` (`mv` is for "move"). Notice how the first name is the existing file and the second is the new one. That happens a lot.
1. Now remove it completely with `rm newtemp.txt `. NB No undo!
1. There are several ways to edit files within the CLI. Easiest perhaps is with the command `nano <filename>`. This will open the file `<filename>` in a simple text editor. You can move around with the arrow keys and when you're done, use the commands at the bottom. Control-X will exit and if you've made changes, it will ask if you want to save them and then with what name.
1. To look at your files, you also have several options:
	- `cat` (for "catalogue") will scroll the entire file across the window without stopping.
	- `head` will show the first 10 lines of the file.
	- `tail` will show the last 10 lines.
	- `less` will show you one screenful at a time until it's gone through the whole file. Use the spacebar or arrow keys to move, and `Q` to quit at any time.

### Handy commands

1. `man` <command> will show the how-to file for any command (like a "manual").
1. `history` will show the last several hundred of your commands. Use `!` followed by the number of the command you'd like to run again to re-execute it, e.g., `!234`.

### Other goodies

1. The `tab` key will try to autocomplete a filename or command when it can.
1. Hitting the up arrow will bring up the previous command. It's like stepping through `history`.
