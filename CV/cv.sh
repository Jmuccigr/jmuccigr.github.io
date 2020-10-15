#!/bin/bash

me=`whoami`
thisdir=`dirname "$0"`
cd $thisdir

pandoc --self-contained --template="/Users/$me/Documents/github/local/pandoc-templates/default.html4"  -s --columns 800 --bibliography="/Users/$me/Documents/github/local/miscellaneous/My Library.json" ./CV.markdown -f markdown+smart -o CV.html
