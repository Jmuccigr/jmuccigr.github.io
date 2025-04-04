---
title: "Train stations and PVs"
author: John D. Muccigrosso
date: 2025-04-03
tags:
  - Italy
  - renewables
  - Rome
  - technology
---

tl;dr Italy (and other countries) should be putting up solar panels as part of passenger shelters at all their train stations.

## Bluesky

I've moved off Xitter and onto Bluesky, for a variety of reasons, none of them complimentary to the bird site. One of the nice things about the relatively youthful Bluesky is the existence of feeds. Formally "feed" refers to any list of posts, including a user's timeline, but feeds are often used to refer to lists of posts that are curated, often automatically via services offered by various third parties. These feeds let you easily find posts related to a topic or set of interests. As part of my effort to find good news, I've hooked up to a few alternative-energy related feeds, hoping to be inspired by the global move off fossil fuels.

## Train Stations

Back in November [an article](https://www.dsb.dk/om-dsb/baredygtighed/indsatser/nye-solceller-paa-hoeje-taastrup/) appeared on the website of the Danish rail service DSB about how they had added solar panels to one of their train stations. 600 PV panels are expected to produce about 254MWh of energy a year (which likely means that they're 400 or 420W panels, given the amount of sun that Denmark gets). They expect the output to completely cover the station's energy needs during summer days. There aren't a lot of details, but the accompanying image seems to show the panels deployed on top of the shelters on the platforms. A quick set of measurements on Google Earth confirms that there's likely enough room on those. (PV panels are typically ~1x2m, as confirmed by the article which says these take up 1200 square meters.)

{% include image.html 
    srcabs="/images/solceller-hoeje-taastrup_1900x1080.jpg" 
    url="https://www.dsb.dk/globalassets/om-dsb/baeredygtighed/artikler/nye-solceller-pa-hoje-taastrup/solceller-hoeje-taastrup_1900x1080.jpg" 
    caption="Image from the article showing PV panels on top of track shelters (I think)"
    alt="Image from the article showing PV panels on top of track shelters (I think)" 
    attribution="(Image: DSB, with some light editing)" 
%}

What leads me to write this is that (1) I've long been baffled by the lack of such shelters, or even simple shade, at many Italian train stations which get, as you might imagine or know from experience, pretty hot in the warmer months, and (2) thought that sunny Italy would benefit from more solar panels. I know from experience that there's a lot of work that has to go into siting solar farms in Italy, due to their rightfully strict laws about cultural heritage and making sure that those farms (and other things) aren't built over archaeological remains. Italy's cities, at least in their historic centers, also don't offer many good spots for traditional PV panels with their lovely—and also often legally protected—tile roofs.

It seems to me that train stations would offer good opportunities for solar. They're found all over the country, but typically near urban centers (Rome and other big cities even have more than one station each.) They're hooked into the electrical grid, in many cases quite robustly since the trains are mainly electric. They have lots of demand for electricity for at least the track lights and whatever bars and shops are in their station houses, to say nothing of the trains themselves. If nothing else, they could just feed right back into the grid.

For example, here's a view from Google Earth of one of Rome's smaller stations, the one at San Pietro.

{% include image.html 
    src="Stazione_San_Pietro.png" 
    caption="Satellite view of Rome's &quot;small&quot; San Pietro station"
    alt="Satellite view of Rome's &quot;small&quot; San Pietro station" 
    attribution="(Image: Google)" 
%}

It's got five tracks, and two platforms which actually have shelters over them (highlighted in the image), so let's just use them. They're fairly well oriented with their long sides exposed to the southwest. Measuring about 160x6m according to Google Earth's nice little ruler tool, they could hold 640 PV panels of the typical size (160 x 2 x 2), for about 270kW peak power. Since Italy gets a little more sun than Denmark, that would yield something like 380MWh of energy a year.

At Rome's main station, Stazione Termini, they recently did some new construction, putting in a building across all the platforms (outlined in red in the image). No solar on top. Out front (outlined in green), they're putting the finishing touches on the massive—and sweltering—bus area. No shelters, with or without solar. Two big missed opportunties. Finally the area of the tracks between the new building and the main station building to the northwest is about 36,000 square meters. 50% coverage would yield 9,000 PV panels for 3.78MW peak, or something like 5GWh a year (assuming they put the panels on some structure that went high up across that space. Just using the existing 200x10m shelters would give us space for maybe 3 panels across, so 6000 panels (8,000 if you got four across). That's 3.4MW peak or 4GWh a year. Not too shabby and that's without any panels at all on the main building.

{% include image.html 
    src="Stazione_Termini.png" 
    caption="Satellite view of Rome's Stazione Termini"
    alt="Satellite view of Rome's Stazione Termini" 
    attribution="(Image: Google)" 
%}

Quick calc: the [website](https://www.rfi.it/it/stazioni.html) for the Italian rail system lists 2,105 stations. Let's say they could fit an average of 200 PV panels each (that's 100m of shelter with 2 panels across, ignoring any panels on station buildings), that would be 421,000 panels or 177MW peak. Conservatively that would be 200GWh of electricity a year. Italy's [annual electricity consumption](https://www.statista.com/statistics/799638/total-electricity-consumption-in-italy/) right now is about 300TWh, so that would be about 2/3 of 1%. Let's round up since I've been pretty conservative above and say that PVs on the tracks of existing Italian rail stations could cover 1% of the annual electricity demain in Italy, while providing shelter for riders, in many cases on existing infrastructure. It would also be distributed across the country and, with batteries, make the stations self-sufficient, and even allow them to provide solar-powered (free) charging stations for phones, etc.

## Bus Stops

A quick note to say that Rome missed out on a similar chance recently when it redid (or added) the shelters for many bus stops, putting in 435 of the new smart ["Eterna" model](https://romamobilita.it/it/node/23645). (Rome's the **eternal** city, get it?)

{% include image.html 
    srcabs="https://romamobilita.it/sites/default/files/2024-12/pensilina%20smart.jpg" 
    url="https://romamobilita.it/sites/default/files/2024-12/pensilina%20smart.jpg" 
    caption="Image from the article showing the new bus shelters with partially transparent roofs"
    alt="Rome's new Eterna bus shelters" 
    attribution="(Image: Comune di Roma)" 
%}

These have a transparent roof with a grid pattern blocking maybe half its area, which means they will actually be hotter in the warm months when the sun is shining on them and there's no breeze (as often in Rome). They all have electronic panels which are supposed to show bus info and local attractions, as well as lighting, so they're wired into the grid as well. A PV roof would likely have worked well on these.
