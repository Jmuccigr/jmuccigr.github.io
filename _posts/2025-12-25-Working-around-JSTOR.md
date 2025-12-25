---
title: "Working around JSTOR"
author: John D. Muccigrosso
date: 2025-12-25
tags: 
    - AppleScript
    - pdf
published: true
---

tl;dr In this post I describe two AppleScripts I use to get around unexcusably poor delivery by [JSTOR](https://jstor.org/) (which I otherwise love to use).

First of all, a very merry Christmas to everyone!

Now to the business at hand...

I finally got around to working up some quick AppleScript droplets (are we still calling them that?) to speed up my workflow when JSTOR articles are involved. I've written about this before (check out the "PDF" tag), but basically I'm trying to solve two problems that JSTOR articles (article = any individual thing on JSTOR) typically have:

1. The page numbering is off by one. This is really two problems. The first is that JSTOR knows that correct start page for a given article, but it assigns that number to the cover page that it sticks on the front of every article on the site. I don't mind that cover page, but it shouldn't be numbered at all, much less treated as the first page of an article. The second part of this problem is that JSTOR frequently prefixes the page labels (that's what this numbering is called in PDF-speak). So you'll have an article that beings on page 45 of a journal and JSTOR has slapped "p. 45" on as a label. Bad JSTOR!
2. The OCR stinks. In theory having each article you download already include text you can copy is awesome. The tools for this go under the name of "optical character recognition." Unfortunately JSTOR's OCR is often very poor. Text areas seem to extend into margins or they stretch across columns or they don't line up well with the visible text. This isn't always an easy thing to do well, so I'm sympathetic, but when my amateur efforts with open-source software produce noticeably better results, not overly so.

## My scripts

I've written two AppleScripts to get around this. To work they use open-source tools you'll have to load onto your computer. I use [Homebrew](https://brew.sh/) to accomplish this, but there are other options. Both scripts are in my [GitHub repository](https://github.com/Jmuccigr/AppleScripts), along with other useful (I hope) things.

1. [PDF JSTOR page numbers](https://github.com/Jmuccigr/AppleScripts/blob/master/PDF/PDF%20JSTOR%20page%20numbers.applescript) takes a JSTOR file and inserts new labels into it. Specifically the first page gets labelled "Cover" and the rest are labelled starting with whatever page number you enter, using Arabic numberals. In my experience this covers the vast majority of cases, especially those of journal articles. If you need to do some more sophisticated page numbering, maybe because of plates, you can check out [this other script](https://github.com/Jmuccigr/AppleScripts/blob/master/PDF/Renumber%20PDF.applescript) which lets you use other kinds of labels and add multiple ones. You'll need `qpdf` for this script.
2. [PDF redo OCR](https://github.com/Jmuccigr/AppleScripts/blob/master/PDF/PDF%20redo%20OCR.applescript) takes any PDF and redoes the OCR on it. You have the option of telling it to ignore a number of pages before doing the OCR. This allows you to skip JSTOR's cover page and just do the remaining ones. You can also start on page 1 for non-JSTOR pages, so the script is a bit more versatile. You'll need to know the three-letter language codes (eng, fra, deu, ita, etc.) and have `qpdf` and `ocrmypdf` installed.

And that's it! Enjoy and let me know if you might find something else useful.
