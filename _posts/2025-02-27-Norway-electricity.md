---
title: "Norway, Electricity and EVs"
author: John D. Muccigrosso
date: 2025-02-27
usemath: true
tags:
  - technology
  - Norway
  - renewables
  - EVs
---

tl;dr Norway is electrifying like mad and can easily handle the coming near 100% EV situation with its significant hydropower.

## Bluesky

I've moved off Xitter and onto Bluesky, for a variety of reasons, none of them complimentary to the bird site. One of the nice things about the relatively youthful Bluesky is the existence of feeds. Formally "feed" refers to any list of posts, including a user's timeline, but feeds are often used to refer to lists of posts that are curated, often automatically via services offered by various third parties. These feeds let you easily find posts related to a topic or set of interests. As part of my effort to find good news, I've hooked up to a few alternative-energy related feeds, hoping to be inspired by the global move off fossil fuels.

## Norway

As I now know, Norway is just killing it with electric vehicles (EVs). (There's a [Wikipedia page](https://en.wikipedia.org/wiki/Plug-in_electric_vehicles_in_Norway) on the subject for easy reference.) Last year 88.9% of new-car sales were EVs and another 2.7% were plug-in hybrids, with another 5.3% in non-plug-in hybrids. EVs make up [about 1/3](https://www.bbc.com/news/articles/cg52543v6rmo) of all cars on the road at this point. It's really remarkable.

There's been a lot of talk about EVs and their role in electrifying everything, since EVs obviously need electricity to run and they also have batteries. With an average capacity of [71.4 kWh](https://ev-database.org/cheatsheet/useable-battery-capacity-electric-car), EV batteries are pretty big compared with most home batteries installed with solar systems for which 20 kWh is on the larger side. Just charging EVs could have a big impact on the grid, but the effect of using their batteries to soak up extra supply or to provide electricity at times of high demand also needs considering. I'm not going to say more about that, but with increasing EV sales, the much-anticipated time for *V2X*, "Vehicle to grid/building/whatever" is coming.

So what about Norway, where there are so many EVs now? How's their electricity generation?

## Electricity Generation in Norway

Turns out Norway is a huge supplier and user of hydropower. Over 90% of their electricity typically comes from hydro and another good chunk of the remainder from wind. In [January 2025](https://www.ssb.no/en/energi-og-industri/energi/statistikk/elektrisitet), for example, 90.9% of electricity came from hydro and 8.1% wind. Solar was minimal, for what are hopefully obvious reasons (though their capacity is growing fast), and burning stuff made up the remaining 1%. They also export a fair amount of the energy they generate.

{% include image.html 
    srcabs="https://upload.wikimedia.org/wikipedia/commons/0/00/Platedammen_for_Fitvatnet.JPG" 
    url="https://commons.wikimedia.org/wiki/File:Platedammen_for_Fitvatnet.JPG" 
    caption="Fitvatnet dam, Norway"
    alt="Fitvatnet dam, Norway" 
    attribution="(Frankemann, <a href=\"https://creativecommons.org/licenses/by-sa/4.0\">CC BY-SA 4.0</a>, via Wikimedia Commons)" 
%}

## Some math

OK, onto the calculations for EVs.

The [most recent official data](https://www.ssb.no/en/transport-og-reiseliv/landtransport/statistikk/bilparken) I find from Norway's stats agency, Statistisk sentralbyro (SSB), is for 2023 and gives just under 3M private cars, of which about 700k are electric. That'a little under the 1/3 number I cited above, which makes sense since the big sales of 2024 aren't in there, so let's assume that 1/3 figure is correct and the number of cars is the same. Obviously the grid is handling the existing EVs with the performance I just cited. So let's have the remaining 2/3 of cars turn into EVs and see what happens. 2M cars with 71.4 kWh batteries mean a total demand of 140 GWh for refilling, but of course cars don't get refilled every day. [SSB](https://www.ssb.no/en/transport-og-reiseliv/landtransport/statistikk/kjorelengder) puts the average distance driven per year at about 12,000 km. The [average EV](https://ev-database.org/cheatsheet/energy-consumption-electric-car) consumes about 189 Wh/km, so that means about 377 km per charge. Let's round down to 300 for the cold Norwegian weather (equivalent to 150 Wh/km), and then we've got 40 charges per year, or about one charge every 9 days.

In all then, 2M cars driving 12000 km, using 150 Wh per km:

$$
2\times10^6 \!\cdot\! 12 \times 10^3 \mathrm{km} \!\cdot\! 150 \frac{\mathrm{Wh}}{\mathrm{km}}
=3600\times10^9\mathrm{Wh}
=3.6\times10^{12}\mathrm{Wh}=3.6\mathrm{TWh}
$$

which we should probably round to 4 TWh, given the precision I've been applying to all this, or 0.3 TWh = 300 GWh a month required to charge all the new EVs.

On the generation side, [last year](https://www.ssb.no/en/statbank/table/14091/tableViewLayout1/) Norway produced 157 TWh, an average of ~13 TWh a month, and net exported over 18 TWh, an average of 1.5 TWh a month. (There's a strong electricity-trading market in northern Europe, so it's not surprising there's both import and export as Norway—and other countries—uses the market to reduce costs.) In no month did Norway import more than it exported, that is, throughout the year it always ran a surplus, and the lowest monthly export was 247 GWh in January. Second lowest was 914 GWh in February, so January really was anomalous. (This year January was much better with over 2 TWh of exports, an order of magnitude more than 2024.)

Combining new EV demand with total generation shows that in 11 of 12 months of 2024, Norway had net exports of at least 3x what they would need to charge the 2M new EVs that they'll likely have in a few years. Over the course of the year, of course, 18 is a lot bigger than 4, so there are plenty of electrons to go around.

## Conclusion

There are a million or so other vehicles, mostly vans and motorcycles, that I haven't accounted for here, but if we assume that they need an equal amount of power (*very* ballpark), we still find that Norway is still already producing more than enough electricity for them as well. I also haven't accounted for the impact that all this battery storage will have once V2X begins to have an impact. Finally of course since Norway is a big exporter, having it eat up another 4 TWh of electricity is going to have an impact on its trading partners. However they are busy building out renewable supply, mainly through wind and solar, adding new grid capability and new battery storage, even as they electrify further as well. It's a complicated picture, but moving in a good direction.
