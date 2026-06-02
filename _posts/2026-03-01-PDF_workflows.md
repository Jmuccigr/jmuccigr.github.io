---
title: "My PDF workflows"
author: John D. Muccigrosso
date: 2026-06-02
tags: 
    - ImageMagick
    - pdf
    - pdftk
    - AppleScript
    - technology
published: true
---

tl;dr I've been using a bunch of scripts and command-line tools to make PDFs work better for me. This posts collects them into one place.

Nearly all written scholarly material that I read shows up digitally as PDFs. Yeah, there's the occasional ePub, but those are very, very rare. So over the years I've been honing my PDF-manipulation skills to make *effective* use of these files easier. It's really amazing how big organizations can produce really poor PDFs, or just not take advantage of the benefits of the format. I've blogged a bit about these (check out the "[pdf](/blog/tags#pdf)" tag), but I thought it might be worthwhile putting it all in one place.

## Tools

There are a few software tools that you'll need to make these work. They're all free. You could also do a lot of these with non-free programs, but I don't. Here's a short list:

- [qpdf](https://qpdf.sourceforge.io/): a command-line tool that does a lot of things to PDFs
- pdfimages: part of the [poppler library](https://poppler.freedesktop.org/); a command-line tool to find out about and extract images from PDFs
- [ocrmypdf](https://github.com/ocrmypdf/OCRmyPDF): a command-line tool to apply OCR to PDFs (also compresses images) 
- [pyPDF](https://pypi.org/project/pypdf/): a Python package (you'll need Python, too, of course)
- PDF Toolkit+: a macOS app that bundles a few PDF utilities ([App store link](https://apps.apple.com/us/app/pdf-toolkit/id545164971))
- [Ghostscript](https://www.ghostscript.com): an interpreter for the PostScript language and PDF files (good chance this is already on your computer)
- [ImageMagick](https://imagemagick.org/): powerful image-manipulation software
- Preview: the built-in macOS PDF reader (Windows users, you're on your own for platform-specific stuff!)

For all of these, there is either official on-line documentation or plenty of help to be found just a search away.

## Improving existing PDFs

This first category includes some ways to improve an existing PDF.

### Eliminate pages

I like to delete unneeded pages from PDFs. These could be simply extra title pages or unneeded internal pages from a scan. Mac users can do this from within Preview. I typically use qpdf for it. For example, to make a new file:

`> qpdf "filename.pdf" --pages . 2-z -- "new_filename.pdf"`

or to replace the existing PDF with the same effect:

`> qpdf --replace-input "filename.pdf" --pages . 2-z --`

This will reduce the PDF to the range specified after the "." (which means "the filename I just entered," while the "z" means "last page.") qpdf counts the pages of a PDF starting from 1. A nice feature of qpdf is that, if it has a problem doing its work because the PDF is ill-formed in some way—and that happens a fair amount of the time—it will leave a copy of the original input file when you tell it to replace it, so you're covered in case of damage. (Most of the time I find that the final file is fine.)

You can also use both these tools to re-order the pages. qpdf does this using the page range. For example, to reverse the order of pages 3 and 4 in the previous example:

`> qpdf --replace-input "filename.pdf" --pages . 2,4,3,5-z --`

### Merge PDFs

I use this technique when I've got to send somebody a few files that can safely be put into one or when I have to print multiple files by uploading them to a service.

`> qpdf "file1.pdf" --pages . file2.pdf file3.pdf -- new_file.pdf`

This creates a new file consisting of files 1-3 in that order. More granularity can be obtained by specifying ranges for the files:

`> qpdf "file1.pdf" --pages . file2.pdf 1 file3.pdf 2-z -- new_file.pdf`

In this case I've taken just page 1 from file2 and pages 2 to the end from file 3.

### Reduce filesize of images

Often I've come across a PDF that seems overly big for its contents. The problem here is often that the images in the PDF are bigger than necessary, either in terms of pixels (like a really big images reduced to a really small size on the page) or because of missing or inadequate compression. These can come from printing a webpage to PDF, for example. If I don't care about maintaining these images in their original format, I'll run the PDF through PDF Toolkit+ which has an option to reduce image size. It gives several options for reduction and will create a new file, so you don't have to worry about losing the original. Occasionally it can't do anything to the images, but in many cases it does reduce file size significantly.

If you have a file in which you want some, but not all, of the images to stay as they are (like a book cover with a fancy picture), you can combine this with the previous method to selectively merge the original and reduced-size files.

*NB* PDF Toolkit+ can also do a lot of the other things mentioned here, like reorder or eliminate pages, join files, and extract text and images. I don't use it for those things, so I can't say how well it does them, but in theory it can handle much of what you'd want to do with a PDF.

### Page labels

Paper documents generally have page numbers, typically printed on most pages of the document, and likely mostly made up of Arabic numerals, but also potentially including Roman numbers or other kinds of designations, like "Plate". So a ten-page document might have its page numbers run from 101 to 110. In PDF-land, these numbers are called "page labels", to be distinguished from the "physical pages" which are just the ordinal numbers of a page, 1-10 in our example.

Having the right page labels in a PDF can be handy for going to that page in your reader application, which will have some "Go to page..." command that uses the labels (if they're present). It also is useful if your note-taking process incorporates the label instead of the physical page.

The programmatic way to insert page labels in a PDF is a little weird. You need to go sequentially through the PDF starting from page 1 and indicate where a series with the same kind of labels starts and then re-start the sequence if the type of label changes (say, from Roman to Arabic numerals), or if the sequence is broken (perhaps when you have a PDF with the text of a chapter and endnotes that were placed at the end of the whole book). Labels can be blank or be prefixed with text, so you could have multiple pages with labels like "Plate I" through "Plate V". Label types include Arabic numerals, Roman numbers or Latin letters, both in upper- or lower-case, and blanks. All of these can be prefixed.

I've got two AppleScript droplets for this. The first asks for starting pages, the kind of labels, and any prefix. It will replace your existing file or create a new one in the same folder, as you choose. The other script assumes the first page is the "Cover" and the remaining pages are to be numbered sequentially from an Arabic numeral that you provide. I wrote this one (as you'll see from the name) to fix JSTOR files which routinely number documents as if there were no cover page. So a document that starts on page 85, say, will give that label to the JSTOR cover page and then have the actual pages of the original document off by 1 (86, 87, 88...). They'll also frequently insert a "p." in front of the label, which just gets in the way, IMO. These are available in my Github repository:

- [Renumber PDF.applescript](https://github.com/Jmuccigr/AppleScripts/blob/master/PDF/PDF%20Renumber.applescript)
- [PDF JSTOR page numbers.applescript](https://github.com/Jmuccigr/AppleScripts/blob/master/PDF/PDF%20JSTOR%20page%20numbers.applescript)

For all these AppleScripts on Github, I'll provide a link to the code, but you may just want to grab the zip file of the droplet. I also recently wrote a [post]({% post_url 2025-12-25-Working-around-JSTOR %}) on the JSTOR stuff. I find that I use these a lot, and not just because of JSTOR: lots of PDFs don't have any labels at all.

### Adding or fixing the text

One popular format for PDFs is a "bag of images" model, where, in its simplest form, each page holds a scan of a printed work. This contrasts with files where the text and images are directly embedded into the PDF. You can make these with the "print to PDF" functionality of your computer, for example. But the "bag" style is of course very common, not only for legacy work, but because it's what you get when you scan a document to PDF.

In order to make the text in these documents digitally acceptable, you need to apply optical character recognition (OCR) to it. If I'm doing this, I like to use the ocrmypdf package, available [on Github](https://github.com/ocrmypdf/OCRmyPDF). You'll need to install the OCR engine tesseract along with whatever languages you need it to "read", but it's pretty solid and will even do some compression on the images in your PDF to reduce file size (if you want). For files I get with the OCR already in them, I find they have varying quality and sometimes the quality is **so** poor, that it's worth redoing it (looking at you, JSTOR). Once again there are several free tools and I've written a couple of scripts to use them.

The first is a bash script that replaces the existing OCR. It's in my [GitHub repo](https://github.com/Jmuccigr/scripts/blob/master/redo_ocr_PDF.sh), of course. The second is an AppleScript (in my [repo](https://github.com/Jmuccigr/AppleScripts/tree/master/PDF)) that takes a file and redoes the OCR in it, though with a slightly different method. Both have options to leave alone the first page to make it easier to deal with cover pages (like those of JSTOR).

### Other

A couple of the other scripts in that AppleScript repo do some other, less frequently needed things to PDFs, like remove the metadata, filter out raster or vector images, or add visible page numbers to them.

## Getting stuff out of PDFs

### Images

It's often helpful to get images from a PDF. Sometimes you want the pages themselves, which can be there only as images, and sometimes you want an image from one of those pages. There are a few approaches here.

#### Conversion

For when you want or need to convert all or part of a page to an image, basically by doing a virtual scan of it, there's ImageMagick. One command can extract whatever pages you like in pretty much any image format. This can be useful when the images in a PDF are in an obscure format (rare, but some of the jp2 formats can be tricky to work with), or when the PDF is not behaving well for whatever reason. Honestly I don't do this very much. Here's the command though:

`> magick -units pixelsperinch -density 300 filename.pdf[0-1] output-%02d.png`

In this case, ImageMagick will create one png file per page, calling it "output-", with that name suffixed with a 2-digit number padded with zeroes. The output will be at 300dpi resolution and page numbers start at 0. In the case above, the output will be two files (one for each of pages 0 and 1) with names like "output-01.png". ImageMagick has other features that you can use to modify the images as they come out.

#### Extraction

In the situation where you want to get embedded images out of the PDF without converting them, there's pdfimage. This is part of the poppler set of tools. It is able to extract the images in the original format or convert them upon extraction. It can also give you just a list of the images, so you can see what you're dealing with. To avoid problems with conversion, I generally have it extract images in their original format:


`> pdfimages -p -f 1 -l 10 -all filename.pdf imagename`


This command will save each extracted image from pages 1 (**f**irst) through 10 (**l**ast) in a file called something like "imagename-1-000.png" where the first number is the page the image comes from (due to the "-p" flag) and the second number is a sequential number given to each extracted image. The image format (png here) depends entirely on its original format within the file. You can also force the images into a few formats, including png.

Extracting images can allow you to be sure you're getting the most faithful version of the image in the PDF. You can also use it to clean up badly scanned documents (if you put the time into cleaning the images).

In the case of scanned documents, there are some cases where the scan has been done in such a way that each page is represented by three separate image files (without going into detail). These can be tricky to deal with, but I often also find that one of the three files is a fairly faithful representation of the text on the page and the others are there to add color and detail. If you just want to get the text, these can often just be ignored.

### Text

For PDFs that contain actual text or are the bag-of-images with OCR described above, the `pdftotext` command (again from the poppler package) works well. By default it grabs the text from the PDF and saves it to a file with the same name in the same directory as the PDF, appending "txt" as the extension. There's no formatting, just the text. Like qpdf you can limit it to a specific run of pages. If you want to read the text in your terminal window, just give it "-" as the final argument. It's got some other nice features, if you need to be a little more careful or want to limit the text you're getting:

`> pdftotext -f 1 -l 5 filename.pdf -`

## Making PDFs

Most people probably know about the "print to PDF" functionality that comes with their OS these days, and this will cover a lot of use cases. These are great when you've got a word-processing or slideshow document that you want so share as a PDF, but really any time you need good control over document layout is a good time to use this method. The OS will typically include the text as text and not an image, too.

For other cases, the command I turn to most is img2pdf, available on [GitHub](https://gitlab.mister-muffin.de/josch/img2pdf). This takes an image and embeds it directly into a PDF. You have control over the size of the PDF, the borders around the image on the page, and a few other things. It's not fancy, but it gets the job done with the minimum of overhead. I'll use this to take cleaned-up page scans and put them into a PDF before running OCR on them. Here's an example command:

`> img2pdf image1.png image2.jpg --pagesize "A4" --border 2cm -o out.pdf`

I also like img2pdf because it's fast and I've embedded it in some AppleScript droplets to make it easier to use. My [Put images into PDF droplet](https://github.com/Jmuccigr/AppleScripts/blob/master/PDF/Put%20images%20into%20PDF.script) does what it sounds like: you drop some images on it and it puts them into a PDF, asking you for a few parameters, like page size and orientation.

## Wrap-Up

And that's my list. I'd love ot hear if you find any of this useful, or if you want to do something with PDFs that I don't go into here.
