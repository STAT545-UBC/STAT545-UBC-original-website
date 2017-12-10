---
title: "Data from the Web"
output:
  html_document:
    highlight: null
    toc: yes
    toc_depth: 4
---

## Big picture

There are three ways to get data from the internet into R:

  * Make API queries "by hand" using httr.
  * Use an R package that wraps an API, such as the many from [rOpenSci](https://ropensci.org). 
  * Scrape the web.

Pick (at least) one of the exercises below. At least one prompt is given for each of the above approaches.

**Due date: Thursday 07 December 2017.**

## General requirements

Reproducibility

  * If your process involves obtaining some records (countries, species) at random, provide either the list of things chosen (id numbers, country codes etc.) OR use `set.seed()` so that a peer could produce the same random sample.

Security

  * Remember to protect any API keys or tokens, if your chosen API requires them! Don't commit and push those to GitHub.

Practicality

  * Be aware of rate limits on APIs when making repeated requests.
  * Don't download large data repeatedly during development. Consider breaking your work into separate scripts (e.g. download and analysis), using `make` or a makefile-like R script, or putting the download inside an `if()` statement that checks if the data already exists.

Reporting

  * Do, or at least, report your work in an R Markdown document.
  * What was most difficult? What are you most excited about in your future of getting data from the web? What questions did this raise in your mind?

## Make API queries "by hand" using httr.

Create a dataset with multiple records by requesting data from an API using the `httr` package.

Inspiration for APIs to call

  * From in-class activities (we'll see this in the next lecture):
    - Star Wars API: <https://swapi.co>
    - API of Ice and Fire: <https://anapioficeandfire.com>
    - OpenWeatherMap: <https://openweathermap.org/api>
    - Open Movie Database: <https://www.omdbapi.com>
  * Here is a huge list of APIs -- you should have no trouble finding one you have some interest in!
    - <http://www.programmableweb.com/category/all/apis>

`GET()` data from the API and convert it into a clean and tidy data frame. Store that as a file ready for (hypothetical!) downstream analysis. Do just enough basic exploration of the resulting data, possibly including some plots, that you and a reader are convinced you've successfully downloaded and cleaned it.

Take as many of these opportunities as you can justify to make your task more interesting and realistic,  to use techniques from elsewhere in the course (esp. nested list processing with purrr), and to gain experience with more sophisticated usage of httr.

  * Get multiple items via the API (i.e. an endpoint that returns multiple items at once) vs. use an iterative framework in R.
  * Traverse pages.
  * Send an authorization token. *The [GitHub API](https://developer.github.com/v3/) is definitely good one to practice with here.*
  * Use httr's facilities to modify the URL and your request, e.g., query parameters, path modification, custom headers.
  
## Scrape data

Work through the [final set of slides](https://github.com/ropensci/user2016-tutorial/blob/master/03-scraping-data-without-an-api.pdf) from the [rOpenSci UseR! 2016 workshop](https://github.com/ropensci/user2016-tutorial#readme). This will give you basic orientation, skills, and pointers on the rvest package.

Scrape a multi-record dataset off the web! Convert it into a clean and tidy data frame. Store that as a file ready for (hypothetical!) downstream analysis. Do just enough basic exploration of the resulting data, possibly including some plots, that you and a reader are convinced you've successfully downloaded and cleaned it.

I think it's dubious to scrape data that is available through a proper API, so if you do that anyway ... perhaps you should get the data both ways and reflect on the comparison. Also, make sure you not violating a site's terms of service or your own ethical standards with your webscraping. Just because you can, it doesn't mean you should!

## Use an R package that wraps an API

Many APIs have purpose-built R packages that make it even easier to get data from them.

If you choose one of these options, then you need to go further and combine two datasets, at least one of which is from the web.

### Specific ideas

These were developed in 2015 by TA Andrew MacDonald

**Prompt 1**: Combine [`gapminder`](https://github.com/jennybc/gapminder) and data from [`geonames`](http://www.geonames.org/). Install the `geonames` package (on [CRAN](https://cran.r-project.org/web/packages/geonames/index.html), on [GitHub](https://github.com/ropensci/geonames)). Make a user account and use `geonames` to access data about the world's countries. Use data from `geonames` and `gapminder` to investigate either of these questions:

  * What is the relationship between per-capita GDP and the proportion of the population which lives in urban centers?
  * Consider the following graph of population against time (a modification of Jenny's [gapminder demo](https://github.com/jennybc/gapminder)):
    

```r
library("ggplot2")
library("gapminder")

ggplot(subset(gapminder, continent != "Oceania"),
       aes(x = year, y = pop, group = country, color = country)) +
  geom_line(lwd = 1, show.legend = FALSE) + facet_wrap(~ continent) +
  scale_color_manual(values = country_colors) + theme_bw() +
  theme(strip.text = element_text(size = rel(1.1))) + scale_y_log10()
```

![](hw10_data-from-web_files/figure-html/spaghetti-plot-pop-vs-year-1.png)<!-- -->

Replace population with *population density*. To do this, look up the country codes in `geonames()`, obtain the area of each country and compute density as population divided by area. **TIP** check out the handy package [countrycode](https://github.com/vincentarelbundock/countrycode) to help you merge country names!

**Prompt 2**: Look at two other rOpenSci packages: [`rebird`](https://github.com/ropensci/rebird) and [`rplos`](https://github.com/ropensci/rplos). Both packages are on CRAN and more info is on their GitHub repo READMEs. Find out what data are available from each, and combine them! Here are three suggestions:

  * `rplos` and `rebird` -- how many articles are published on a bird species? 
  * `rplos` and `geonames` -- Choose a subset of countries. How many papers have been published by people from that country? In that country? How does that relate to GDP?
  * `rebird` and `geonames` -- Do countries with more bird species also have more languages?

**Prompt x**: Look through the rOpenSci [packages list](http://ropensci.org/packages/) and/or the [CRAN Task View on Web Technologies and Services](https://cran.r-project.org/web/views/WebTechnologies.html), find other wrapped APIs that interest you, and remix those instead.

## Rubric

Recall the [general homework rubric](http://stat545-ubc.github.io/peer-review01_marking-rubric.html).

Peers and/or TAs will run the code and try to get the same output. You'll be evaluated on the clarity and robustness of your workflow.

## Peer Review


The peer review is ready and is due __December 13, 2017__ (before midnight)! Here's what you'll need to do:

0. Find your github username in the table below. If it's not there, let Giulio know! Slack me `@giulio`.
1. Add the _people who will be giving you a review_ as collaborators to the repo containing your homework submission.
2. Give a review of this homework for the two people you've been assigned to. There should be an issue in their repo titled something like `hw0x ready for grading` -- put your review in there as a comment.
    - If there is no such issue, make one! (in _their_ repo)
    - Please don't mix up your reviewers and reviewees!

** If you were assigned to a MISSING repo, please contact me @gvdr **

Check out the [guidelines for giving a peer review](http://stat545.com/peer-review02_peer-evaluation-guidelines.html).


Your_github       Instructions                                                                                                                                                                                                                                                                                            
----------------  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
abishekarun       Please add [vanflad](https://github.com/vanflad) and [wswade2](https://github.com/wswade2) as collaborators to your repo containing hw10. Please __review the hw10 submission of [rainerlempert](https://github.com/rainerlempert) and [Shirlett](https://github.com/Shirlett)__.                       
Alexander-Morin   Please add [emwest](https://github.com/emwest) and [mlawre01](https://github.com/mlawre01) as collaborators to your repo containing hw10. Please __review the hw10 submission of [yuanjisun](https://github.com/yuanjisun) and [bcahn7](https://github.com/bcahn7)__.                                   
AnhKhoaVo         Please add [arsbar24](https://github.com/arsbar24) and [hannahdxz](https://github.com/hannahdxz) as collaborators to your repo containing hw10. Please __review the hw10 submission of [suminwei2772](https://github.com/suminwei2772) and [emwest](https://github.com/emwest)__.                       
arsbar24          Please add [HScheiber](https://github.com/HScheiber) and [arthursunbao](https://github.com/arthursunbao) as collaborators to your repo containing hw10. Please __review the hw10 submission of [hannahdxz](https://github.com/hannahdxz) and [AnhKhoaVo](https://github.com/AnhKhoaVo)__.               
arthursunbao      Please add [SonjaS1](https://github.com/SonjaS1) and [HScheiber](https://github.com/HScheiber) as collaborators to your repo containing hw10. Please __review the hw10 submission of [arsbar24](https://github.com/arsbar24) and [hannahdxz](https://github.com/hannahdxz)__.                           
bcahn7            Please add [Alexander-Morin](https://github.com/Alexander-Morin) and [yuanjisun](https://github.com/yuanjisun) as collaborators to your repo containing hw10. Please __review the hw10 submission of [margotgunning](https://github.com/margotgunning) and [zxkathy](https://github.com/zxkathy)__.     
CassKon           Please add [cheungamanda](https://github.com/cheungamanda) and [heathersummers](https://github.com/heathersummers) as collaborators to your repo containing hw10. Please __review the hw10 submission of [yanchaoluo](https://github.com/yanchaoluo) and [farihakhan](https://github.com/farihakhan)__. 
cheungamanda      Please add [ZimingY](https://github.com/ZimingY) and [Kozp](https://github.com/Kozp) as collaborators to your repo containing hw10. Please __review the hw10 submission of [heathersummers](https://github.com/heathersummers) and [CassKon](https://github.com/CassKon)__.                             
dorawyy           Please add [zxkathy](https://github.com/zxkathy) and [yidie](https://github.com/yidie) as collaborators to your repo containing hw10. Please __review the hw10 submission of [hsmohammed](https://github.com/hsmohammed) and [emilymistick](https://github.com/emilymistick)__.                         
emilymistick      Please add [dorawyy](https://github.com/dorawyy) and [hsmohammed](https://github.com/hsmohammed) as collaborators to your repo containing hw10. Please __review the hw10 submission of [Mathnstein](https://github.com/Mathnstein) and [ilgan](https://github.com/ilgan)__.                             
emwest            Please add [AnhKhoaVo](https://github.com/AnhKhoaVo) and [suminwei2772](https://github.com/suminwei2772) as collaborators to your repo containing hw10. Please __review the hw10 submission of [mlawre01](https://github.com/mlawre01) and [Alexander-Morin](https://github.com/Alexander-Morin)__.     
farihakhan        Please add [CassKon](https://github.com/CassKon) and [yanchaoluo](https://github.com/yanchaoluo) as collaborators to your repo containing hw10. Please __review the hw10 submission of [Tangjiahui26](https://github.com/Tangjiahui26) and [vibudh2209](https://github.com/vibudh2209)__.               
gbraich           Please add [qiaoyuet](https://github.com/qiaoyuet) and [rishadhabib](https://github.com/rishadhabib) as collaborators to your repo containing hw10. Please __review the hw10 submission of [ZimingY](https://github.com/ZimingY) and [Kozp](https://github.com/Kozp)__.                                 
hannahdxz         Please add [arthursunbao](https://github.com/arthursunbao) and [arsbar24](https://github.com/arsbar24) as collaborators to your repo containing hw10. Please __review the hw10 submission of [AnhKhoaVo](https://github.com/AnhKhoaVo) and [suminwei2772](https://github.com/suminwei2772)__.           
heathersummers    Please add [Kozp](https://github.com/Kozp) and [cheungamanda](https://github.com/cheungamanda) as collaborators to your repo containing hw10. Please __review the hw10 submission of [CassKon](https://github.com/CassKon) and [yanchaoluo](https://github.com/yanchaoluo)__.                           
HScheiber         Please add [KateJohnson](https://github.com/KateJohnson) and [SonjaS1](https://github.com/SonjaS1) as collaborators to your repo containing hw10. Please __review the hw10 submission of [arthursunbao](https://github.com/arthursunbao) and [arsbar24](https://github.com/arsbar24)__.                 
hsmohammed        Please add [yidie](https://github.com/yidie) and [dorawyy](https://github.com/dorawyy) as collaborators to your repo containing hw10. Please __review the hw10 submission of [emilymistick](https://github.com/emilymistick) and [Mathnstein](https://github.com/Mathnstein)__.                         
ilgan             Please add [emilymistick](https://github.com/emilymistick) and [Mathnstein](https://github.com/Mathnstein) as collaborators to your repo containing hw10. Please __review the hw10 submission of [xinyaofan](https://github.com/xinyaofan) and [xinmiaow](https://github.com/xinmiaow)__.               
jmurthy12         Please add [xinmiaow](https://github.com/xinmiaow) and [menglinzhou](https://github.com/menglinzhou) as collaborators to your repo containing hw10. Please __review the hw10 submission of [wenzhengzzz](https://github.com/wenzhengzzz) and [sepkamal](https://github.com/sepkamal)__.                 
juansbr7          Please add [peterwhitman](https://github.com/peterwhitman) and [vmichalowski](https://github.com/vmichalowski) as collaborators to your repo containing hw10. Please __review the hw10 submission of [marbazua](https://github.com/marbazua) and [swynes](https://github.com/swynes)__.                 
KateJohnson       Please add [vibudh2209](https://github.com/vibudh2209) and [mattsada](https://github.com/mattsada) as collaborators to your repo containing hw10. Please __review the hw10 submission of [SonjaS1](https://github.com/SonjaS1) and [HScheiber](https://github.com/HScheiber)__.                         
Kozp              Please add [gbraich](https://github.com/gbraich) and [ZimingY](https://github.com/ZimingY) as collaborators to your repo containing hw10. Please __review the hw10 submission of [cheungamanda](https://github.com/cheungamanda) and [heathersummers](https://github.com/heathersummers)__.             
marbazua          Please add [vmichalowski](https://github.com/vmichalowski) and [juansbr7](https://github.com/juansbr7) as collaborators to your repo containing hw10. Please __review the hw10 submission of [swynes](https://github.com/swynes) and [qiaoyuet](https://github.com/qiaoyuet)__.                         
margotgunning     Please add [yuanjisun](https://github.com/yuanjisun) and [bcahn7](https://github.com/bcahn7) as collaborators to your repo containing hw10. Please __review the hw10 submission of [zxkathy](https://github.com/zxkathy) and [yidie](https://github.com/yidie)__.                                       
Mathnstein        Please add [hsmohammed](https://github.com/hsmohammed) and [emilymistick](https://github.com/emilymistick) as collaborators to your repo containing hw10. Please __review the hw10 submission of [ilgan](https://github.com/ilgan) and [xinyaofan](https://github.com/xinyaofan)__.                     
mattsada          Please add [Tangjiahui26](https://github.com/Tangjiahui26) and [vibudh2209](https://github.com/vibudh2209) as collaborators to your repo containing hw10. Please __review the hw10 submission of [KateJohnson](https://github.com/KateJohnson) and [SonjaS1](https://github.com/SonjaS1)__.             
menglinzhou       Please add [xinyaofan](https://github.com/xinyaofan) and [xinmiaow](https://github.com/xinmiaow) as collaborators to your repo containing hw10. Please __review the hw10 submission of [jmurthy12](https://github.com/jmurthy12) and [wenzhengzzz](https://github.com/wenzhengzzz)__.                   
mlawre01          Please add [suminwei2772](https://github.com/suminwei2772) and [emwest](https://github.com/emwest) as collaborators to your repo containing hw10. Please __review the hw10 submission of [Alexander-Morin](https://github.com/Alexander-Morin) and [yuanjisun](https://github.com/yuanjisun)__.         
mylinhthibodeau   Please add [santiagodr](https://github.com/santiagodr) and [yeonukkim](https://github.com/yeonukkim) as collaborators to your repo containing hw10. Please __review the hw10 submission of [peterwhitman](https://github.com/peterwhitman) and [vmichalowski](https://github.com/vmichalowski)__.       
peterwhitman      Please add [yeonukkim](https://github.com/yeonukkim) and [mylinhthibodeau](https://github.com/mylinhthibodeau) as collaborators to your repo containing hw10. Please __review the hw10 submission of [vmichalowski](https://github.com/vmichalowski) and [juansbr7](https://github.com/juansbr7)__.     
qiaoyuet          Please add [marbazua](https://github.com/marbazua) and [swynes](https://github.com/swynes) as collaborators to your repo containing hw10. Please __review the hw10 submission of [rishadhabib](https://github.com/rishadhabib) and [gbraich](https://github.com/gbraich)__.                             
rainerlempert     Please add [wswade2](https://github.com/wswade2) and [abishekarun](https://github.com/abishekarun) as collaborators to your repo containing hw10. Please __review the hw10 submission of [Shirlett](https://github.com/Shirlett) and [santiagodr](https://github.com/santiagodr)__.                     
rishadhabib       Please add [swynes](https://github.com/swynes) and [qiaoyuet](https://github.com/qiaoyuet) as collaborators to your repo containing hw10. Please __review the hw10 submission of [gbraich](https://github.com/gbraich) and [ZimingY](https://github.com/ZimingY)__.                                     
santiagodr        Please add [rainerlempert](https://github.com/rainerlempert) and [Shirlett](https://github.com/Shirlett) as collaborators to your repo containing hw10. Please __review the hw10 submission of [yeonukkim](https://github.com/yeonukkim) and [mylinhthibodeau](https://github.com/mylinhthibodeau)__.   
sepkamal          Please add [jmurthy12](https://github.com/jmurthy12) and [wenzhengzzz](https://github.com/wenzhengzzz) as collaborators to your repo containing hw10. Please __review the hw10 submission of [vanflad](https://github.com/vanflad) and [wswade2](https://github.com/wswade2)__.                         
Shirlett          Please add [abishekarun](https://github.com/abishekarun) and [rainerlempert](https://github.com/rainerlempert) as collaborators to your repo containing hw10. Please __review the hw10 submission of [santiagodr](https://github.com/santiagodr) and [yeonukkim](https://github.com/yeonukkim)__.       
SonjaS1           Please add [mattsada](https://github.com/mattsada) and [KateJohnson](https://github.com/KateJohnson) as collaborators to your repo containing hw10. Please __review the hw10 submission of [HScheiber](https://github.com/HScheiber) and [arthursunbao](https://github.com/arthursunbao)__.             
suminwei2772      Please add [hannahdxz](https://github.com/hannahdxz) and [AnhKhoaVo](https://github.com/AnhKhoaVo) as collaborators to your repo containing hw10. Please __review the hw10 submission of [emwest](https://github.com/emwest) and [mlawre01](https://github.com/mlawre01)__.                             
swynes            Please add [juansbr7](https://github.com/juansbr7) and [marbazua](https://github.com/marbazua) as collaborators to your repo containing hw10. Please __review the hw10 submission of [qiaoyuet](https://github.com/qiaoyuet) and [rishadhabib](https://github.com/rishadhabib)__.                       
Tangjiahui26      Please add [yanchaoluo](https://github.com/yanchaoluo) and [farihakhan](https://github.com/farihakhan) as collaborators to your repo containing hw10. Please __review the hw10 submission of [vibudh2209](https://github.com/vibudh2209) and [mattsada](https://github.com/mattsada)__.                 
vanflad           Please add [wenzhengzzz](https://github.com/wenzhengzzz) and [sepkamal](https://github.com/sepkamal) as collaborators to your repo containing hw10. Please __review the hw10 submission of [wswade2](https://github.com/wswade2) and [abishekarun](https://github.com/abishekarun)__.                   
vibudh2209        Please add [farihakhan](https://github.com/farihakhan) and [Tangjiahui26](https://github.com/Tangjiahui26) as collaborators to your repo containing hw10. Please __review the hw10 submission of [mattsada](https://github.com/mattsada) and [KateJohnson](https://github.com/KateJohnson)__.           
vmichalowski      Please add [mylinhthibodeau](https://github.com/mylinhthibodeau) and [peterwhitman](https://github.com/peterwhitman) as collaborators to your repo containing hw10. Please __review the hw10 submission of [juansbr7](https://github.com/juansbr7) and [marbazua](https://github.com/marbazua)__.       
wenzhengzzz       Please add [menglinzhou](https://github.com/menglinzhou) and [jmurthy12](https://github.com/jmurthy12) as collaborators to your repo containing hw10. Please __review the hw10 submission of [sepkamal](https://github.com/sepkamal) and [vanflad](https://github.com/vanflad)__.                       
wswade2           Please add [sepkamal](https://github.com/sepkamal) and [vanflad](https://github.com/vanflad) as collaborators to your repo containing hw10. Please __review the hw10 submission of [abishekarun](https://github.com/abishekarun) and [rainerlempert](https://github.com/rainerlempert)__.               
xinmiaow          Please add [ilgan](https://github.com/ilgan) and [xinyaofan](https://github.com/xinyaofan) as collaborators to your repo containing hw10. Please __review the hw10 submission of [menglinzhou](https://github.com/menglinzhou) and [jmurthy12](https://github.com/jmurthy12)__.                         
xinyaofan         Please add [Mathnstein](https://github.com/Mathnstein) and [ilgan](https://github.com/ilgan) as collaborators to your repo containing hw10. Please __review the hw10 submission of [xinmiaow](https://github.com/xinmiaow) and [menglinzhou](https://github.com/menglinzhou)__.                         
yanchaoluo        Please add [heathersummers](https://github.com/heathersummers) and [CassKon](https://github.com/CassKon) as collaborators to your repo containing hw10. Please __review the hw10 submission of [farihakhan](https://github.com/farihakhan) and [Tangjiahui26](https://github.com/Tangjiahui26)__.       
yeonukkim         Please add [Shirlett](https://github.com/Shirlett) and [santiagodr](https://github.com/santiagodr) as collaborators to your repo containing hw10. Please __review the hw10 submission of [mylinhthibodeau](https://github.com/mylinhthibodeau) and [peterwhitman](https://github.com/peterwhitman)__.   
yidie             Please add [margotgunning](https://github.com/margotgunning) and [zxkathy](https://github.com/zxkathy) as collaborators to your repo containing hw10. Please __review the hw10 submission of [dorawyy](https://github.com/dorawyy) and [hsmohammed](https://github.com/hsmohammed)__.                   
yuanjisun         Please add [mlawre01](https://github.com/mlawre01) and [Alexander-Morin](https://github.com/Alexander-Morin) as collaborators to your repo containing hw10. Please __review the hw10 submission of [bcahn7](https://github.com/bcahn7) and [margotgunning](https://github.com/margotgunning)__.         
ZimingY           Please add [rishadhabib](https://github.com/rishadhabib) and [gbraich](https://github.com/gbraich) as collaborators to your repo containing hw10. Please __review the hw10 submission of [Kozp](https://github.com/Kozp) and [cheungamanda](https://github.com/cheungamanda)__.                         
zxkathy           Please add [bcahn7](https://github.com/bcahn7) and [margotgunning](https://github.com/margotgunning) as collaborators to your repo containing hw10. Please __review the hw10 submission of [yidie](https://github.com/yidie) and [dorawyy](https://github.com/dorawyy)__.                               
