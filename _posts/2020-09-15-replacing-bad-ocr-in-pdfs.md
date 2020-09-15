---
title: Replacing bad OCR in PDFs
author: John D. Muccigrosso
date: Tuesday, 15 September 2020
tags: 
    - qpdf
    - ghostscript
    - cli
    - technology
    - pdf
---


Besides the documents I've scanned myself, I often get ones that someone else has scanned and put into a PDF. Typically these PDFs are of the "bag o' images" variety, and often they've got problems. These kinds of PDFs can be distinguished from the kind which contain text as their main component, like the ones you make when you use your word processor to "print to PDF." Those are mostly made up of the text from your document and are fairly small (unless you've put some images in there).

The ones I'm talking about here tend to be much larger, since every page is its own image, and have had the text added to them after the scanning has taken place (though often your scanner does all this in one go, so you don't see any intermediate steps). The process of adding the text uses "optical character recognition" (OCR), and is often done is a fairly automated way. Sometimes the automation works well, and sometimes it doesn't. When it doesn't, I often want to redo the OCR, but leave the images alone. That's what this post is about.

A couple of words on PDFs of this kind.

You can imagine these PDFs as having layers. The page image is the bottom layer and the text sits in a layer on top of that. This text layer is invisible, so you can't see it, but ideally the creation process has overlain each letter in the image with an invisible version of that same letter, with roughly the same dimensions. This means that when you use your cursor to highlight a word in the image, it's actually highlighting the invisible text, since that's the top layer the cursor is working on.

You might imagine where this all could go wrong, but it's worse than you think. For example OCR often doesn't include the spaces in the text, so that, for example:

`Arma virumque cano Troiae qui primus ab oris`

is just bunch of boxes surrounding the letters of those 8 words and the software has to decide where the word breaks fall by how far apart the boxes are. Apps will disagree about this, so you might find better results with, say, Adobe Reader than you will with MacOS Preview (this is in fact often the case). PDFs also don't have any sense of page layout, so if a few of those text boxes aren't perfectly aligned, the app might think they're on different lines and there's no way to tell it otherwise. You can also sometimes see the result of all these boxes in some PDFs when you highlight text and don't get nice elongated rectangles, but a bunch of little ones, sometimes ones that vary by the letter.

(To be honest PDFs are actually **a lot** more complicated than I just described and I'm not going to pretend I understand that complexity very well, except to say that I know enough to be humble and will happily take corrections on what I just wrote above describing PDFs.)

Given all this it's not surprising that you sometimes find PDFs that come with decent enough images, but crappy OCR text (which I'm must going to lazily call "OCR" here). Maybe the OCR leaps across two columns of text, ignoring the break between them. Maybe the OCR runs off the right side of the column towards the edge of the page (looking at you, JSTOR). Maybe you just can't seem to highlight the text you want as the cursor makes sudden jumps of two or three words at a time, even across to the next line. (See the image for an example of the first two problems in the same document.) In these cases I don't want to work up the images; I just want new OCR.

![JSTOR scan showing two typical OCR problems](/images/jstor_ocr.jpg)

So I wrote a fairly straightforward script for that, which works fairly simply in outline:

1. Remove all the text from your PDF.
1. Copy this new file and re-run the OCR on the copy.
1. Strip the images out of this OCR'ed version.
1. Overlay the now image-less OCR on top of the now text-less PDF.
1. Enjoy your new PDF.

This relies on a few other resources:

1. [qpdf](http://qpdf.sourceforge.net): handy utility to do basic manipulations of PDF files, like overlaying one on the other or (re)assembling the pages of them. (I'm trying to use this instead of [pdftk](https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/) which seems to have some issues in increasing PDF size.)
1. [ghostscript](https://www.ghostscript.com): an interpreter for PDF (and for the PostScript language), which I use to remove the text and images from the PDF.
1. [ocrmypdf](https://github.com/jbarlow83/OCRmyPDF): this is a pretty nice bit of software by someone who knows a lot more about PDFs than I do. It adds OCR to your PDF, as the name suggests, but often also modifies the underlying images, so I use it to create the OCR, but then get rid of the non-OCR portions.

This seems to work fairly well, which is good because I need it surprisingly often. I've also put in an option to leave the first page of the original alone. This is for times when the source (like JSTOR) sticks a leading page in front of the pages of the document you're actually after. Since that's a PDF page that's generated with lots of "real" text, the step that removes all the OCR text also removes the text from this page, making it fairly useless.

Enjoy!

PS I've talked about some of my approaches to the other type of problem where the underlying images are inadequate in [a few other posts]({% link blog/tags.md %}#scanning).
