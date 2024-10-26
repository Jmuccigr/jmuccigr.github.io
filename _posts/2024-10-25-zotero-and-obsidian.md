---
title: Zotero and Obsidian
author: John D. Muccigrosso
date: 2024-10-25
tags:
  - Obsidian
  - pandoc
  - Zotero
  - markdown
---

I've updated to the latest version of Zotero and switched back to Obsidian for note-taking. Here are some updates and links to resources. I'm not taking the time here to explain the basic workings of either Zotero or Obsidian.

## Zotero

I've been using [Zotero](https://zotero.org/) for years to handle my bibliography. Love it. Teach it to my students. Use it in my classes. With the old version (pre-7), I used to use Zotfile and other plugins to create notes from PDF annotations. It was never great for me, and changes to various tools in that workflow had made me less and less satisfied.

Then in January came version 7 of Zotero, which broke a bunch of those plugins and also offered more options for note-taking from within Zotero, so I was more or less forced to re-visit what I was doing, which was a good thing.

First I should say that I don't really care for the expanded capabilities for note-taking within Zotero. It seems to work fairly well, but requires you to work from within the app, and it doesn't make "standard" annotations to PDFs. You can force it to when you export a PDF, but that's not really how it's designed to work. Since I have a nice reader app for my iPad that I like to use, I've no great desire to change that part of my workflow. I'm also a little wary of feature-creep. Zotero's a great bibliography tool. I don't quite see the need for it to expand to note-taking.

## Note-taking

I've also been using [Markdown](https://www.markdownguide.org) to take notes for years. Teach it to my students (though with less enthusiasm), and use it for most of my writing, adding in [pandoc](https://pandoc.org/) for creating "final" products as PDFs or (shudder) Word docs. I even use it to create more mobile presentations that aren't tied to Microsoft. (Follow the tags below for some previous posts on those topics.)

With the arrival of the new Zotero, I went back to using [Obsidian](https://www.obsidian.md/) for my notes. I had used it a while back, but it seems a much better tool than I remember and there are some utilities that make it work pretty well with Zotero to boot. Since my existing files were already in markdown, it was easy to just start using Obsidian with them. The rest of this post describes some of my workflow and provides links to some scripts I'm using.

## The Basic Set-up

I keep my note files in one folder (which is one "vault" in Obsidian-speak) in iCloud. This way I have access to them from any of my devices. There are a lot of them, but since they're just text, they don't take up a lot of room in the cloud.

Zotero organizes the PDFs and other files associated with the articles and books it keeps track of. Whereas before I was keeping notes within Zotero, I now keep them in the vault and name them according to the Zotero citation key, which is managed with the [Better BibTeX plugin](https://retorque.re/zotero-better-bibtex/). That gives me a bunch of files with names like "@Muccigrosso-2010". That's a little ugly and not helpful if you want to look directly for something by title, but it does mean that it's very easy to link to them from within Obsidian and also to grab info from Zotero. Those titles are also fairly short and have no spaces in them. From within Obsidian I use the community plugin [Front Matter title](https://github.com/snezhig/obsidian-front-matter-title) to show the actual entry title in most places, instead of the citation key. This works because all my notes have yaml headers on them that include this title.

Zotero is now quite good at reading annotations out of PDFs (which are mostly what I have for its entries), and once it has read a PDF, it stores the annotations in its own database. Since I'm not using Zotero to keep my own notes, I extract those annotations from Zotero and put them into files in the Obsidian vault.

So that's the big picture.

## Making the most of it

### Getting annotations from files in Zotero

Since Zotero 7 broke a bunch of tools that I had been using, I went looking for a new workflow and that's how I hit upon Obsidian. There's a plugin, [Obsidian Zotero Integration](https://github.com/mgmeyers/obsidian-zotero-integration), that talks to Zotero and can extract the annotations from its database, putting them into a file. It will use a customizable template to create the file and has a lot of options to play with. I discovered it through this [very nice post](https://medium.com/@alexandraphelan/an-updated-academic-workflow-zotero-obsidian-cffef080addd) by Alexandra Phelan. She shared her template and I spent some time playing with it to create something that fit my needs. One of the changes I made was to the section that grabs the annotations. Zotero will store both the annotations it finds in the PDF file itself, as well as its own reading of those annotations. (Such is the nature of PDFs that when you have files that are just "bags of images" with overlaid text, which happens with pretty much any born-paper scanned material, reading the right text can be a little tricky.) As I noted above, Zotero is generally pretty good at this task, so I want to extract both versions, compare them, and then keep the better one. This is a little extra work, but it's worth it to me.

My template also pulls a bunch of other info from the Zotero entry, including basic bibliographic info, links to any related entries in Zotero, and tags I've put in there. Feel free to use or modify [my template](/resources/zotero_import_from_both.md.txt). Alexandra's post has more info and links to resources for understanding the syntax.

### Using tags

I like to use tags to label Zotero items, though I haven't always been diligent about doing that. Right now I'm trying to use labels that provide the overall topic(s), time period, and location. The tricky part is being consistent, of course, so I've been cleaning things up and trying to come up with a reliable system that isn't too hard to remember.

The tags come over in the import via the plugin I just described. The problem is that running the import for every item in Zotero isn't trivial. You have to do it manually, one at a time. Also for most items, there isn't any attachment with annotations. Sometimes there's no attachment at all, like for items that I've just got bibliographic info for and sometimes I haven't (yet?) annotated the text. For those the return on running an import is limited. At the same time, it's helpful to have Obsidian be aware of those items, so that, for example, I can search within Obsidian for any items that refer to a topic I'm interested in.

To make this happen I wrote a couple of scripts in bash for my Mac. The first one uses a automated export from Zotero. Every time I walk away from my computer for a few minutes with Zotero open, this report gets generated, thanks to the Better BibTeX plugin mentioned above. It's in json format and includes all the usual info as well as the tags on an item. [The script](https://github.com/Jmuccigr/scripts/blob/master/zot2obsidian.sh) reads this and then compares it with the files in the vault, completing a few tasks:

1. Importantly vault files that are generated by the Obsidian Zotero integration plugin are left alone because checking those is complicated. The only exception is in the next step.
2. Vault files that don't exist in Zotero get deleted, as long as they weren't generated by the plugin, in which case they get flagged for examination. These "orphans" are likely due to changes to citation keys and therefore file names.
3. Zotero items that don't have a vault file get one. These files are pretty basic with just title, tags, and citation key. The citation key always includes the year, so the date is in there by default. This allows Obsidian's graphing function to include all these items, including the tags which I like to see.
4. Vault files that are different from Zotero, but still the same size, get replaced automatically. For me, these are typically just minor changes to tags, like removing capitalization.
5. Vault files that are different from Zotero and not the same size get listed, though there's an option to overwrite them. Most of the time for me these are due to changes to tags, though sometimes I've fixed a title or author name.
6. Finally vault files with big differences are left alone and listed for examination by me. This doesn't happen too often.

The effect of this script then is to populate the vault with short note files, essentially replicating all my Zotero entries, and keep those up to date, at least with respect to tags and title. Note that there are a few options you can use, so try running the script with the "-h" flag to get details.

The remaining thing to worry about is changes to the files that **are** generated by the plugin. Most changes with Zotero really need a re-import via the plugin, which can be handled manually. However any changes to tags, which are listed in the yaml front matter of each file, can be fairly easily detected. That's what [the other script](https://github.com/Jmuccigr/scripts/blob/master/zotero_check_tags.sh) does. Non-plugin files are easy to identify automatically, and therefore ignore, because the plugin puts some unusual text into the yaml. Rather than change the tags automatically, I have the script just list the files and their tags. Since the files all live in one folder, I can use a basic multi-file search-and-replace operation in BBEdit to do the work.

## Wrapping Up

There it is. I'm looking forward to updates to some Zotero plugins, but feel pretty good about this workflow that I've now got. Obsidian is a more than decent markdown editor and has some great features via plugins. Zotero continues to work very well for me, even if I'm not using the new note-taking capabilities.
