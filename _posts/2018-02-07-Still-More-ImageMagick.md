---
type: posts 
title: ImageMagick - still more applescripts
author: John D. Muccigrosso
date: 7 February 2018
published: true
tags:
  - technology
  - imagemagick
  - scanning
  - cli
---

Following up on [my previous follow-up]({% post_url 2018-01-13-More-ImageMagick %}), I've tweaked the ImageMagick applescripts that shift images so that they can **erase** a strip. As usual these are all posted in [my github repository](https://github.com/Jmuccigr/AppleScripts/tree/master/ImageMagick).

## The New Scripts

These four scripts are minor tweaks to the set that chop off a little on one side of the image and then add the same amount to the opposite side. Now, when you hold down the command key, they chop off that strip and add a new, white strip right back in the same place, in effect erasing the strip from the original image. The scripts will also beep twice to let you know you've activated this mode.

As in the original scripts, the original file is moved to the Trash and the new file is saved in its former place with the same name and then displayed via QuickLook, so you can check the results.

The scripts still have that second mode that makes them more aggressive, activated by holding down the option key: they erase a strip that's 10% of the image instead of the default 3%. Since this mode also sounds your system *beep*, you'll hear three beeps if you hold down both the command and option keys.

## Zip file

I've updated the zip file of a folder containing the scripts as applications. It still looks the same.

![Contents of the zip file.](/images/trim_apps_2.png)

Naturally let me know if something's not working.
