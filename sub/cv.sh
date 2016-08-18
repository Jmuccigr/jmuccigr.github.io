#!/bin/bash
cd /Users/john_muccigrosso/Documents/github/local/stuff
pandoc -s --filter pandoc-fignos --atx-headers --css http://users.drew.edu/jmuccigr/css/clean_md.css ./CV.markdown -o CV.html
pandoc -s --filter pandoc-fignos --atx-headers --css http://users.drew.edu/jmuccigr/css/clean_md_print.css ./CV.markdown -o CV_pdf.html
