---
title: Some scripts for Roman numerals
author: John D. Muccigrosso
date: 2024-11-17
tags:
  - cli
  - Rome
---

I've been working a bit with Roman dates and couldn't find any easy conversion scripts that would work on the command line (= in bash), so I wrote some!

## Why?

I'm writing up some collaborative student work from [Drew University](https://drew.edu/)'s Digital Humanities Summer Institute a few years ago (yeah, I'm way behind on it). The project involves reproducing Brent Shaw's work on the distribution of death through the year in late-antique Rome.[^1] The analysis centers on the Christian inscriptions from Rome (now conveniently located in the [Epigraphic Database Bari](https://www.edb.uniba.it/)) which frequently included the deceased's date of deposition, sometimes even of death. These dates are given almost entirely in the traditional Roman style using the days on or before the three named days of each month: *kalends*, *nones*, and *ides*. The years are similarly identified by the names of the consuls.

As I was cleaning up the data (ugh), I realized that there might be a fair amount of data in there on days of the week. The 1,000+ inscriptions contain 16 explicit references to a day of the week, mainly in the formulaic Latin *die X*, where X is the name of the god to whom the day was dedicated in the genitive. These names are preserved pretty well in the Romance-language names for the days, so if you know one of those, you won't be surprised by the list. The gods are also associated with the 7 "planets" (the five visible planets plus the sun and moon). In English we somehow got all these translated to the Norse gods, but here's the breakdown:[^2]

| English   | Latin    | Alternative | Planet  |
| --------- | -------- | ----------- | ------- |
| Monday    | Lunae    | -           | Moon    |
| Tuesday   | Martis   | -           | Mars    |
| Wednesday | Mercurii | -           | Mercury |
| Thursday  | Jovis    | -           | Jupiter |
| Friday    | Veneris  | -           | Venus   |
| Saturday  | Saturni  | Sabbati     | Saturn  |
| Sunday    | Solis    | Dominica    | Sun     |

Already in the 5th century, Sunday was being called the "Lord's Day" or *Dominica* (from the Latin for "lord", *Dominus*) and Saturday the "sabbath" (*Sabbatus*), so those both show up as well. Since 16 isn't a big number, I was hoping to calculate the days of the week for those inscriptions that have a reference both to a specific year and to a specific day. There aren't a huge number of those either, but enough maybe to be interesting. This is where the scripts come in.

In order for this to not involve a lot of manual looking up, I'll need a few things. Fortunately the fine people at the EDB have already included the year information in their downloads, so I don't need to worry about looking up consuls. Here's my task list:

1. Convert the Roman day-month dates to modern ones
2. Combine with the downloaded year data
3. Look up the weekday

## The scripts

Step 3 has to come last because you need the month, day, and the year to figure out the weekday. And Step 2 isn't too tricky once I have Step 1 done. I can do it pretty trivially in a spreadsheet app. That means two scripts to write:

1. Convert Roman dates to modern ones
2. Get the weekday for a given date

"Modern" in the first case means a date in the Gregorian or Julian system. There are some periods where this can be tricky, mainly at the start of the Julian system (45 BC) when things in Rome were a little dicey, especially with the assassination of the Julius in question, so the full implementation of the new calendar took a while, finishing up by AD 8 or so. That's too early for me to worry about here. Likewise the implementation of the Gregorian calendar wasn't entirely smooth. Pope Gregory implemented it in 1582, but a lot of countries took their time about joining the (mostly Catholic) countries that went along right at the start. Again, this isn't a time period I'm worried about.

Converting the dates is fairly straightforward. The big thing to watch for is leap years, which occur regularly every four years in the Julian calendar, which, as with our calendar, affects just late February. To try to automate as much as possible, I wanted the script to handle Roman numerals since that's the format that the inscriptions use. This then required writing a function to handle that. Again, not too tricky, but I wanted it to handle some of the non-standard things you sometimes see and that took more work.

Looking up weekdays was trickier. I was expecting that UNIX's built-in `date` function could handle it. It provides weekdays, but it doesn't work for antiquity (actually not for anything before 1900). This was a little surprising, because the handy `cal` function works just fine for the centuries in question. As it turns out, AppleScript's date function also works for antiquity, but I wanted something a little easier to work with on the command line.

This all taught me something new. There's this thing called [Zeller's Congruence](https://en.wikipedia.org/wiki/Zeller%27s_congruence) which is a set of formulas that does exactly what's needed: they find the weekday for any date in the Julian or Gregorian calendar. You need slightly different formulas for each epoch, since the big change in the Gregorian (besides skipping 10 days in October of 1582) was to reduce the number of leap years by making century years regular, unless evenly divisible by 400 (like 2000, but not 2100). (Impressively AppleScript handles the Gregorian transition, adding 10 to any date in the skipped period.)

In the end I've got four new files on my GitHub repo for this project. The [AppleScript](https://github.com/Jmuccigr/AppleScripts/blob/master/Useful%20stuff/Convert%20Roman%20date.applescript) and [bash scripts](https://github.com/Jmuccigr/scripts/tree/master/dates) for the date conversion, and the two functions that convert Roman numerals and do the Zeller calculation. (I separated those two out, so they can more easily be used in other places.)

In terms of the project, I could combine the two processes and just go right from the Roman dates to day of the week, but I think it's better to keep the generated modern date information directly in the database.

[^1]: Shaw, B.D. 1996. “Seasons of Death: Aspects of Mortality in Imperial Rome.” _The Journal of Roman Studies_ 86:100–38. doi:[10.2307/300425](https://doi.org/10.2307/300425).
[^2]: For more details, the [Wikipedia entry](https://en.wikipedia.org/wiki/Names_of_the_days_of_the_week) is informative.
