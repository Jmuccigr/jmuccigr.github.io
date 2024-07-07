---
title: launchd and virtual envelopes in Python
author: John D. Muccigrosso
date: 2024-07-06
tags: 
    - cli
    - mac
    - Python
    - technology
...

I use *launchd* in MacOS to run a bunch of scripts automatically. Most of them are simple shell scripts (in bash; I never made the move over to zsh), but one uses the Python package urlwatch ([docs](https://urlwatch.readthedocs.io) and [github project](https://github.com/thp/urlwatch)) to monitor some websites. I use it when RSS isn't available or when I don't want to get email updates. It's very handy and not hard to set up and use.

Recently though it's become necessary to run Python within virtual environments which has meant some changes to my configuration. It's not a big deal for things I run directly from the command line, but it killed my launchd urlwatch job and it wasn't obvious (to me) how to fix it, so I spent some time yesterday figuring it out. Here's what I had to do, with all of my ignorant thrashing about omitted.

The console is your friend here as launchd logs errors to a file: `launchd.log`. It's a busy file, but I could easily find the entries I needed for urlwatch and they included this obvious problem:

`2024-07-06 20:01:43.791025 (gui/504/local.urlwatch [72988]) <Error>: Service could not initialize: posix_spawn(source) error: 0x2: No such file or directory`

Not so obvious was the file that it said didn't exist. After a little internet searching, I found a suggestion that it might be the (special) log file I was using in my plist. I checked that out and changed the permissions so that anyone could write to it, instead of just me.

No dice.

Now the plist doesn't include many files, so my options were limited. Here's the whole thing:

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>local.urlwatch</string>
	<key>ProgramArguments</key>
	<array>
        <string>/Users/username/.venv/bin/python3</string>
    	<string>/Users/username/.venv/bin/urlwatch</string>
		<string>--urls</string>
		<string>/Users/username/Documents/urls.yaml</string>
	</array>
	<key>RunAtLoad</key>
	<true/>
	<key>StandardErrorPath</key>
	<string>/Users/username/Library/Logs/john.log</string>
	<key>StartInterval</key>
	<integer>21600</integer>
</dict>
</plist>
```
Note that by this point in my bug-tracking, I had already made all the file references absolute and pointed to the version of Python in the virtual envelope directory. Nevertheless it had to be one (or more) of these that were causing the problem. On [StackOverflow](https://stackoverflow.com/questions/51636338/what-does-launchctl-config-user-path-do) (where was this when I was a young man?) was the goods on how to set the path in launchd, which I thought might be useful. So I added my .venv bin directory to the existing path, rebooted, and **boom**, all was well.

## Addendum

Turns out that the launchctl commands have changed a bit since the last time I messed around with this, so I needed to learn those as well. Naturally they're not quite analogous to one another. Grr.

Stop an agent: `launchctl bootout gui/504/local.urlwatch`

Start an agent: `launchctl bootstrap gui/504 Library/LaunchAgents/local.urlwatch.plist`

