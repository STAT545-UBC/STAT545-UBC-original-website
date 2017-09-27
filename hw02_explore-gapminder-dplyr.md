# Homework 02: Explore Gapminder and use dplyr

### Overview

Consult the [general homework guidelines](hw00_homework-guidelines.html). Though, you still won't be using a repo in the stat545 github org. This may or may not happen this year! See [Make a homework repo](#make-a-homework-repo) below for guidelines on making a repo.

Due anytime Tuesday 2017-09-26. Before class is better, but get help in class or office hours of you need it.

The goal is to explore a new-to-you dataset. In particular, to begin to establish a workflow for data frames or "tibbles". You will use dplyr and ggplot2 to do some description and visualization.

Your homework should serve as your own personal cheatsheet in the future for things to do with a new dataset. Give yourself the cheatsheet you deserve!

#### Make a homework repo

We might not be getting you a repo in the stat545 github org. Time will tell! For now, we will make a new GitHub repository that will hold the remainder of your homework submissions (until specified otherwise). 

1. Make a new GitHub repo called `STAT545-hw-lastname-firstname`. Note:
    - Feel free to just use your Homework 01 repo, and rename it.
    - If you want your homework to be private, here are your options:
        - Request a GitHub [student developer pack](https://education.github.com/pack). It's free and will allow you to make free GitHub repos.
        - Use [Bitbucket](https://bitbucket.org/). It's free, gives you free private repos, and works similarly to github. Let me (`@vcoia`) know via Slack if you'd like to try this.
        - Slack me if neither of these are good. I've got another option.

2. Put your Homework 02 files in a folder that's obviously named (say, `hw02`), and link to it in the main README. Be sure to put a README file in the Homework 02 folder as well, describing what's what in the directory and how someone might navigate the homework submission.


#### Bring rectangular data in

Work with the `gapminder` data we explored in class. *If you really want to, you can explore a different dataset but get permission from Vincenzo. Message me on Slack -- my handle is `@vcoia`. Self-assess the suitability of your dataset by reading [this issue](https://github.com/STAT545-UBC/Discussion/issues/115).*

The Gapminder data is distributed as an R package from [CRAN](https://cran.r-project.org/web/packages/gapminder/index.html).

Install it if you have not done so already and remember to load it.

``` r
install.packages("gapminder")
library(gapminder)
```

Install and load dplyr. Probably via the tidyverse meta-package.

``` r
install.packages("tidyverse")
library(tidyverse)
```

#### Smell test the data

Explore the `gapminder` object:

  * Is it a data.frame, a matrix, a vector, a list?
  * What's its class?
  * How many variables/columns?
  * How many rows/observations?
  * Can you get these facts about "extent" or "size" in more than one way? Can you imagine different functions being useful in different contexts?
  * What data type is each variable?

Be sure to justify your answers by calling the appropriate R functions. 

#### Explore individual variables

Pick __at least__ one categorical variable and at least one quantitative variable to explore.

  * What are possible values (or range, whichever is appropriate) of each variable?
  * What values are typical? What's the spread? What's the distribution? Etc., tailored to the variable at hand.
  * Feel free to use summary stats, tables, figures. We're NOT expecting high production value (yet).

#### Explore various plot types

See the [`ggplot2` tutorial](https://github.com/jennybc/ggplot2-tutorial), which also uses the `gapminder` data, for ideas.

Make a few plots, probably of the same variable you chose to characterize numerically. Try to explore more than one plot type. **Just as an example** of what I mean:

  * A scatterplot of two quantitative variables.
  * A plot of one quantitative variable. Maybe a histogram or densityplot or frequency polygon.
  * A plot of one quantitative variable and one categorical. Maybe boxplots for several continents or countries.

You don't have to use all the data in every plot! It's fine to filter down to one country or small handful of countries.

#### Use `filter()`, `select()` and `%>%`

Use `filter()` to create data subsets that you want to plot.

Practice piping together `filter()` and `select()`. Possibly even piping into `ggplot()`.

#### But I want to do more!

*For people who want to take things further.*

Evaluate this code and describe the result. Presumably the analyst's intent was to get the data for Rwanda and Afghanistan. Did they succeed? Why or why not? If not, what is the correct way to do this?

```
filter(gapminder, country == c("Rwanda", "Afghanistan"))
```

Read [What I do when I get a new data set as told through tweets](http://simplystatistics.org/2014/06/13/what-i-do-when-i-get-a-new-data-set-as-told-through-tweets/) from [SimplyStatistics](http://simplystatistics.org) to get some ideas!

Present numerical tables in a more attractive form, such as using `knitr::kable()`.

Use more of the dplyr functions for operating on a single table.

  * [Introduction to dplyr](block009_dplyr-intro.html)
  * [`dplyr` functions for a single dataset](block010_dplyr-end-single-table.html)

Adapt exercises from the chapters in the "Explore" section of [R for Data Science](http://r4ds.had.co.nz) to the Gapminder dataset.

### Report your process

Reflect on what was hard/easy, problems you solved, helpful tutorials you read, etc. What things were hard, even though you saw them in class? What was easy(-ish) even though we haven't done it in class?

### Submit the assignment

As in Homework 01:

1. Add the teaching team as collaborators, if you haven't done that already. Their github alias' are:

> vincenzocoia
> gvdr
> ksedivyhaley
> joeybernhardt
> mynamedaike
> pgonzaleze
> derekcho


2. Write a new issue entitled `hw02 ready for grading`, and tag the above teaching team. Here's a convenient string to copy and paste to tag the team:

> @vincenzocoia @gvdr @ksedivyhaley @joeybernhardt @mynamedaike @pgonzaleze @derekcho

3. You're done!

### Rubric

Our [general rubric](peer-review01_marking-rubric.html) applies, but also ...

Check minus: There are some mistakes or omissions, such as the number of rows or variables in the data frame. Or maybe no confirmation of its class or that of the variables inside. There are no plots or there's just one type of plot (and its probably a scatterplot). There's no use of `filter()` or `select()`. It's hard to figure out which file I'm supposed to be looking at. Maybe the student forgot to commit and push the figures to GitHub.

Check: Hits all the elements. No obvious mistakes. Pleasant to read. No heroic detective work required. Solid.

Check plus: Some "above and beyond", creativity, etc. You learned something new from reviewing their work and you're eager to incorporate it into your work now. Use of dplyr goes beyond `filter()` and `select()`. The ggplot2 figures are quite diverse. The repo is very organized and it's a breeze to find the file for this homework specifically.

## Peer Review


The peer review is ready and is due __October 2, 2017__! Here's what you'll need to do:

0. Find your github username in the table below. If it's not there, let Vincenzo know! Slack me `@vcoia`.
1. Add the _people who will be giving you a review_ as collaborators to the repo containing your homework submission.
2. Give a review of this homework for the two people you've been assigned to. There should be an issue in their repo titled something like `hw0x ready for grading` -- put your review in there as a comment.
    - If there is no such issue, make one! (in _their_ repo)
    - Please don't mix up your reviewers and reviewees! 

Check out the [guidelines for giving a peer review](http://stat545.com/peer-review02_peer-evaluation-guidelines.html).


Your_github       Instructions                                                                                                                                                                                                                                                                                                        
----------------  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
abishekarun       Please add [mylinhthibodeau](https://github.com/mylinhthibodeau) and [teilhard1976](https://github.com/teilhard1976) as collaborators to your repo containing hw02. Please __review the hw02 submission of [winnietse1018](https://github.com/winnietse1018) and [emilymistick](https://github.com/emilymistick)__. 
acavalla          Please add [mlawre01](https://github.com/mlawre01) and [yuanjisun](https://github.com/yuanjisun) as collaborators to your repo containing hw02. Please __review the hw02 submission of [susannaelsie](https://github.com/susannaelsie) and [ilgan](https://github.com/ilgan)__.                                     
aiod01            Please add [swynes](https://github.com/swynes) and [zxkathy](https://github.com/zxkathy) as collaborators to your repo containing hw02. Please __review the hw02 submission of [hsummers](https://github.com/hsummers) and [rainerlempert](https://github.com/rainerlempert)__.                                     
Alexander-Morin   Please add [estennw](https://github.com/estennw) and [sdhanani](https://github.com/sdhanani) as collaborators to your repo containing hw02. Please __review the hw02 submission of [HScheiber](https://github.com/HScheiber) and [qiaoyuet](https://github.com/qiaoyuet)__.                                         
alexrod61         Please add [qiaoyuet](https://github.com/qiaoyuet) and [auduman](https://github.com/auduman) as collaborators to your repo containing hw02. Please __review the hw02 submission of [julianheavyside](https://github.com/julianheavyside) and [Jennica416](https://github.com/Jennica416)__.                         
angmelanie        Please add [hannahdxz](https://github.com/hannahdxz) and [oktokat](https://github.com/oktokat) as collaborators to your repo containing hw02. Please __review the hw02 submission of [wswade2](https://github.com/wswade2) and [NSKrstic](https://github.com/NSKrstic)__.                                           
arsbar24          Please add [peterwhitman](https://github.com/peterwhitman) and [nbendriem](https://github.com/nbendriem) as collaborators to your repo containing hw02. Please __review the hw02 submission of [ZimingY](https://github.com/ZimingY) and [mattsada](https://github.com/mattsada)__.                                 
arthursunbao      Please add [OliviaTabares](https://github.com/OliviaTabares) and [Maria815](https://github.com/Maria815) as collaborators to your repo containing hw02. Please __review the hw02 submission of [shadowforti](https://github.com/shadowforti) and [marbazua](https://github.com/marbazua)__.                         
auduman           Please add [HScheiber](https://github.com/HScheiber) and [qiaoyuet](https://github.com/qiaoyuet) as collaborators to your repo containing hw02. Please __review the hw02 submission of [alexrod61](https://github.com/alexrod61) and [julianheavyside](https://github.com/julianheavyside)__.                       
bcahn7            Please add [Kozp](https://github.com/Kozp) and [jenncscampbell](https://github.com/jenncscampbell) as collaborators to your repo containing hw02. Please __review the hw02 submission of [mylinhthibodeau](https://github.com/mylinhthibodeau) and [teilhard1976](https://github.com/teilhard1976)__.               
burkeprw          Please add [Tangjiahui26](https://github.com/Tangjiahui26) and [yeonukkim](https://github.com/yeonukkim) as collaborators to your repo containing hw02. Please __review the hw02 submission of [Shirlett](https://github.com/Shirlett) and [OliviaTabares](https://github.com/OliviaTabares)__.                     
CassKon           Please add [farihakhan](https://github.com/farihakhan) and [vibudh2209](https://github.com/vibudh2209) as collaborators to your repo containing hw02. Please __review the hw02 submission of [cheungamanda](https://github.com/cheungamanda) and [sepkamal](https://github.com/sepkamal)__.                         
ChadFibke         Please add [NSKrstic](https://github.com/NSKrstic) and [rdwyer2](https://github.com/rdwyer2) as collaborators to your repo containing hw02. Please __review the hw02 submission of [menglinzhou](https://github.com/menglinzhou) and [diermc](https://github.com/diermc)__.                                         
cheungamanda      Please add [vibudh2209](https://github.com/vibudh2209) and [CassKon](https://github.com/CassKon) as collaborators to your repo containing hw02. Please __review the hw02 submission of [sepkamal](https://github.com/sepkamal) and [cindyhurtado](https://github.com/cindyhurtado)__.                               
cindyhurtado      Please add [cheungamanda](https://github.com/cheungamanda) and [sepkamal](https://github.com/sepkamal) as collaborators to your repo containing hw02. Please __review the hw02 submission of [juansbr7](https://github.com/juansbr7) and [Mathnstein](https://github.com/Mathnstein)__.                             
danaj191          Please add [rainerlempert](https://github.com/rainerlempert) and [yidie](https://github.com/yidie) as collaborators to your repo containing hw02. Please __review the hw02 submission of [suminwei2772](https://github.com/suminwei2772) and [estennw](https://github.com/estennw)__.                               
diermc            Please add [ChadFibke](https://github.com/ChadFibke) and [menglinzhou](https://github.com/menglinzhou) as collaborators to your repo containing hw02. Please __review the hw02 submission of [gbraich](https://github.com/gbraich) and [nicolehawe](https://github.com/nicolehawe)__.                               
dorawyy           Please add [emilymistick](https://github.com/emilymistick) and [yanchaoluo](https://github.com/yanchaoluo) as collaborators to your repo containing hw02. Please __review the hw02 submission of [k3vzhu](https://github.com/k3vzhu) and [farihakhan](https://github.com/farihakhan)__.                             
emilymistick      Please add [abishekarun](https://github.com/abishekarun) and [winnietse1018](https://github.com/winnietse1018) as collaborators to your repo containing hw02. Please __review the hw02 submission of [yanchaoluo](https://github.com/yanchaoluo) and [dorawyy](https://github.com/dorawyy)__.                       
estennw           Please add [danaj191](https://github.com/danaj191) and [suminwei2772](https://github.com/suminwei2772) as collaborators to your repo containing hw02. Please __review the hw02 submission of [sdhanani](https://github.com/sdhanani) and [Alexander-Morin](https://github.com/Alexander-Morin)__.                   
farihakhan        Please add [dorawyy](https://github.com/dorawyy) and [k3vzhu](https://github.com/k3vzhu) as collaborators to your repo containing hw02. Please __review the hw02 submission of [vibudh2209](https://github.com/vibudh2209) and [CassKon](https://github.com/CassKon)__.                                             
gbraich           Please add [menglinzhou](https://github.com/menglinzhou) and [diermc](https://github.com/diermc) as collaborators to your repo containing hw02. Please __review the hw02 submission of [nicolehawe](https://github.com/nicolehawe) and [mlawre01](https://github.com/mlawre01)__.                                   
hannahdxz         Please add [margotgunning](https://github.com/margotgunning) and [wenzhengzzz](https://github.com/wenzhengzzz) as collaborators to your repo containing hw02. Please __review the hw02 submission of [oktokat](https://github.com/oktokat) and [angmelanie](https://github.com/angmelanie)__.                       
HScheiber         Please add [sdhanani](https://github.com/sdhanani) and [Alexander-Morin](https://github.com/Alexander-Morin) as collaborators to your repo containing hw02. Please __review the hw02 submission of [qiaoyuet](https://github.com/qiaoyuet) and [auduman](https://github.com/auduman)__.                             
hsmohammed        Please add [julianheavyside](https://github.com/julianheavyside) and [Jennica416](https://github.com/Jennica416) as collaborators to your repo containing hw02. Please __review the hw02 submission of [peterwhitman](https://github.com/peterwhitman) and [nbendriem](https://github.com/nbendriem)__.             
hsummers          Please add [zxkathy](https://github.com/zxkathy) and [aiod01](https://github.com/aiod01) as collaborators to your repo containing hw02. Please __review the hw02 submission of [rainerlempert](https://github.com/rainerlempert) and [yidie](https://github.com/yidie)__.                                           
ilgan             Please add [acavalla](https://github.com/acavalla) and [susannaelsie](https://github.com/susannaelsie) as collaborators to your repo containing hw02. Please __review the hw02 submission of [rishadhabib](https://github.com/rishadhabib) and [lucymei](https://github.com/lucymei)__.                             
jenncscampbell    Please add [navysealtf9k](https://github.com/navysealtf9k) and [Kozp](https://github.com/Kozp) as collaborators to your repo containing hw02. Please __review the hw02 submission of [bcahn7](https://github.com/bcahn7) and [mylinhthibodeau](https://github.com/mylinhthibodeau)__.                               
Jennica416        Please add [alexrod61](https://github.com/alexrod61) and [julianheavyside](https://github.com/julianheavyside) as collaborators to your repo containing hw02. Please __review the hw02 submission of [hsmohammed](https://github.com/hsmohammed) and [peterwhitman](https://github.com/peterwhitman)__.             
jmurthy12         Please add [shadowforti](https://github.com/shadowforti) and [marbazua](https://github.com/marbazua) as collaborators to your repo containing hw02. Please __review the hw02 submission of [xinmiaow](https://github.com/xinmiaow) and [ssheikho](https://github.com/ssheikho)__.                                   
juansbr7          Please add [sepkamal](https://github.com/sepkamal) and [cindyhurtado](https://github.com/cindyhurtado) as collaborators to your repo containing hw02. Please __review the hw02 submission of [Mathnstein](https://github.com/Mathnstein) and [swynes](https://github.com/swynes)__.                                 
julianheavyside   Please add [auduman](https://github.com/auduman) and [alexrod61](https://github.com/alexrod61) as collaborators to your repo containing hw02. Please __review the hw02 submission of [Jennica416](https://github.com/Jennica416) and [hsmohammed](https://github.com/hsmohammed)__.                                 
k3vzhu            Please add [yanchaoluo](https://github.com/yanchaoluo) and [dorawyy](https://github.com/dorawyy) as collaborators to your repo containing hw02. Please __review the hw02 submission of [farihakhan](https://github.com/farihakhan) and [vibudh2209](https://github.com/vibudh2209)__.                               
KateJohnson       Please add [santiagodr](https://github.com/santiagodr) and [vmichalowski](https://github.com/vmichalowski) as collaborators to your repo containing hw02. Please __review the hw02 submission of [navysealtf9k](https://github.com/navysealtf9k) and [Kozp](https://github.com/Kozp)__.                             
Kozp              Please add [KateJohnson](https://github.com/KateJohnson) and [navysealtf9k](https://github.com/navysealtf9k) as collaborators to your repo containing hw02. Please __review the hw02 submission of [jenncscampbell](https://github.com/jenncscampbell) and [bcahn7](https://github.com/bcahn7)__.                   
lucymei           Please add [ilgan](https://github.com/ilgan) and [rishadhabib](https://github.com/rishadhabib) as collaborators to your repo containing hw02. Please __review the hw02 submission of [santiagodr](https://github.com/santiagodr) and [vmichalowski](https://github.com/vmichalowski)__.                             
marbazua          Please add [arthursunbao](https://github.com/arthursunbao) and [shadowforti](https://github.com/shadowforti) as collaborators to your repo containing hw02. Please __review the hw02 submission of [jmurthy12](https://github.com/jmurthy12) and [xinmiaow](https://github.com/xinmiaow)__.                         
margotgunning     Please add [ssheikho](https://github.com/ssheikho) and [xinyaofan](https://github.com/xinyaofan) as collaborators to your repo containing hw02. Please __review the hw02 submission of [wenzhengzzz](https://github.com/wenzhengzzz) and [hannahdxz](https://github.com/hannahdxz)__.                               
Maria815          Please add [Shirlett](https://github.com/Shirlett) and [OliviaTabares](https://github.com/OliviaTabares) as collaborators to your repo containing hw02. Please __review the hw02 submission of [arthursunbao](https://github.com/arthursunbao) and [shadowforti](https://github.com/shadowforti)__.                 
Mathnstein        Please add [cindyhurtado](https://github.com/cindyhurtado) and [juansbr7](https://github.com/juansbr7) as collaborators to your repo containing hw02. Please __review the hw02 submission of [swynes](https://github.com/swynes) and [zxkathy](https://github.com/zxkathy)__.                                       
mattsada          Please add [arsbar24](https://github.com/arsbar24) and [ZimingY](https://github.com/ZimingY) as collaborators to your repo containing hw02. Please __review the hw02 submission of [vanflad](https://github.com/vanflad) and [SonjaS1](https://github.com/SonjaS1)__.                                               
menglinzhou       Please add [rdwyer2](https://github.com/rdwyer2) and [ChadFibke](https://github.com/ChadFibke) as collaborators to your repo containing hw02. Please __review the hw02 submission of [diermc](https://github.com/diermc) and [gbraich](https://github.com/gbraich)__.                                               
mlawre01          Please add [gbraich](https://github.com/gbraich) and [nicolehawe](https://github.com/nicolehawe) as collaborators to your repo containing hw02. Please __review the hw02 submission of [yuanjisun](https://github.com/yuanjisun) and [acavalla](https://github.com/acavalla)__.                                     
mylinhthibodeau   Please add [jenncscampbell](https://github.com/jenncscampbell) and [bcahn7](https://github.com/bcahn7) as collaborators to your repo containing hw02. Please __review the hw02 submission of [teilhard1976](https://github.com/teilhard1976) and [abishekarun](https://github.com/abishekarun)__.                   
navysealtf9k      Please add [vmichalowski](https://github.com/vmichalowski) and [KateJohnson](https://github.com/KateJohnson) as collaborators to your repo containing hw02. Please __review the hw02 submission of [Kozp](https://github.com/Kozp) and [jenncscampbell](https://github.com/jenncscampbell)__.                       
nbendriem         Please add [hsmohammed](https://github.com/hsmohammed) and [peterwhitman](https://github.com/peterwhitman) as collaborators to your repo containing hw02. Please __review the hw02 submission of [arsbar24](https://github.com/arsbar24) and [ZimingY](https://github.com/ZimingY)__.                               
nicolehawe        Please add [diermc](https://github.com/diermc) and [gbraich](https://github.com/gbraich) as collaborators to your repo containing hw02. Please __review the hw02 submission of [mlawre01](https://github.com/mlawre01) and [yuanjisun](https://github.com/yuanjisun)__.                                             
NSKrstic          Please add [angmelanie](https://github.com/angmelanie) and [wswade2](https://github.com/wswade2) as collaborators to your repo containing hw02. Please __review the hw02 submission of [rdwyer2](https://github.com/rdwyer2) and [ChadFibke](https://github.com/ChadFibke)__.                                       
oktokat           Please add [wenzhengzzz](https://github.com/wenzhengzzz) and [hannahdxz](https://github.com/hannahdxz) as collaborators to your repo containing hw02. Please __review the hw02 submission of [angmelanie](https://github.com/angmelanie) and [wswade2](https://github.com/wswade2)__.                               
OliviaTabares     Please add [burkeprw](https://github.com/burkeprw) and [Shirlett](https://github.com/Shirlett) as collaborators to your repo containing hw02. Please __review the hw02 submission of [Maria815](https://github.com/Maria815) and [arthursunbao](https://github.com/arthursunbao)__.                                 
peterwhitman      Please add [Jennica416](https://github.com/Jennica416) and [hsmohammed](https://github.com/hsmohammed) as collaborators to your repo containing hw02. Please __review the hw02 submission of [nbendriem](https://github.com/nbendriem) and [arsbar24](https://github.com/arsbar24)__.                               
qiaoyuet          Please add [Alexander-Morin](https://github.com/Alexander-Morin) and [HScheiber](https://github.com/HScheiber) as collaborators to your repo containing hw02. Please __review the hw02 submission of [auduman](https://github.com/auduman) and [alexrod61](https://github.com/alexrod61)__.                         
rainerlempert     Please add [aiod01](https://github.com/aiod01) and [hsummers](https://github.com/hsummers) as collaborators to your repo containing hw02. Please __review the hw02 submission of [yidie](https://github.com/yidie) and [danaj191](https://github.com/danaj191)__.                                                   
rdwyer2           Please add [wswade2](https://github.com/wswade2) and [NSKrstic](https://github.com/NSKrstic) as collaborators to your repo containing hw02. Please __review the hw02 submission of [ChadFibke](https://github.com/ChadFibke) and [menglinzhou](https://github.com/menglinzhou)__.                                   
rishadhabib       Please add [susannaelsie](https://github.com/susannaelsie) and [ilgan](https://github.com/ilgan) as collaborators to your repo containing hw02. Please __review the hw02 submission of [lucymei](https://github.com/lucymei) and [santiagodr](https://github.com/santiagodr)__.                                     
santiagodr        Please add [rishadhabib](https://github.com/rishadhabib) and [lucymei](https://github.com/lucymei) as collaborators to your repo containing hw02. Please __review the hw02 submission of [vmichalowski](https://github.com/vmichalowski) and [KateJohnson](https://github.com/KateJohnson)__.                       
sdhanani          Please add [suminwei2772](https://github.com/suminwei2772) and [estennw](https://github.com/estennw) as collaborators to your repo containing hw02. Please __review the hw02 submission of [Alexander-Morin](https://github.com/Alexander-Morin) and [HScheiber](https://github.com/HScheiber)__.                   
sepkamal          Please add [CassKon](https://github.com/CassKon) and [cheungamanda](https://github.com/cheungamanda) as collaborators to your repo containing hw02. Please __review the hw02 submission of [cindyhurtado](https://github.com/cindyhurtado) and [juansbr7](https://github.com/juansbr7)__.                           
shadowforti       Please add [Maria815](https://github.com/Maria815) and [arthursunbao](https://github.com/arthursunbao) as collaborators to your repo containing hw02. Please __review the hw02 submission of [marbazua](https://github.com/marbazua) and [jmurthy12](https://github.com/jmurthy12)__.                               
Shirlett          Please add [yeonukkim](https://github.com/yeonukkim) and [burkeprw](https://github.com/burkeprw) as collaborators to your repo containing hw02. Please __review the hw02 submission of [OliviaTabares](https://github.com/OliviaTabares) and [Maria815](https://github.com/Maria815)__.                             
SonjaS1           Please add [mattsada](https://github.com/mattsada) and [vanflad](https://github.com/vanflad) as collaborators to your repo containing hw02. Please __review the hw02 submission of [Tangjiahui26](https://github.com/Tangjiahui26) and [yeonukkim](https://github.com/yeonukkim)__.                                 
ssheikho          Please add [jmurthy12](https://github.com/jmurthy12) and [xinmiaow](https://github.com/xinmiaow) as collaborators to your repo containing hw02. Please __review the hw02 submission of [xinyaofan](https://github.com/xinyaofan) and [margotgunning](https://github.com/margotgunning)__.                           
suminwei2772      Please add [yidie](https://github.com/yidie) and [danaj191](https://github.com/danaj191) as collaborators to your repo containing hw02. Please __review the hw02 submission of [estennw](https://github.com/estennw) and [sdhanani](https://github.com/sdhanani)__.                                                 
susannaelsie      Please add [yuanjisun](https://github.com/yuanjisun) and [acavalla](https://github.com/acavalla) as collaborators to your repo containing hw02. Please __review the hw02 submission of [ilgan](https://github.com/ilgan) and [rishadhabib](https://github.com/rishadhabib)__.                                       
swynes            Please add [juansbr7](https://github.com/juansbr7) and [Mathnstein](https://github.com/Mathnstein) as collaborators to your repo containing hw02. Please __review the hw02 submission of [zxkathy](https://github.com/zxkathy) and [aiod01](https://github.com/aiod01)__.                                           
Tangjiahui26      Please add [vanflad](https://github.com/vanflad) and [SonjaS1](https://github.com/SonjaS1) as collaborators to your repo containing hw02. Please __review the hw02 submission of [yeonukkim](https://github.com/yeonukkim) and [burkeprw](https://github.com/burkeprw)__.                                           
teilhard1976      Please add [bcahn7](https://github.com/bcahn7) and [mylinhthibodeau](https://github.com/mylinhthibodeau) as collaborators to your repo containing hw02. Please __review the hw02 submission of [abishekarun](https://github.com/abishekarun) and [winnietse1018](https://github.com/winnietse1018)__.               
vanflad           Please add [ZimingY](https://github.com/ZimingY) and [mattsada](https://github.com/mattsada) as collaborators to your repo containing hw02. Please __review the hw02 submission of [SonjaS1](https://github.com/SonjaS1) and [Tangjiahui26](https://github.com/Tangjiahui26)__.                                     
vibudh2209        Please add [k3vzhu](https://github.com/k3vzhu) and [farihakhan](https://github.com/farihakhan) as collaborators to your repo containing hw02. Please __review the hw02 submission of [CassKon](https://github.com/CassKon) and [cheungamanda](https://github.com/cheungamanda)__.                                   
vmichalowski      Please add [lucymei](https://github.com/lucymei) and [santiagodr](https://github.com/santiagodr) as collaborators to your repo containing hw02. Please __review the hw02 submission of [KateJohnson](https://github.com/KateJohnson) and [navysealtf9k](https://github.com/navysealtf9k)__.                         
wenzhengzzz       Please add [xinyaofan](https://github.com/xinyaofan) and [margotgunning](https://github.com/margotgunning) as collaborators to your repo containing hw02. Please __review the hw02 submission of [hannahdxz](https://github.com/hannahdxz) and [oktokat](https://github.com/oktokat)__.                             
winnietse1018     Please add [teilhard1976](https://github.com/teilhard1976) and [abishekarun](https://github.com/abishekarun) as collaborators to your repo containing hw02. Please __review the hw02 submission of [emilymistick](https://github.com/emilymistick) and [yanchaoluo](https://github.com/yanchaoluo)__.               
wswade2           Please add [oktokat](https://github.com/oktokat) and [angmelanie](https://github.com/angmelanie) as collaborators to your repo containing hw02. Please __review the hw02 submission of [NSKrstic](https://github.com/NSKrstic) and [rdwyer2](https://github.com/rdwyer2)__.                                         
xinmiaow          Please add [marbazua](https://github.com/marbazua) and [jmurthy12](https://github.com/jmurthy12) as collaborators to your repo containing hw02. Please __review the hw02 submission of [ssheikho](https://github.com/ssheikho) and [xinyaofan](https://github.com/xinyaofan)__.                                     
xinyaofan         Please add [xinmiaow](https://github.com/xinmiaow) and [ssheikho](https://github.com/ssheikho) as collaborators to your repo containing hw02. Please __review the hw02 submission of [margotgunning](https://github.com/margotgunning) and [wenzhengzzz](https://github.com/wenzhengzzz)__.                         
yanchaoluo        Please add [winnietse1018](https://github.com/winnietse1018) and [emilymistick](https://github.com/emilymistick) as collaborators to your repo containing hw02. Please __review the hw02 submission of [dorawyy](https://github.com/dorawyy) and [k3vzhu](https://github.com/k3vzhu)__.                             
yeonukkim         Please add [SonjaS1](https://github.com/SonjaS1) and [Tangjiahui26](https://github.com/Tangjiahui26) as collaborators to your repo containing hw02. Please __review the hw02 submission of [burkeprw](https://github.com/burkeprw) and [Shirlett](https://github.com/Shirlett)__.                                   
yidie             Please add [hsummers](https://github.com/hsummers) and [rainerlempert](https://github.com/rainerlempert) as collaborators to your repo containing hw02. Please __review the hw02 submission of [danaj191](https://github.com/danaj191) and [suminwei2772](https://github.com/suminwei2772)__.                       
yuanjisun         Please add [nicolehawe](https://github.com/nicolehawe) and [mlawre01](https://github.com/mlawre01) as collaborators to your repo containing hw02. Please __review the hw02 submission of [acavalla](https://github.com/acavalla) and [susannaelsie](https://github.com/susannaelsie)__.                             
ZimingY           Please add [nbendriem](https://github.com/nbendriem) and [arsbar24](https://github.com/arsbar24) as collaborators to your repo containing hw02. Please __review the hw02 submission of [mattsada](https://github.com/mattsada) and [vanflad](https://github.com/vanflad)__.                                         
zxkathy           Please add [Mathnstein](https://github.com/Mathnstein) and [swynes](https://github.com/swynes) as collaborators to your repo containing hw02. Please __review the hw02 submission of [aiod01](https://github.com/aiod01) and [hsummers](https://github.com/hsummers)__.                                             

