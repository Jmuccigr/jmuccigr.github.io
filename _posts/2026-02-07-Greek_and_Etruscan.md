---
title: "From Etruscan to Greek and back again"
author: John D. Muccigrosso
date: 2026-02-07
tags: 
    - classics
    - linguistics
    - Python
published: true
---

tl;dr I wrote a couple of Python scripts to convert names between Greek and Etruscan

I've been looking at a lot of Etruscan mirrors lately. They have etched images on them,  not infrequently including writing, overwhelmingly labels naming some of the figures in the scenes. These names are written in Etruscan, of course, though there are some in Latin, too. The figures themselves are mainly mythological. Some seem to be purely Etruscan figures, like "Lasa," while others are clearly Greek or heavily Greek inspired. In the latter cases, their names can be both purely Etruscan, like "Fufluns" for Dionysus, or they can be Etruscan "translations" of the Greek names, like "Aplu" for "Apollo".

{% include image.html 
    src="Etruria,_specchio_con_laran,_turan,_menrva_e_aplu,_300-270_ac_ca.jpg"
    alt="Etruscan mirror showing (R-L): laran (Mars), turan (Aphrodite), menrva (Minerva/Athena) e aplu (Apollo)."
    caption="Etruscan mirror  showing (R-L) laran (Mars), turan (Aphrodite), menrva (Minerva/Athena) e aplu (Apollo)."
    attribution="Sailko, CC BY-SA 4.0 <https://creativecommons.org/licenses/by-sa/4.0>, via Wikimedia Commons"
    url="https://commons.wikimedia.org/wiki/File:Etruria,_specchio_con_laran,_turan,_menrva_e_aplu,_300-270_ac_ca.jpg"
%}

## Some rules

For the names that have been translated from the Greek, it's generally not terribly difficult to figure out what the original Greek was. There are a few basic principles to apply, but they're mostly things you learn pretty early on when studying Etruscan. I should say here that I am no Etruscan-language specialist; I know enough to be dangerous. Basically here's what you need, ignoring a lot of diachronic and regional niceties ([Wikipedia](https://en.wikipedia.org/wiki/Etruscan_language) for a start on more including good biblio for scholars like Bonfante (a little dated now), Benelli, Maggiani and Wallace):

1. Etruscan has no voiced stops, so no /d/, /b/, or /g/. All those sounds lose their voice to become /t/, /p/, /k/ (where that /k/ is represented by "c", as typically in Latin). So "**B**acchus" is "**P**acha".
2. Etruscan has no /o/, but instead uses a /u/. So "Apollo" is "Apulu".
3. Doubled consonants were reduced to singles. Again "Ap**l**u" for "Apo**ll**o".
4. Etruscan often swallowed up vowels in unstressed syllables, which means syllables that were not the first. So "Aplu" for "Ap**o**llo" (sometimes! See "Ap**u**lu" above).
5. The word-initial aspiration of /h/ generally is not found. So "Ercle" for "**H**eracles" or "Elinai" for "**H**elene".
6. Finally Etruscan is a little careless with distinctions between the aspirated and unaspirated versions of /t/, /p/, and /k/, so you see both for the same original. This isn't super-common, but there are both "Her**c**le" and "Her**χ**le" for "Heracles".

Added to these are some tendencies to replace other vowels or vowel combinations, especially at the end of names, e.g., "Ercl**e**" for "Heracl**es**".

## The scripts

Mostly for fun (because really it isn't that hard to do on your own), I decided to write up a couple of scripts in Python to go back and forth between the two languages. If you look carefully at the list of rules, you will see how going from Greek to Etruscan mainly results in the mandatory reduction of letters. Consonants and vowels are merged, vowels disappear, endings are shortened, and so on. You have very little that results in more options than you started with, so the possible Etruscan outcomes are typically few in number. In fact I first implemented most of this in a few lines of a shell script doing just successive letter replacements. Some examples:

Greek | Etruscan
:---- | :-------
Apollo| Apulu, Aplu
Amphiareus  | Amphiare, Ampiare
Odysseus | Utuse  Uθse   Utse    Uθuse
Prometheus | Prumthe,   Phrumethe,  Phrumthe,   Prumethe (+ 4 more)

Longer names obviously give more results and the rules that I'm using don't cover every case, though in each of these four examples the first result **is** found in Etruscan (as is the second in every case but the last). Those cases are lacking for a few reasons. Some are because it's a little hard to write a rule based on a fairly small set of examples. We also know that the Etruscans often received these names from speakers of various Greek dialects, starting early on in their interactions when, for example, the /w/ sound of the digamma was more common. As a result some of the names had forms not used later on and retain sounds and spellings that have disappeared from even Classical Greek, like "Aivas" for "Aias" (Latin "Ajax") from the Trojan-War cycle of myths. Errors no doubt occurred as well, giving us unexpected forms. We do find some clear copyist-type mistakes, for example, "Esplace" instead of "Esclape" for "Aesculapius" (swapping the /p/ and /c/ sounds). Finally, as noted above, I'm also not an expert and so could probably refine these a bit with some help.

*Vice versa* going from Etruscan to Greek results in **a lot** of additional forms. Vowels and consonants and endings multiply. New vowels are inserted, etc, etc. Take a short name like "Achle" (only 4 letters in the original script). We could aspirate the beginning with an "H", doubling the options. Now we replace the "ch" with any of the three related sounds, a tripling (sextupling overall). Replace the ending with the four options there. Insert a vowel in between "ch" and "l". Double the "l". In the end we get 94 possibilities, two of which are attested Greek names: Achilles and Agelaus.

I could probably apply some rules of Greek phonetics to eliminate some of these possible translation, but instead I implemented a look-up to identify successful "hits" by comparing the outputted names with a list of attested ones. Matches are put first in the output and marked with an asterisk. To repeat myself, it doesn't take much to get pretty good at this on your own, but sometimes the algorithm is nice to have for back-up.

Input and output are intended mainly to be in the Roman alphabet, though in Etruscan names people often write χ, φ, or θ mixed in with the Roman, so Achilles' Etruscan name shows up as both "A**ch**le" and "A**χ**le". Consequently the scripts allow input with all those letters, but won't really work with the rest of the Greek (or Etruscan) alphabet. They won't throw an error, but the output will usually be noticeably off. They can also output the Etruscan names in either format; Greek is always in the Roman alphabet. One oddity: I use a schwa symbol (ə) to represent the inserted (epenthetic) vowel in Greek names. The script will check all the vowels against the known list, but will only show a form if it matches. So "Apollo" will appear in the list, but not "Apallo" or any of the forms with the other vowels; instead "Apəllo" shows up.

As usual the scripts are in my Github repository under obvious names: [Greek_to_Etruscan.py](https://github.com/Jmuccigr/scripts/blob/master/Greek_to_etruscan.py) and [Etruscan_to_Greek.py](https://github.com/Jmuccigr/scripts/blob/master/Etruscan_to_Greek.py). Have a look at the code annotations for more details. Let me know about any errors or suggestions for improvement.
