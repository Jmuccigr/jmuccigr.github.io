---
title: Working with location in MacOS Photos
author: John D. Muccigrosso
date: 2023-08-01
tags:
    - Photos
    - exif
published: false
---

I like to use Apple's Photos app to handle all my, uh, photos. It has a nice interface and it works really well with my iPhone (where I take most of my photos). It also imports photos from my camera SD cards, so it's a nice all-in-one solution.

Here's what a series of photos show for GPS metadata when they're exported from Photos via the File menu's "Export" function:

```
GPS from exiftool - 1.jpeg
GPS Version ID                  : 2.3.0.0
GPS Latitude Ref                : North
GPS Longitude Ref               : East
GPS Latitude                    : 43 deg 50' 36.67" N
GPS Longitude                   : 10 deg 30' 27.07" E
GPS Position                    : 43 deg 50' 36.67" N, 10 deg 30' 27.07" E

GPS from exiftool orig - 1.JPG
GPS Version ID                  : 2.3.0.0
GPS Latitude Ref                : North
GPS Longitude Ref               : East
GPS Latitude                    : 43 deg 50' 36.67" N
GPS Longitude                   : 10 deg 30' 27.07" E
GPS Position                    : 43 deg 50' 36.67" N, 10 deg 30' 27.07" E

GPS only in Photos - 1.jpeg
GPS Latitude Ref                : North
GPS Longitude Ref               : East
GPS Horizontal Positioning Error: 1 m
GPS Latitude                    : 43 deg 50' 38.82" N
GPS Longitude                   : 10 deg 30' 4.86" E
GPS Position                    : 43 deg 50' 38.82" N, 10 deg 30' 4.86" E

GPS only in Photos orig - 1.JPG
GPS Version ID                  : 2.3.0.0
```

The first three (as their names suggest) are exported with the "Location Information" checkbox checked.
