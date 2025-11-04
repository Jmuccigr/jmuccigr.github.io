---
title: "Replacing Zotfile with Applescript for managing Zotero files"
author: John D. Muccigrosso
date: 2025-11-04
tags: 
    - AppleScript
    - Zotero
published: true
---

It's been a while now since the last major [Zotero](https://zotero.org/) upgrade (to version 7). It brought lots of nice things, but also broke Zotfile, a handy extension for managing the files (mostly PDFs) associated with entries. This post is about my attempt to replace the one feature I really missed.

I keep the files (mostly PDFs) associated with Zotero entries on my laptop—which of course is backed up in a couple of ways. However I often like to read and annotate those files on my iPad. Zotfile made it fairly easy to manage this by making a copy of the local file in a place where my iPad could access it and then moving that copy back to local storage when I asked it to. In my case this meant moving the file to a folder in my iCloud storage area which is accessible from all my devices. I was really missing this, so I decided to work up an AppleScript solution and put it into a Quick Action with Automator.

Now Zotero doesn't have an AppleScript dictionary, so I have to work directly with the files. I might be able to do something with Zotero's javascript capabilities, but this was an easier lift.

The basic steps are fairly simple:

1. Copy the local file to my iCloud storage.
2. Edit the iCloud version.
3. Move the edited version back from iCloud to its local folder.

I do a *copy* in step 1 because I want to hold onto a backup and a *move* in step 2 so that I don't leave a copy behind that might confuse me into thinking that I had forgotten about it.

Of course the details are a little more complex. For one thing, I want to be able to deal with either copy of the file, the local version or the iCloud one. Here then are the more detailed steps for the Quick Action which appears in the contextual (right/control-click) menu:

1. Work with only the first file in the case of a multi-file selection. (This is something I should be able to improve.)
2. Check whether the file is in local or iCloud Zotero storage.
3. If it's in local storage:
    1. Check whether there's already a copy in iCloud storage.
    2. If there is already a copy, ask whether to copy the file again or retrieve the copy from iCloud.
    3. If we need to make a copy, do that and store the original file location in the Finder note of the copied iCloud file. (This is potentially problematic if the note is already in use. However I don't really use the notes, so I'm not worried about it. I could make this more robust.)
    4. If it's a retrieval that's needed, do that and overwrite the local copy.
4. If it's in iCloud storage:
    1. Read the original file location from the Finder note and move this copy there, overwriting that local copy.

Along the way, I do a bunch of error checking. For example, I don't want to apply this to files that aren't in my Zotero storage locations; I don't want to overwrite a file that already been copied to iCloud; and so on.

Finally the script gets put into an Automator workflow. There I use the standard Automator template to "receive the current file" and feed it to the AppleScript. The start of the Quick Action looks like this in Automator:

{% include image.html 
    src="zotero_as.png"
    alt="Start of Automator flow"
%}

I've been using this for a few weeks now and so far, so good. I do need to get to the file in the Finder either via Zotero's "Show in Finder" function or by going directly to the iCloud folder, but that's not a big deal. I'll probably get around to making things a little more robust, as I noted above, but I'm pretty happy with the way it's going.

Here's [the script](https://github.com/Jmuccigr/scripts/blob/master/zotero/Mange%20Zotero%20file.applescript) in my GitHub repo. You'll have to tweak the path for yourself, so I'm not including the Automator file.

If you're looking to replace the ability to quickly add and manage files in Zotero, I find the [Attanger](https://github-com.translate.goog/MuiseDestiny/zotero-attanger?_x_tr_sl=auto&_x_tr_tl=en&_x_tr_hl=en&_x_tr_pto=wapp) utility useful.
