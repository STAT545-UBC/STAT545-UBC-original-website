# Homework 05: Factor and figure management; Repo hygiene

### Overview

Consult the [general homework guidelines](hw00_homework-guidelines.html).

Due anytime Friday 2017-10-20.

Goals:

  * Reorder a factor in a principled way based on the data and demonstrate the effect in arranged data and in figures.
  * Improve a figure (or make one from scratch), using new knowledge, e.g., control the color scheme, use factor levels, smoother mechanics.
  * Implement visualization design principles.
  * Write some data to file and load it back into R. E.g., save a plot to file and include it in a R Markdown report via `![Alt text](/path/to/img.png)`.
  * Organise your github, to celebrate the completion of STAT 545 and/or to prepare for the glorious future of STAT 547.

Remember the [sampler concept](http://en.wikipedia.org/wiki/Sampler_(needlework)). Your homework should serve as your own personal cheatsheet in the future for canonical tasks. Make things nice -- your future self will thank you!

#### Gapminder, Singer, ... or something else

You can work with the gapminder data or take this chance to play with something else, such as Joey's Singer. In which case, you'll have to create comparable tasks for yourself.

### Factor management

Step goals:

* Define factor variables;
* Drop factor / levels;
* Reorder levels based on knowledge from data.

I give here the trace for both the Singer and the Gapminder dataframes.

#### Singer version:

**Factorise.** Transform some of the variable in the `singer_locations` dataframe into factors: pay attention at what levels you introduce and their order. Try and consider the difference between the base R `as.factor` and the `forcats`-provided functions.

**Drop 0.** Filter the `singer_locations` data to remove observations associated with the uncorrectly inputed `year` 0.  Additionally, remove unused factor levels. Provide concrete information on the data before and after removing these rows and levels; address the number of rows and the levels of the affected factors.

**Reorder the levels of `year`, `artist_name` or `title`.** Use the forcats package to change the order of the factor levels, based on a principled summary of one of the quantitative variables. Consider experimenting with a summary statistic beyond the most basic choice of the median.

#### Gapminder version:

**Drop Oceania.** Filter the Gapminder data to remove observations associated with the `continent` of Oceania.  Additionally, remove unused factor levels. Provide concrete information on the data before and after removing these rows and Oceania; address the number of rows and the levels of the affected factors.

**Reorder the levels of `country` or `continent`.** Use the forcats package to change the order of the factor levels, based on a principled summary of one of the quantitative variables. Consider experimenting with a summary statistic beyond the most basic choice of the median.

#### Common part:

While you're here, practice writing to file and reading back in (see next section).

Characterize the (derived) data before and after your factor re-leveling.

  * Explore the effects of `arrange()`. Does merely arranging the data have any effect on, say, a figure?
  * Explore the effects of reordering a factor and factor reordering coupled with `arrange()`. Especially, what effect does this have on a figure?

These explorations should involve the data, the factor levels, and some figures.

### File I/O

Experiment with one or more of `write_csv()/read_csv()` (and/or TSV friends), `saveRDS()/readRDS()`, `dput()/dget()`. Create something new, probably by filtering or grouped-summarization of Singer or Gapminder. I highly recommend you fiddle with the factor levels, i.e. make them non-alphabetical (see previous section). Explore whether this survives the round trip of writing to file then reading back in.

### Visualization design

Remake at least one figure or create a new one, in light of something you learned in the recent class meetings about visualization design and color. Maybe juxtapose your first attempt and what you obtained after some time spent working on it. Reflect on the differences. If using Gapminder, you can use the country or continent color scheme that ships with Gapminder. Consult the guest lecture from Tamara Munzner and [everything here](graph00_index.html).

### Writing figures to file

Use `ggsave()` to explicitly save a plot to file. Then use `![Alt text](/path/to/img.png)` to load and embed it in your report. You can play around with various options, such as:

  * Arguments of `ggsave()`, such as width, height, resolution or text scaling.
  * Various graphics devices, e.g. a vector vs. raster format.
  * Explicit provision of the plot object `p` via `ggsave(..., plot = p)`. Show a situation in which this actually matters.

### Clean up your repo!

You have 6 weeks of R Markdown and GitHub experience now. You've reviewed 4 peer assignments. Surely there are aspects of your current repo organization that could be better. Deal with that. Ideas:

  * A nice Table of Contents in top-level README that links to individual pieces of work.
    - Good for future: `hw03 dplyr verbs`
    - Bummer in the future: `hw03`
    - Include a slug with content info!
  * Remove all downstream stuff, e.g. figures, html, etc. and re-render everything. It will be nice to not have weird, vestigial files lying around to puzzle you in future.
  * Anything that's `Rmd` but that could be `md`? Convert it.

### But I want to do more!

Make a deeper exploration of the forcats packages, i.e. try more of the factor level reordering functions.

Revalue a factor, e.g.:

  * ***Singer version***: Pick a handful of locations (they are named `city`, try using `distinct()`) that you can pinpoint to a geographical place (city, region, country, continent,...). Create an excerpt of the Singer data, filtered to just those rows. Create a (couple of) new factor(s) -- you pick the name(s)! -- by mapping the existing `city` factor levels to the new (city, region, country...) levels.
    - Examples: "London, England" --> "London", "England", "UK", "Europe";  
    - "Los Angeles, CA" --> "Los Angeles", "California", "USA", "Americas";
    - ...
    - "310, Louisiana" --> "New Orleans", "Louisiana", "USA", "Americas".  
    
  When you get tired, if you still have time on your hand, try to make this process of geolocalization more streamlined: you may want to try and use the `separate` function from tidyr.
  
  * ***Gapminder version***: Pick a handful of countries, each of which you can associate with a stereotypical food (or any other non-controversial thing ... sport? hobby? type of music, art or dance? animal? landscape feature?). Create an excerpt of the Gapminder data, filtered to just these countries. Create a new factor -- you pick the name! -- by mapping the existing country factor levels to the new levels.
    - Examples: Italy --> wine, Germany --> beer, Japan --> sake. (Austria, Germany) --> German, (Mexico, Spain) --> Spanish, (Portugal, Brazil) --> Portuguese. Let your creativity flourish.

### Report your process

You're encouraged to reflect on what was hard/easy, problems you solved, helpful tutorials you read, etc. Give credit to your sources, whether it's a blog post, a fellow student, an online tutorial, etc.

### Submit the assignment

It's always the same: add the teaching stuff as collabs, open the issue, you are done.


### Rubric

Check minus: One or more elements are missing or sketchy. Missed opportunities to complement code and numbers with a figure and interpretation. Technical problem that is relatively easy to fix. It's hard to find the report in this crazy repo.

Check: Hits all the elements. No obvious mistakes. Pleasant to read. No heroic detective work required. Well done! *This should be the most typical mark!*

Check plus: Exceeded the requirements in number of dimensions. Developed novel tasks that were indeed interesting and "worked". Impressive use of R -- maybe involving functions, packages or workflows that weren't given in class materials. Impeccable organization of repo and report. You learned something new from reviewing their work and you're eager to incorporate it into your work.

## Peer Review


The peer review is ready and is due __October 25, 2017__ (before midnight)! Here's what you'll need to do:

0. Find your github username in the table below. If it's not there, let Giulio know! Slack me `@giulio`.
1. Add the _people who will be giving you a review_ as collaborators to the repo containing your homework submission.
2. Give a review of this homework for the two people you've been assigned to. There should be an issue in their repo titled something like `hw0x ready for grading` -- put your review in there as a comment.
    - If there is no such issue, make one! (in _their_ repo)
    - Please don't mix up your reviewers and reviewees!

Check out the [guidelines for giving a peer review](http://stat545.com/peer-review02_peer-evaluation-guidelines.html).


Your_github       Instructions                                                                                                                                                                                                                                                                                              
----------------  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
abishekarun       Please add [ssheikho](https://github.com/ssheikho) and [santiagodr](https://github.com/santiagodr) as collaborators to your repo containing hw05. Please __review the hw05 submission of [rdwyer2](https://github.com/rdwyer2) and [Maria815](https://github.com/Maria815)__.                             
acavalla          Please add [Maria815](https://github.com/Maria815) and [emilymistick](https://github.com/emilymistick) as collaborators to your repo containing hw05. Please __review the hw05 submission of [cheungamanda](https://github.com/cheungamanda) and [lucymei](https://github.com/lucymei)__.                 
aiod01            Please add [jmurthy12](https://github.com/jmurthy12) and [sdhanani](https://github.com/gvdr/stat545-hw-dhanani-selina) as collaborators to your repo containing hw05. Please __review the hw05 submission of [k3vzhu](https://github.com/k3vzhu) and [ilgan](https://github.com/ilgan)__.                 
Alexander-Morin   Please add [danaj191](https://github.com/danaj191) and [arsbar24](https://github.com/arsbar24) as collaborators to your repo containing hw05. Please __review the hw05 submission of [juansbr7](https://github.com/juansbr7) and [wenzhengzzz](https://github.com/wenzhengzzz)__.                         
alexrod61         Please add [xinmiaow](https://github.com/xinmiaow) and [CassKon](https://github.com/CassKon) as collaborators to your repo containing hw05. Please __review the hw05 submission of [yidie](https://github.com/yidie) and [ZimingY](https://github.com/ZimingY)__.                                         
angmelanie        Please add [ZimingY](https://github.com/ZimingY) and [cindyhurtado](https://github.com/cindyhurtado) as collaborators to your repo containing hw05. Please __review the hw05 submission of [nbendriem](https://github.com/nbendriem) and [burkeprw](https://github.com/burkeprw)__.                       
arsbar24          Please add [Tangjiahui26](https://github.com/Tangjiahui26) and [danaj191](https://github.com/danaj191) as collaborators to your repo containing hw05. Please __review the hw05 submission of [Alexander-Morin](https://github.com/Alexander-Morin) and [juansbr7](https://github.com/juansbr7)__.         
arthursunbao      Please add [estennw](https://github.com/estennw) and [shadowforti](https://github.com/shadowforti) as collaborators to your repo containing hw05. Please __review the hw05 submission of [ChadFibke](https://github.com/ChadFibke) and [KateJohnson](https://github.com/KateJohnson)__.                   
auduman           Please add [yeonukkim](https://github.com/yeonukkim) and [vibudh2209](https://github.com/vibudh2209) as collaborators to your repo containing hw05. Please __review the hw05 submission of [Mathnstein](https://github.com/Mathnstein) and [vanflad](https://github.com/vanflad)__.                       
bcahn7            Please add [qiaoyuet](https://github.com/qiaoyuet) and [susannaelsie](https://github.com/susannaelsie) as collaborators to your repo containing hw05. Please __review the hw05 submission of [yuanjisun](https://github.com/yuanjisun) and [dorawyy](https://github.com/dorawyy)__.                       
burkeprw          Please add [angmelanie](https://github.com/angmelanie) and [nbendriem](https://github.com/nbendriem) as collaborators to your repo containing hw05. Please __review the hw05 submission of [winnietse1018](https://github.com/winnietse1018) and [SonjaS1](https://github.com/SonjaS1)__.                 
CassKon           Please add [mylinhthibodeau](https://github.com/mylinhthibodeau) and [xinmiaow](https://github.com/xinmiaow) as collaborators to your repo containing hw05. Please __review the hw05 submission of [alexrod61](https://github.com/alexrod61) and [yidie](https://github.com/yidie)__.                     
ChadFibke         Please add [shadowforti](https://github.com/shadowforti) and [arthursunbao](https://github.com/arthursunbao) as collaborators to your repo containing hw05. Please __review the hw05 submission of [KateJohnson](https://github.com/KateJohnson) and [wswade2](https://github.com/wswade2)__.             
cheungamanda      Please add [emilymistick](https://github.com/emilymistick) and [acavalla](https://github.com/acavalla) as collaborators to your repo containing hw05. Please __review the hw05 submission of [lucymei](https://github.com/lucymei) and [nicolehawe](https://github.com/nicolehawe)__.                     
cindyhurtado      Please add [yidie](https://github.com/yidie) and [ZimingY](https://github.com/ZimingY) as collaborators to your repo containing hw05. Please __review the hw05 submission of [angmelanie](https://github.com/angmelanie) and [nbendriem](https://github.com/nbendriem)__.                                 
danaj191          Please add [vmichalowski](https://github.com/vmichalowski) and [Tangjiahui26](https://github.com/Tangjiahui26) as collaborators to your repo containing hw05. Please __review the hw05 submission of [arsbar24](https://github.com/arsbar24) and [Alexander-Morin](https://github.com/Alexander-Morin)__. 
diermc            Please add [lucymei](https://github.com/lucymei) and [nicolehawe](https://github.com/nicolehawe) as collaborators to your repo containing hw05. Please __review the hw05 submission of [zxkathy](https://github.com/zxkathy) and [Jennica416](https://github.com/Jennica416)__.                           
dorawyy           Please add [bcahn7](https://github.com/bcahn7) and [yuanjisun](https://github.com/yuanjisun) as collaborators to your repo containing hw05. Please __review the hw05 submission of [hsmohammed](https://github.com/hsmohammed) and [ssheikho](https://github.com/ssheikho)__.                             
emilymistick      Please add [rdwyer2](https://github.com/rdwyer2) and [Maria815](https://github.com/Maria815) as collaborators to your repo containing hw05. Please __review the hw05 submission of [acavalla](https://github.com/acavalla) and [cheungamanda](https://github.com/cheungamanda)__.                         
estennw           Please add [mlawre01](https://github.com/mlawre01) and [heathersummers](https://github.com/heathersummers) as collaborators to your repo containing hw05. Please __review the hw05 submission of [shadowforti](https://github.com/shadowforti) and [arthursunbao](https://github.com/arthursunbao)__.     
farihakhan        Please add [Jennica416](https://github.com/Jennica416) and [Shirlett](https://github.com/Shirlett) as collaborators to your repo containing hw05. Please __review the hw05 submission of [margotgunning](https://github.com/margotgunning) and [swynes](https://github.com/swynes)__.                     
gbraich           Please add [oktokat](https://github.com/oktokat) and [marbazua](https://github.com/marbazua) as collaborators to your repo containing hw05. Please __review the hw05 submission of [rainerlempert](https://github.com/rainerlempert) and [hannahdxz](https://github.com/hannahdxz)__.                     
hannahdxz         Please add [gbraich](https://github.com/gbraich) and [rainerlempert](https://github.com/rainerlempert) as collaborators to your repo containing hw05. Please __review the hw05 submission of [julianheavyside](https://github.com/julianheavyside) and [mattsada](https://github.com/mattsada)__.         
heathersummers    Please add [HScheiber](https://github.com/HScheiber) and [mlawre01](https://github.com/mlawre01) as collaborators to your repo containing hw05. Please __review the hw05 submission of [estennw](https://github.com/estennw) and [shadowforti](https://github.com/shadowforti)__.                         
HScheiber         Please add [julianheavyside](https://github.com/julianheavyside) and [mattsada](https://github.com/mattsada) as collaborators to your repo containing hw05. Please __review the hw05 submission of [mlawre01](https://github.com/mlawre01) and [heathersummers](https://github.com/heathersummers)__.     
hsmohammed        Please add [yuanjisun](https://github.com/yuanjisun) and [dorawyy](https://github.com/dorawyy) as collaborators to your repo containing hw05. Please __review the hw05 submission of [ssheikho](https://github.com/ssheikho) and [santiagodr](https://github.com/santiagodr)__.                           
ilgan             Please add [aiod01](https://github.com/aiod01) and [k3vzhu](https://github.com/k3vzhu) as collaborators to your repo containing hw05. Please __review the hw05 submission of [teilhard1976](https://github.com/teilhard1976) and [OliviaTabares](https://github.com/OliviaTabares)__.                     
jenncscampbell    Please add [KateJohnson](https://github.com/KateJohnson) and [wswade2](https://github.com/wswade2) as collaborators to your repo containing hw05. Please __review the hw05 submission of [yanchaoluo](https://github.com/yanchaoluo) and [mylinhthibodeau](https://github.com/mylinhthibodeau)__.         
Jennica416        Please add [diermc](https://github.com/diermc) and [zxkathy](https://github.com/zxkathy) as collaborators to your repo containing hw05. Please __review the hw05 submission of [Shirlett](https://github.com/Shirlett) and [farihakhan](https://github.com/farihakhan)__.                                 
jmurthy12         Please add [sepkamal](https://github.com/sepkamal) and [navysealtf9k](https://github.com/navysealtf9k) as collaborators to your repo containing hw05. Please __review the hw05 submission of [sdhanani](https://github.com/gvdr/stat545-hw-dhanani-selina) and [aiod01](https://github.com/aiod01)__.     
juansbr7          Please add [arsbar24](https://github.com/arsbar24) and [Alexander-Morin](https://github.com/Alexander-Morin) as collaborators to your repo containing hw05. Please __review the hw05 submission of [wenzhengzzz](https://github.com/wenzhengzzz) and [menglinzhou](https://github.com/menglinzhou)__.     
julianheavyside   Please add [rainerlempert](https://github.com/rainerlempert) and [hannahdxz](https://github.com/hannahdxz) as collaborators to your repo containing hw05. Please __review the hw05 submission of [mattsada](https://github.com/mattsada) and [HScheiber](https://github.com/HScheiber)__.                 
k3vzhu            Please add [sdhanani](https://github.com/gvdr/stat545-hw-dhanani-selina) and [aiod01](https://github.com/aiod01) as collaborators to your repo containing hw05. Please __review the hw05 submission of [ilgan](https://github.com/ilgan) and [teilhard1976](https://github.com/teilhard1976)__.           
KateJohnson       Please add [arthursunbao](https://github.com/arthursunbao) and [ChadFibke](https://github.com/ChadFibke) as collaborators to your repo containing hw05. Please __review the hw05 submission of [wswade2](https://github.com/wswade2) and [jenncscampbell](https://github.com/jenncscampbell)__.           
Kozp              Please add [OliviaTabares](https://github.com/OliviaTabares) and [suminwei2772](https://github.com/suminwei2772) as collaborators to your repo containing hw05. Please __review the hw05 submission of [xinyaofan](https://github.com/xinyaofan) and [qiaoyuet](https://github.com/qiaoyuet)__.           
lucymei           Please add [acavalla](https://github.com/acavalla) and [cheungamanda](https://github.com/cheungamanda) as collaborators to your repo containing hw05. Please __review the hw05 submission of [nicolehawe](https://github.com/nicolehawe) and [diermc](https://github.com/diermc)__.                       
marbazua          Please add [vanflad](https://github.com/vanflad) and [oktokat](https://github.com/oktokat) as collaborators to your repo containing hw05. Please __review the hw05 submission of [gbraich](https://github.com/gbraich) and [rainerlempert](https://github.com/rainerlempert)__.                           
margotgunning     Please add [Shirlett](https://github.com/Shirlett) and [farihakhan](https://github.com/farihakhan) as collaborators to your repo containing hw05. Please __review the hw05 submission of [swynes](https://github.com/swynes) and [rishadhabib](https://github.com/rishadhabib)__.                         
Maria815          Please add [abishekarun](https://github.com/abishekarun) and [rdwyer2](https://github.com/rdwyer2) as collaborators to your repo containing hw05. Please __review the hw05 submission of [emilymistick](https://github.com/emilymistick) and [acavalla](https://github.com/acavalla)__.                   
Mathnstein        Please add [vibudh2209](https://github.com/vibudh2209) and [auduman](https://github.com/auduman) as collaborators to your repo containing hw05. Please __review the hw05 submission of [vanflad](https://github.com/vanflad) and [oktokat](https://github.com/oktokat)__.                                 
mattsada          Please add [hannahdxz](https://github.com/hannahdxz) and [julianheavyside](https://github.com/julianheavyside) as collaborators to your repo containing hw05. Please __review the hw05 submission of [HScheiber](https://github.com/HScheiber) and [mlawre01](https://github.com/mlawre01)__.             
menglinzhou       Please add [juansbr7](https://github.com/juansbr7) and [wenzhengzzz](https://github.com/wenzhengzzz) as collaborators to your repo containing hw05. Please __review the hw05 submission of [NSKrstic](https://github.com/NSKrstic) and [sepkamal](https://github.com/sepkamal)__.                         
mlawre01          Please add [mattsada](https://github.com/mattsada) and [HScheiber](https://github.com/HScheiber) as collaborators to your repo containing hw05. Please __review the hw05 submission of [heathersummers](https://github.com/heathersummers) and [estennw](https://github.com/estennw)__.                   
mylinhthibodeau   Please add [jenncscampbell](https://github.com/jenncscampbell) and [yanchaoluo](https://github.com/yanchaoluo) as collaborators to your repo containing hw05. Please __review the hw05 submission of [xinmiaow](https://github.com/xinmiaow) and [CassKon](https://github.com/CassKon)__.                 
navysealtf9k      Please add [NSKrstic](https://github.com/NSKrstic) and [sepkamal](https://github.com/sepkamal) as collaborators to your repo containing hw05. Please __review the hw05 submission of [jmurthy12](https://github.com/jmurthy12) and [sdhanani](https://github.com/gvdr/stat545-hw-dhanani-selina)__.       
nbendriem         Please add [cindyhurtado](https://github.com/cindyhurtado) and [angmelanie](https://github.com/angmelanie) as collaborators to your repo containing hw05. Please __review the hw05 submission of [burkeprw](https://github.com/burkeprw) and [winnietse1018](https://github.com/winnietse1018)__.         
nicolehawe        Please add [cheungamanda](https://github.com/cheungamanda) and [lucymei](https://github.com/lucymei) as collaborators to your repo containing hw05. Please __review the hw05 submission of [diermc](https://github.com/diermc) and [zxkathy](https://github.com/zxkathy)__.                               
NSKrstic          Please add [wenzhengzzz](https://github.com/wenzhengzzz) and [menglinzhou](https://github.com/menglinzhou) as collaborators to your repo containing hw05. Please __review the hw05 submission of [sepkamal](https://github.com/sepkamal) and [navysealtf9k](https://github.com/navysealtf9k)__.           
oktokat           Please add [Mathnstein](https://github.com/Mathnstein) and [vanflad](https://github.com/vanflad) as collaborators to your repo containing hw05. Please __review the hw05 submission of [marbazua](https://github.com/marbazua) and [gbraich](https://github.com/gbraich)__.                               
OliviaTabares     Please add [ilgan](https://github.com/ilgan) and [teilhard1976](https://github.com/teilhard1976) as collaborators to your repo containing hw05. Please __review the hw05 submission of [suminwei2772](https://github.com/suminwei2772) and [Kozp](https://github.com/Kozp)__.                             
peterwhitman      Please add [winnietse1018](https://github.com/winnietse1018) and [SonjaS1](https://github.com/SonjaS1) as collaborators to your repo containing hw05. Please __review the hw05 submission of [vmichalowski](https://github.com/vmichalowski) and [Tangjiahui26](https://github.com/Tangjiahui26)__.       
qiaoyuet          Please add [Kozp](https://github.com/Kozp) and [xinyaofan](https://github.com/xinyaofan) as collaborators to your repo containing hw05. Please __review the hw05 submission of [susannaelsie](https://github.com/susannaelsie) and [bcahn7](https://github.com/bcahn7)__.                                 
rainerlempert     Please add [marbazua](https://github.com/marbazua) and [gbraich](https://github.com/gbraich) as collaborators to your repo containing hw05. Please __review the hw05 submission of [hannahdxz](https://github.com/hannahdxz) and [julianheavyside](https://github.com/julianheavyside)__.                 
rdwyer2           Please add [santiagodr](https://github.com/santiagodr) and [abishekarun](https://github.com/abishekarun) as collaborators to your repo containing hw05. Please __review the hw05 submission of [Maria815](https://github.com/Maria815) and [emilymistick](https://github.com/emilymistick)__.             
rishadhabib       Please add [margotgunning](https://github.com/margotgunning) and [swynes](https://github.com/swynes) as collaborators to your repo containing hw05. Please __review the hw05 submission of [yeonukkim](https://github.com/yeonukkim) and [vibudh2209](https://github.com/vibudh2209)__.                   
santiagodr        Please add [hsmohammed](https://github.com/hsmohammed) and [ssheikho](https://github.com/ssheikho) as collaborators to your repo containing hw05. Please __review the hw05 submission of [abishekarun](https://github.com/abishekarun) and [rdwyer2](https://github.com/rdwyer2)__.                       
sdhanani          Please add [navysealtf9k](https://github.com/navysealtf9k) and [jmurthy12](https://github.com/jmurthy12) as collaborators to your repo containing hw05. Please __review the hw05 submission of [aiod01](https://github.com/aiod01) and [k3vzhu](https://github.com/k3vzhu)__.                             
sepkamal          Please add [menglinzhou](https://github.com/menglinzhou) and [NSKrstic](https://github.com/NSKrstic) as collaborators to your repo containing hw05. Please __review the hw05 submission of [navysealtf9k](https://github.com/navysealtf9k) and [jmurthy12](https://github.com/jmurthy12)__.               
shadowforti       Please add [heathersummers](https://github.com/heathersummers) and [estennw](https://github.com/estennw) as collaborators to your repo containing hw05. Please __review the hw05 submission of [arthursunbao](https://github.com/arthursunbao) and [ChadFibke](https://github.com/ChadFibke)__.           
Shirlett          Please add [zxkathy](https://github.com/zxkathy) and [Jennica416](https://github.com/Jennica416) as collaborators to your repo containing hw05. Please __review the hw05 submission of [farihakhan](https://github.com/farihakhan) and [margotgunning](https://github.com/margotgunning)__.               
SonjaS1           Please add [burkeprw](https://github.com/burkeprw) and [winnietse1018](https://github.com/winnietse1018) as collaborators to your repo containing hw05. Please __review the hw05 submission of [peterwhitman](https://github.com/peterwhitman) and [vmichalowski](https://github.com/vmichalowski)__.     
ssheikho          Please add [dorawyy](https://github.com/dorawyy) and [hsmohammed](https://github.com/hsmohammed) as collaborators to your repo containing hw05. Please __review the hw05 submission of [santiagodr](https://github.com/santiagodr) and [abishekarun](https://github.com/abishekarun)__.                   
suminwei2772      Please add [teilhard1976](https://github.com/teilhard1976) and [OliviaTabares](https://github.com/OliviaTabares) as collaborators to your repo containing hw05. Please __review the hw05 submission of [Kozp](https://github.com/Kozp) and [xinyaofan](https://github.com/xinyaofan)__.                   
susannaelsie      Please add [xinyaofan](https://github.com/xinyaofan) and [qiaoyuet](https://github.com/qiaoyuet) as collaborators to your repo containing hw05. Please __review the hw05 submission of [bcahn7](https://github.com/bcahn7) and [yuanjisun](https://github.com/yuanjisun)__.                               
swynes            Please add [farihakhan](https://github.com/farihakhan) and [margotgunning](https://github.com/margotgunning) as collaborators to your repo containing hw05. Please __review the hw05 submission of [rishadhabib](https://github.com/rishadhabib) and [yeonukkim](https://github.com/yeonukkim)__.         
Tangjiahui26      Please add [peterwhitman](https://github.com/peterwhitman) and [vmichalowski](https://github.com/vmichalowski) as collaborators to your repo containing hw05. Please __review the hw05 submission of [danaj191](https://github.com/danaj191) and [arsbar24](https://github.com/arsbar24)__.               
teilhard1976      Please add [k3vzhu](https://github.com/k3vzhu) and [ilgan](https://github.com/ilgan) as collaborators to your repo containing hw05. Please __review the hw05 submission of [OliviaTabares](https://github.com/OliviaTabares) and [suminwei2772](https://github.com/suminwei2772)__.                       
vanflad           Please add [auduman](https://github.com/auduman) and [Mathnstein](https://github.com/Mathnstein) as collaborators to your repo containing hw05. Please __review the hw05 submission of [oktokat](https://github.com/oktokat) and [marbazua](https://github.com/marbazua)__.                               
vibudh2209        Please add [rishadhabib](https://github.com/rishadhabib) and [yeonukkim](https://github.com/yeonukkim) as collaborators to your repo containing hw05. Please __review the hw05 submission of [auduman](https://github.com/auduman) and [Mathnstein](https://github.com/Mathnstein)__.                     
vmichalowski      Please add [SonjaS1](https://github.com/SonjaS1) and [peterwhitman](https://github.com/peterwhitman) as collaborators to your repo containing hw05. Please __review the hw05 submission of [Tangjiahui26](https://github.com/Tangjiahui26) and [danaj191](https://github.com/danaj191)__.                 
wenzhengzzz       Please add [Alexander-Morin](https://github.com/Alexander-Morin) and [juansbr7](https://github.com/juansbr7) as collaborators to your repo containing hw05. Please __review the hw05 submission of [menglinzhou](https://github.com/menglinzhou) and [NSKrstic](https://github.com/NSKrstic)__.           
winnietse1018     Please add [nbendriem](https://github.com/nbendriem) and [burkeprw](https://github.com/burkeprw) as collaborators to your repo containing hw05. Please __review the hw05 submission of [SonjaS1](https://github.com/SonjaS1) and [peterwhitman](https://github.com/peterwhitman)__.                       
wswade2           Please add [ChadFibke](https://github.com/ChadFibke) and [KateJohnson](https://github.com/KateJohnson) as collaborators to your repo containing hw05. Please __review the hw05 submission of [jenncscampbell](https://github.com/jenncscampbell) and [yanchaoluo](https://github.com/yanchaoluo)__.       
xinmiaow          Please add [yanchaoluo](https://github.com/yanchaoluo) and [mylinhthibodeau](https://github.com/mylinhthibodeau) as collaborators to your repo containing hw05. Please __review the hw05 submission of [CassKon](https://github.com/CassKon) and [alexrod61](https://github.com/alexrod61)__.             
xinyaofan         Please add [suminwei2772](https://github.com/suminwei2772) and [Kozp](https://github.com/Kozp) as collaborators to your repo containing hw05. Please __review the hw05 submission of [qiaoyuet](https://github.com/qiaoyuet) and [susannaelsie](https://github.com/susannaelsie)__.                       
yanchaoluo        Please add [wswade2](https://github.com/wswade2) and [jenncscampbell](https://github.com/jenncscampbell) as collaborators to your repo containing hw05. Please __review the hw05 submission of [mylinhthibodeau](https://github.com/mylinhthibodeau) and [xinmiaow](https://github.com/xinmiaow)__.       
yeonukkim         Please add [swynes](https://github.com/swynes) and [rishadhabib](https://github.com/rishadhabib) as collaborators to your repo containing hw05. Please __review the hw05 submission of [vibudh2209](https://github.com/vibudh2209) and [auduman](https://github.com/auduman)__.                           
yidie             Please add [CassKon](https://github.com/CassKon) and [alexrod61](https://github.com/alexrod61) as collaborators to your repo containing hw05. Please __review the hw05 submission of [ZimingY](https://github.com/ZimingY) and [cindyhurtado](https://github.com/cindyhurtado)__.                         
yuanjisun         Please add [susannaelsie](https://github.com/susannaelsie) and [bcahn7](https://github.com/bcahn7) as collaborators to your repo containing hw05. Please __review the hw05 submission of [dorawyy](https://github.com/dorawyy) and [hsmohammed](https://github.com/hsmohammed)__.                         
ZimingY           Please add [alexrod61](https://github.com/alexrod61) and [yidie](https://github.com/yidie) as collaborators to your repo containing hw05. Please __review the hw05 submission of [cindyhurtado](https://github.com/cindyhurtado) and [angmelanie](https://github.com/angmelanie)__.                       
zxkathy           Please add [nicolehawe](https://github.com/nicolehawe) and [diermc](https://github.com/diermc) as collaborators to your repo containing hw05. Please __review the hw05 submission of [Jennica416](https://github.com/Jennica416) and [Shirlett](https://github.com/Shirlett)__.                           
