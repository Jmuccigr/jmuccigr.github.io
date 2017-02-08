---
author: John D. Muccigrosso
title: The CLI, Zotero, and Pandoc
date: Saturday, 14 January 2017
css: /Users/john_muccigrosso/Documents/github/local/css/clean_notes.css
...

# The CLI, Zotero, and Pandoc

Pandoc can not only convert between various file types, it can also read citations from a bibliography file and convert them to the format you choose. (Technically it's not pandoc that does this, but a "filter" called *pandoc-citeproc*.) Pandoc can also create footnotes. Here's how to do both.

## Footnotes

There's a nice section on footnotes in the [pandoc User's Guide](http://pandoc.org/README.html#footnotes). The simplest thing to do is to frame the note identifier with square brackets and then follow up somewhere later in the text with the note itself, preceded by the identifier. Note the required carat `^` before the identifier text. So, to borrow the guide's example:

```
Here is a footnote reference,[^1] and another.[^longnote]  
  
[^1]: Here is the footnote.  
  
[^longnote]: Here's one with multiple blocks.  
  
    Subsequent paragraphs are indented to show that they
belong to the previous footnote.
```

pandoc will number the footnotes in order, so you can use any text you want as the note identifiers (here, `1` and `longnote`). This makes it easy to label the note with something sensible that makes it easy to remember what it refers to.

A second way is to use an in-line note which has no identifier. Again, from the Guide:

```
Here is an inline note.^[Inlines notes are easier 
to write, since you don't have to pick an identifier 
and move down to type the note.] See how it interrupts the flow of the text?
```

You can use both methods in the same document, so pick whichever you prefer.

- Assignment: Add a few footnotes to your existing markdown document and make sure pandoc handles them as you expect.

Now for citations...

## Setting up citations

### Zotero

> *NB* You should already have stand-alone Zotero running with the [Better BibTeX extension](https://zotplus.github.io/zotero-better-bibtex/) added with the "Show citekey..." option checked in its **Citation** preference.

To use citations, you'll need a text file containing your citations in a special format. Fortunately we can set up Zotero so that it automatically exports such a file whenever you make a change to your library. Pandoc will then read this file in order to complete the citations you enter.

1. In Zotero, choose "Export Library" from the **File** menu.
1. In the dialog box that opens, select the **Better CSL JSON** format.
1. Click **OK** and select a destination for the bibliography file. (I use my Documents folder.)
1. Once the export finishes (should be a few seconds), open up the preferences and go to the Better BibTeX pane and click on the *Automatic Export* tab.
1. You should see the export you just did listed in the box. Click the radio button on "on idle" so that new exports will happen only when you're not actively working in Zotero (though it has to be open).
1. Now copy your exported bibliography file to your pandoc folder on the server. You'll want to update this copy whenever the original file changes.

> *NB* If you are running pandoc on your own computer, you don't need to copy your bibliography file to the server.

### Adding citations for pandoc

As usual, there is plenty of detail on citations in the [pandoc User's Guide](http://pandoc.org/README.html#citations). Here's the short version:

1. Find the item you want to add in your Zotero library.
1. Note the citation key for that item.
1. Cite that work by writing the citation key in your document, preceded by `@`:  

```
    Here is some text with a citation (@Muccigrosso2011).
```

Pandoc will replace the citation key with an in-line citation and a full one at the end of the document, by default all in the Chicago Manual of Style author-date format.

But to do this, pandoc needs to know where the bibliography file is. You indicate that file with the `--bibliography` option to the pandoc command. So:

    pandoc --bibliography=/path/to/your/file

If necessary, you can use `pwd` to get the path to the directory of your file. On our server, it should be some thing like:

    pandoc --bibliography='/home/jmuccigr/pandoc/muccigrosso/My Documents.json'

Note the single quotation mark around the file path because it has a space in it which normally marks a word end. The quotation marks force the all the text inside them to be considered together. Another way to handle the same problem is to precede any space in a file name with a `\` which is a way of saying "include the next character as a literal part of the text". This is called "escaping" the character:

    pandoc --bibliography=/home/jmuccigr/pandoc/muccigrosso/My\ Documents.json


Our sample text:

    Here is some text with a citation (@Muccigrosso2011).

will now be processed into:

>
Here is some text with a citation (Muccigrosso (2011)).
>
Muccigrosso, John D. 2011. “The 2010 Excavation Season at the Site of the Vicus Ad Martis Tudertium (PG).” *FOLD&amp;R* 227: 12. <http://www.fastionline.org/docs/FOLDER-it-2011-227.pdf>

Note how pandoc has grabbed all the information about the article from the bibliography file and inserted it in-line and at the end of the file to create a list of references. If you surround the citation with square brackets, pandoc will be a little smarter about the formatting (see the User's Guide for details):

    Here is some text with a citation [@Muccigrosso2011].
      
    Here's a citation using the author's name in the text, followed by  
    a bracketed page reference from @Muccigrosso2011 [p. 12].

becomes

> Here is some text with a citation (Muccigrosso 2011).
> 
> Here’s a citation using the author’s name in the text, followed by a bracketed page reference from Muccigrosso (2011, 12).

Note how the author's name is not repeated in the second sentence, even though the page number and year were combined in the parenthesis.

One more thing: you can use citations within notes, if you want:

    This guy says blah.[^1]
                       
    [^1]: @Muccigrosso2011.

Becomes the following, with the full citation still given at the end of the document (though not shown here):
    
> This guy says blah.<sup>1</sup>  
> &nbsp;  
> &nbsp;  
> &nbsp;
> ___  
> 1\. Muccigrosso (2011).

- Add a few citations to your markdown document and process it with pandoc. Make sure it handles the citations as you expect.

#### Quick review

Now you can:

1. Generate a bibliography file with Zotero and have it automatically updated.
1. Make pandoc do the hard work of creating citations in the right format.
1. Include footnotes.

Now for a few things to make life a little easier.

### Some added CLI convenience

It turns out that the CLI has some nice ways to make your use of it a bit more convenient.

#### Aliases

The CLI has a way to create shortcuts—usually called *aliases*—for commands that you use frequently. These can save you a lot of typing and from having to memorize all the options for commands. To see what aliases are already in place, issue the command `alias` at the prompt. (You may not have any!) To create an alias, use the same command with a long argument:

    alias <new command>='<existing command>'

For example, the following will create a new command, `ll`, which will output a directory listing in the list format, which (as you know) is `ls -l`:

    alias ll='ls -l'

Strictly speaking, the single quotation marks around the existing command are only needed when it contains a space or other unusual character (as above with file names), but it's a good practice to include them anyway. 

- Once you've created the new alias, try it out.

When you log out, that alias will be destroyed; it lasts only for the session in which you execute it. So what's so convenient about that, if you have to create the alias every time you open a session?

#### The .bashrc file

When you open a new session, you're actually running an environment called a *shell*. There are several such environments with different names. The one we're running is called *Bash* (actually an acronym—at least jokingly so—for "Bourne-again shell", which replaced an earlier shell called "Bourne"). When you open up the shell, it reads and executes whatever commands are in a file in your home directory called *.bashrc*. You may wonder why you've never noticed that file in your home directory. It's because a leading `.` in a filename keeps that file from being shown by `ls` unless you specify the `-a` option. Let's edit your .bashrc file:

1. Create a new session on the server and make sure you're in your home directory by changing the directory to it. Just like `.` is always the current directory and `..` is always the directory containing the current directory, your home directory has its own special name: `~`. So to get there, `cd ~`. (This will work from any directory in the system.)
1. Once in your home directory, list **all** the files to make sure you have *.bashrc*. If you don't have one, create it with `touch`.
1. Open the .bashrc file for editing with `nano`.
1. If the file was already there, it's likely that the system administrator has put some commands into it already. Have a look through it. You may notice that some lines look like commands and others look like they might be some programming. (They are.) These types of shell files consist of a series of commands to be executed by the system.  
    People will often include comments in these files by starting a line with `#`, which tells the system not to process the line. This is also an easy way to prevent a line with a command from being executing, since prefixing it with `#` makes the system think it's just a comment and it gets ignored. This is called "commenting out" a line. (If you like, try entering a command you know with a leading `#` and see what happens.)
1. Look for an `alias` command in the .bashrc file and see whether it's been commented out or not. Uncomment any commands that look useful and save the file. From now on every **new** shell you create will use your new aliases. To avoid the hassle of exiting your current session and re-opening a new one, simply enter `source ~/.bashrc` and the system will load the .bashrc file in your home directory, making your new aliases active.

## Putting it all together.

Let's make our own alias to help with our use of pandoc:

1. Open .bashrc for editing via `nano`. (Remember that it's in your home directory.)
1. Go to the end of the file and add the following:  
   `alias pandoc='pandoc --bibiliography=/your/bibliography/file.json'`
1. Close and save the file.
1. `Source` it to make the new alias active.

From now on all your invocations of pandoc will know to use the bibliography file you specified in .bashrc, and you won't have to worry about it, so...

- Use your new pandoc command to process your markdown file. Make sure the citations are processed correctly.


## Review of new CLI commands

1. `alias '<new command>=<existing command>'` to create a new alias.
1. `alias` by itself will display the active aliases.
1. `source <filename>` will execute the file as if it were a series of shell commands.
