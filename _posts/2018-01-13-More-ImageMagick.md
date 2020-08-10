---
type: posts 
title: ImageMagick - some more applescripts
author: John D. Muccigrosso
date: 13 January 2018
published: true
tags:
  - AppleScript
  - cli
  - imagemagick
  - scanning
  - technology
---

Following up on [my previous post]({% post_url 2017-10-16-ImageMagick %}) I've tweaked my existing ImageMagick applescripts and also added some new ones. As usual these are all posted in [my github repository](https://github.com/Jmuccigr/AppleScripts/tree/master/ImageMagick).

## The New Scripts

These new scripts fall into two categories:

1. One script that just deskews the image. (The convert parameter is 40%, for the interested.) I'll probably tweak this in the future so that it's configurable.
1. Four scripts that chop off a little on one side of the image and then add the same amount (in white) to the opposite side, in effect shifting the image in the first direction.

As in the other scripts, the original file is moved to the Trash and the new file is saved in its former place with the same name and then displayed via QuickLook, so you can check the results.

The shift scripts also have a second mode, activated by holding down the option key. This mode makes them more aggressive: they shift the image by 10% instead of the default 3%. In every case, the script also sounds your system *beep*, so you know that it's been activated (and you can let go of the key).

## Zip file

I've updated the zip file of a folder containing the scripts as applications.

![Contents of the zip file.](/images/trim_apps_2.png)

## The Future

It's nice to have these as applescripts, but changing parameters on the fly is a pain this way. I think these would work better inside a real MacOS app, so maybe I'll try to find somebody who can help with that.

Naturally let me know if something's not working.
