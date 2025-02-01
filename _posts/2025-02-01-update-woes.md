---
title: "Update woes: Dovecot & local mail"
author: John D. Muccigrosso
date: 2025-02-01
tags:
  - technology
  - cli
  - mac
---

tl;dr The latest version of the IMAP server Dovecot (2.4.0) makes breaking changes to the format of the configuration file. I get some help to fix mine on my macOS laptop.

## Dovecot

I'm not sure I've mentioned this before in the blog, but I use the local mail server on my laptop to help keep track of some stuff. One big use is with [urlwatch](https://urlwatch.readthedocs.io/en/latest/) which runs in the background and monitors websites for changes. When it detects something, it sends me an email with a link. Now that I've been messing around more with Python and [BlueSky](http://bsky.app/), I have my scripts send an email for errors I need to do something about.

I use [Homebrew](http://brew.sh/) to install and update a lot of software, including the part of the local mail set-up (IMAP server) that manages the local mailbox, [Dovecot](https://www.dovecot.org/). I'm not as attentive as I should be to the updates that get pushed out through Homebrew, by which I mean I usually pay **no** attention at all and just let them go through. Occasionally that bites me in the ass, as the recent update of Dovecot to version 2.4.0. As I now know, that update requires some changes to the local configuration file and [the docs](https://doc.dovecot.org/), while helpful to a degree, don't quite spell everything out (even the guide to a [quick set-up](https://doc.dovecot.org/main/core/config/guides/quick.html)).

In the end, I got the key information from the [user email list](https://www.dovecot.org/mailing-lists/) and all is well again. Below is my conf file with the identifying username in \<angle brackets\>; replace it with your own username. Running dovecot with the command `sudo dovecot -F` will get you the errors it runs into and is more helpful than the `launchctl` method I normally use to run it in the background.

The specific issues were:

1. `default_vsz_limit` needs to be set to "unlimited", not "0", as you will find on-line in some older posts.
2. I use Maildir and that configuration changed from 2.3. See below for what works for me.
3. Ditto for the password where I just use plaintext, since it's running locally. I may try something more secure in the future. Again, see below for my configuration, taken right from the docs which also provide the format for the referenced [password file](https://doc.dovecotpro.com/3.0.1/core/config/auth/passdb.html).
4. I had changed the default internal user and internal group. Those settings still worked fine, though the docs recommend a different set-up and I had to put them back in after some experimenting. You may find that you need to configure some groups, in which case the dovecot command just above will tell you.

Lessons learned? First, the Dovecot community is very helpful. Second, maybe I should start paying more attention to Homebrew updates. The problem there is that I don't know of an easy way to find out when updates are going to make breaking changes, as this one did. I wouldn't have expected that for a point change (2.3 to 2.4), and I've got enough packages in Homebrew that staying up to date with each is more work than I want to put in. I could simply only update when I absolutely need to, I suppose. Something to think about.

## My local.conf file

This currently works for me with dovecot 2.4.0 and macOS 13.6.9 (Ventura).

```
# Start new configs with the latest Dovecot version numbers here:
dovecot_config_version = 2.4.0
dovecot_storage_version = 2.4.0

auth_username_format = %{user|lower}
default_vsz_limit = unlimited

# Enable wanted protocols:
protocols {
  imap = yes
  lmtp = yes
}

mail_home = /Users/%{user}
mail_driver = maildir
mail_path = ~/Maildir

mail_uid = <username>
mail_gid = admin

default_login_user = _dovenull
default_internal_user = _dovecot
default_internal_group = mail

# Setting limits.
default_process_limit = 10
default_client_limit = 50

# By default first_valid_uid is 500. If your vmail user's UID is smaller,
# you need to modify this:
#first_valid_uid = uid-number-of-vmail-user

namespace inbox {
  inbox = yes
  separator = /
}

passdb passwd-file {
  passwd_file_path = /Users/%{user}/passwd
}
```
