---
type: posts 
title: ImageMagick - some applescripts
author: John D. Muccigrosso
date: 16 October 2017
published: true
tags:
  - technology
  - imagemagick
  - scanning
  - pdf
  - cli
---

I've been playing a lot (OK, too much) with [ImageMagick](https://imagemagick.org/) lately. It's a powerful command-line utility for manipulating pixel-based images. There are also libraries for your favorite programming language (like Python), too.

I've been using it to clean up scans of articles I have. While I'm working on a longer post on *that*, I thought I'd share a set of AppleScripts I've written and posted in [my github repository](https://github.com/Jmuccigr/AppleScripts/tree/master/ImageMagick).

## The Scripts

These scripts simply take a file via drag-and-drop and process it with ImageMagick. Currently they all assume that the IM binary is in `/usr/local/bin/`, though I should probably change that.

There are three sets of them:

1. Four scripts that trim a small amount from one of the sides of the image (3 or 4%) and then trim it.
1. Four scripts that blank out a square in one of the corners and then trim it.
1. One script that blanks out squares in all four corners.
1. One script that just trims the image.

In each case, the original file is moved to the Trash and the new file is saved in its former place with the same name and then displayed via QuickLook. This means that if the process is overly aggressive and removes too much of the image, you can easily go get the original from the Trash and put it back, overwriting the new file.

Each script also has a second mode, activated by holding down the option key. In the case of the trim-only script, this mode makes it more aggressive in matching pixels to be trimmed. In the case of the other scripts, it causes them to remove or overwrite *fewer* pixels. In every case, the script also sounds your system *beep*, so you know that it's been activated (and you can let go of the key).

## Zip file

I've also included a zip file of a folder containing the scripts as applications. I think it should look the same on your computer as on mine, as long as the view is set to show the icons. I've got them arranged geometrically to match the part of the image that each works on, like this:

![Contents of the zip file.](/images/trim_apps.png)

Naturally let me know if something's not working.
