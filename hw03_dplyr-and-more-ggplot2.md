# Homework 03: Use dplyr to manipulate and explore data (also use ggplot2)

### Overview

Consult the [general homework guidelines](hw00_homework-guidelines.html). You'll be submitting this homework to the repo you submitted Homework 02 too.

Due Tuesday 2017-10-03 at midnight.

The goal is to manipulate and explore a dataset with the `dplyr` package, complemented by visualizations made with `ggplot2`.

Your homework should serve as your own personal cheatsheet in the future for ways to manipulate a dataset and produce companion figures. Give yourself the cheatsheet you deserve! Check out the [sampler concept](http://en.wikipedia.org/wiki/Sampler_(needlework)) for inspiration.

#### Gapminder data

Work with the [Gapminder excerpt](http://tiny.cc/gapminder). *If you really want to, you can explore a different dataset but get permission from Jenny. Self-assess the suitability of your dataset by reading [this issue](https://github.com/STAT545-UBC/Discussion/issues/115).*

### Your mission, high-level

Pick at least three of the tasks below and attack each with a table and figure.

  * dplyr should be your data manipulation tool
  * ggplot2 should be your visualization tool

Make observations about what your tables/figures show and about the process.

If you want to do something comparable but different, i.e. swap one quantitative variable for another, be my guest! If you are feeling inspired and curious, then we're doing this right. Go for it.

Relax about the following things:

  * Tidying/reshaping is NOT your assignment. Many of your tables will be awkwardly shaped in the report. That's OK.
  * Table beauty is not a big deal. Simply printing to "screen" is fine. You could also try the `knitr::kable()` function. Assuming `my_df` is a data.frame, here's an R chunk that should print it as a decent-looking table:

<pre><code>```{r results = 'asis'}
knitr::kable(my_df)
```</code></pre>

  * For all things, graphical and tabular, if you're dissatisfied with a result, discuss the problem, what you've tried and move on.

### Task menu

Get the maximum and minimum of GDP per capita for all continents.

Look at the spread of GDP per capita within the continents.

Compute a trimmed mean of life expectancy for different years. Or a weighted mean, weighting by population. Just try something other than the plain vanilla mean.

How is life expectancy changing over time on different continents?

Report the absolute and/or relative abundance of countries with low life expectancy over time by continent: Compute some measure of worldwide life expectancy – you decide – a mean or median or some other quantile or perhaps your current age. Then determine how many countries on each continent have a life expectancy less than this benchmark, for each year.

Find countries with interesting stories. Open-ended and, therefore, hard. Promising but unsuccessful attempts are encouraged. This will generate interesting questions to follow up on in class.

Make up your own! Between the dplyr coverage in class and the list above, I think you get the idea.

### Companion graphs

For each table, make sure to include a relevant figure.

Your figure does not have to depict every last number from the data aggregation result. Use your judgement. It just needs to complement the table, add context, and allow for some sanity checking both ways.

Notice which figures are easy/hard to make, which data formats make better inputs for plotting functions vs. for human-friendly tables.

### But I want to do more!

Layout stretch goal: get table and figure side-by-side. [This gist](https://gist.github.com/jennybc/e9e9aba6ba18c72cec26) might get you started.

Table stretch goal: there are some really nice fancy table helper packages. [This tweet from \@polesasunder](https://twitter.com/polesasunder/status/464132152347475968) will point you toward some R packages you may want to check out (pander, xtable, stargazer).

### Report your process

You're encouraged to reflect on what was hard/easy, problems you solved, helpful tutorials you read, etc. Give credit to your sources, whether it's a blog post, a fellow student, an online tutorial, etc.

### Submit the assignment

Remember the github repo you submitted all your Homework 02 work to? The one called `stat545-hw-lastname-firstname`? That's where you'll be submitting Homework 03, too.

As before, make a new issue and call it `"Homework 03 is ready for grading"`.

This time, you __do not need to__ tag any of the teaching team, nor add us as collaborators! By this point, we already have access to your repo and know where it is.

### Rubric

__Start using our [general rubric](peer-review01_marking-rubric.html) for specifics to evaluate! The form will require you to do so!__

Check minus: Didn't tackle at least 3 tasks. Or didn't make companion graphs. Didn't interpret anything but left it all to the "reader". Or more than one technical problem that is relatively easy to fix. It's hard to find the report in this crazy repo.

Check: Hits all the elements. No obvious mistakes. Pleasant to read. No heroic detective work required. Solid.

Check plus: Exceeded the requirements in number of tasks. Or developed novel tasks that were indeed interesting and "worked". Impressive use of dplyr and/or ggplot2. Impeccable organization of repo and report. You learned something new from reviewing their work and you're eager to incorporate it into your work.

## Peer Review


The peer review is ready and is due __October 9, 2017__! Here's what you'll need to do:

0. Find your github username in the table below. If it's not there, let Giulio know! Slack me `@giulio`.
1. Add the _people who will be giving you a review_ as collaborators to the repo containing your homework submission.
2. Give a review of this homework for the two people you've been assigned to. There should be an issue in their repo titled something like `hw0x ready for grading` -- put your review in there as a comment.
    - If there is no such issue, make one! (in _their_ repo)
    - Please don't mix up your reviewers and reviewees!

Check out the [guidelines for giving a peer review](http://stat545.com/peer-review02_peer-evaluation-guidelines.html).


Your_github       Instructions                                                                                                                                                                                                                                                                                                        
----------------  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
abishekarun       Please add [dorawyy](https://github.com/dorawyy) and [ZimingY](https://github.com/ZimingY) as collaborators to your repo containing hw03. Please __review the hw03 submission of [cindyhurtado](https://github.com/cindyhurtado) and [qiaoyuet](https://github.com/qiaoyuet)__.                                     
acavalla          Please add [SonjaS1](https://github.com/SonjaS1) and [arsbar24](https://github.com/arsbar24) as collaborators to your repo containing hw03. Please __review the hw03 submission of [rdwyer2](https://github.com/rdwyer2) and [rishadhabib](https://github.com/rishadhabib)__.                                       
aiod01            Please add [hsummers](https://github.com/hsummers) and [vibudh2209](https://github.com/vibudh2209) as collaborators to your repo containing hw03. Please __review the hw03 submission of [arthursunbao](https://github.com/arthursunbao) and [mylinhthibodeau](https://github.com/mylinhthibodeau)__.               
Alexander-Morin   Please add [sdhanani](https://github.com/gvdr/stat545-hw-dhanani-selina) and [zxkathy](https://github.com/zxkathy) as collaborators to your repo containing hw03. Please __review the hw03 submission of [nicolehawe](https://github.com/nicolehawe) and [angmelanie](https://github.com/angmelanie)__.             
alexrod61         Please add [yanchaoluo](https://github.com/yanchaoluo) and [NSKrstic](https://github.com/NSKrstic) as collaborators to your repo containing hw03. Please __review the hw03 submission of [Mathnstein](https://github.com/Mathnstein) and [xinmiaow](https://github.com/xinmiaow)__.                                 
angmelanie        Please add [Alexander-Morin](https://github.com/Alexander-Morin) and [nicolehawe](https://github.com/nicolehawe) as collaborators to your repo containing hw03. Please __review the hw03 submission of [gbraich](https://github.com/gbraich) and [nbendriem](https://github.com/nbendriem)__.                       
arsbar24          Please add [navysealtf9k](https://github.com/navysealtf9k) and [SonjaS1](https://github.com/SonjaS1) as collaborators to your repo containing hw03. Please __review the hw03 submission of [acavalla](https://github.com/acavalla) and [rdwyer2](https://github.com/rdwyer2)__.                                     
arthursunbao      Please add [vibudh2209](https://github.com/vibudh2209) and [aiod01](https://github.com/aiod01) as collaborators to your repo containing hw03. Please __review the hw03 submission of [mylinhthibodeau](https://github.com/mylinhthibodeau) and [Tangjiahui26](https://github.com/Tangjiahui26)__.                   
auduman           Please add [Mathnstein](https://github.com/Mathnstein) and [xinmiaow](https://github.com/xinmiaow) as collaborators to your repo containing hw03. Please __review the hw03 submission of [farihakhan](https://github.com/farihakhan) and [susannaelsie](https://github.com/susannaelsie)__.                         
bcahn7            Please add [mlawre01](https://github.com/mlawre01) and [marbazua](https://github.com/marbazua) as collaborators to your repo containing hw03. Please __review the hw03 submission of [wswade2](https://github.com/wswade2) and [yanchaoluo](https://github.com/yanchaoluo)__.                                       
burkeprw          Please add [santiagodr](https://github.com/santiagodr) and [ilgan](https://github.com/ilgan) as collaborators to your repo containing hw03. Please __review the hw03 submission of [cheungamanda](https://github.com/cheungamanda) and [swynes](https://github.com/swynes)__.                                       
CassKon           Please add [lucymei](https://github.com/lucymei) and [jmurthy12](https://github.com/jmurthy12) as collaborators to your repo containing hw03. Please __review the hw03 submission of [margotgunning](https://github.com/margotgunning) and [emilymistick](https://github.com/emilymistick)__.                       
ChadFibke         Please add [shadowforti](https://github.com/shadowforti) and [juansbr7](https://github.com/juansbr7) as collaborators to your repo containing hw03. Please __review the hw03 submission of [vmichalowski](https://github.com/vmichalowski) and [yeonukkim](https://github.com/yeonukkim)__.                         
cheungamanda      Please add [ilgan](https://github.com/ilgan) and [burkeprw](https://github.com/burkeprw) as collaborators to your repo containing hw03. Please __review the hw03 submission of [swynes](https://github.com/swynes) and [ssheikho](https://github.com/ssheikho)__.                                                   
cindyhurtado      Please add [ZimingY](https://github.com/ZimingY) and [abishekarun](https://github.com/abishekarun) as collaborators to your repo containing hw03. Please __review the hw03 submission of [qiaoyuet](https://github.com/qiaoyuet) and [Maria815](https://github.com/Maria815)__.                                     
danaj191          Please add [julianheavyside](https://github.com/julianheavyside) and [OliviaTabares](https://github.com/OliviaTabares) as collaborators to your repo containing hw03. Please __review the hw03 submission of [mlawre01](https://github.com/mlawre01) and [marbazua](https://github.com/marbazua)__.                 
diermc            Please add [ssheikho](https://github.com/ssheikho) and [peterwhitman](https://github.com/peterwhitman) as collaborators to your repo containing hw03. Please __review the hw03 submission of [jenncscampbell](https://github.com/jenncscampbell) and [dorawyy](https://github.com/dorawyy)__.                       
dorawyy           Please add [diermc](https://github.com/diermc) and [jenncscampbell](https://github.com/jenncscampbell) as collaborators to your repo containing hw03. Please __review the hw03 submission of [ZimingY](https://github.com/ZimingY) and [abishekarun](https://github.com/abishekarun)__.                             
emilymistick      Please add [CassKon](https://github.com/CassKon) and [margotgunning](https://github.com/margotgunning) as collaborators to your repo containing hw03. Please __review the hw03 submission of [teilhard1976](https://github.com/teilhard1976) and [vanflad](https://github.com/vanflad)__.                           
estennw           Please add [winnietse1018](https://github.com/winnietse1018) and [hannahdxz](https://github.com/hannahdxz) as collaborators to your repo containing hw03. Please __review the hw03 submission of [suminwei2772](https://github.com/suminwei2772) and [wenzhengzzz](https://github.com/wenzhengzzz)__.               
farihakhan        Please add [xinmiaow](https://github.com/xinmiaow) and [auduman](https://github.com/auduman) as collaborators to your repo containing hw03. Please __review the hw03 submission of [susannaelsie](https://github.com/susannaelsie) and [hsummers](https://github.com/hsummers)__.                                   
gbraich           Please add [nicolehawe](https://github.com/nicolehawe) and [angmelanie](https://github.com/angmelanie) as collaborators to your repo containing hw03. Please __review the hw03 submission of [nbendriem](https://github.com/nbendriem) and [oktokat](https://github.com/oktokat)__.                                 
hannahdxz         Please add [vanflad](https://github.com/vanflad) and [winnietse1018](https://github.com/winnietse1018) as collaborators to your repo containing hw03. Please __review the hw03 submission of [estennw](https://github.com/estennw) and [suminwei2772](https://github.com/suminwei2772)__.                           
HScheiber         Please add [hsmohammed](https://github.com/hsmohammed) and [mattsada](https://github.com/mattsada) as collaborators to your repo containing hw03. Please __review the hw03 submission of [navysealtf9k](https://github.com/navysealtf9k) and [SonjaS1](https://github.com/SonjaS1)__.                               
hsmohammed        Please add [Kozp](https://github.com/Kozp) and [k3vzhu](https://github.com/k3vzhu) as collaborators to your repo containing hw03. Please __review the hw03 submission of [mattsada](https://github.com/mattsada) and [HScheiber](https://github.com/HScheiber)__.                                                   
hsummers          Please add [farihakhan](https://github.com/farihakhan) and [susannaelsie](https://github.com/susannaelsie) as collaborators to your repo containing hw03. Please __review the hw03 submission of [vibudh2209](https://github.com/vibudh2209) and [aiod01](https://github.com/aiod01)__.                             
ilgan             Please add [rishadhabib](https://github.com/rishadhabib) and [santiagodr](https://github.com/santiagodr) as collaborators to your repo containing hw03. Please __review the hw03 submission of [burkeprw](https://github.com/burkeprw) and [cheungamanda](https://github.com/cheungamanda)__.                       
jenncscampbell    Please add [peterwhitman](https://github.com/peterwhitman) and [diermc](https://github.com/diermc) as collaborators to your repo containing hw03. Please __review the hw03 submission of [dorawyy](https://github.com/dorawyy) and [ZimingY](https://github.com/ZimingY)__.                                         
Jennica416        Please add [xinyaofan](https://github.com/xinyaofan) and [KateJohnson](https://github.com/KateJohnson) as collaborators to your repo containing hw03. Please __review the hw03 submission of [sepkamal](https://github.com/sepkamal) and [yidie](https://github.com/yidie)__.                                       
jmurthy12         Please add [yuanjisun](https://github.com/yuanjisun) and [lucymei](https://github.com/lucymei) as collaborators to your repo containing hw03. Please __review the hw03 submission of [CassKon](https://github.com/CassKon) and [margotgunning](https://github.com/margotgunning)__.                                 
juansbr7          Please add [yidie](https://github.com/yidie) and [shadowforti](https://github.com/shadowforti) as collaborators to your repo containing hw03. Please __review the hw03 submission of [ChadFibke](https://github.com/ChadFibke) and [vmichalowski](https://github.com/vmichalowski)__.                               
julianheavyside   Please add [nbendriem](https://github.com/nbendriem) and [oktokat](https://github.com/oktokat) as collaborators to your repo containing hw03. Please __review the hw03 submission of [OliviaTabares](https://github.com/OliviaTabares) and [danaj191](https://github.com/danaj191)__.                               
k3vzhu            Please add [rainerlempert](https://github.com/rainerlempert) and [Kozp](https://github.com/Kozp) as collaborators to your repo containing hw03. Please __review the hw03 submission of [hsmohammed](https://github.com/hsmohammed) and [mattsada](https://github.com/mattsada)__.                                   
KateJohnson       Please add [wenzhengzzz](https://github.com/wenzhengzzz) and [xinyaofan](https://github.com/xinyaofan) as collaborators to your repo containing hw03. Please __review the hw03 submission of [Jennica416](https://github.com/Jennica416) and [sepkamal](https://github.com/sepkamal)__.                             
Kozp              Please add [menglinzhou](https://github.com/menglinzhou) and [rainerlempert](https://github.com/rainerlempert) as collaborators to your repo containing hw03. Please __review the hw03 submission of [k3vzhu](https://github.com/k3vzhu) and [hsmohammed](https://github.com/hsmohammed)__.                         
lucymei           Please add [Maria815](https://github.com/Maria815) and [yuanjisun](https://github.com/yuanjisun) as collaborators to your repo containing hw03. Please __review the hw03 submission of [jmurthy12](https://github.com/jmurthy12) and [CassKon](https://github.com/CassKon)__.                                       
marbazua          Please add [danaj191](https://github.com/danaj191) and [mlawre01](https://github.com/mlawre01) as collaborators to your repo containing hw03. Please __review the hw03 submission of [bcahn7](https://github.com/bcahn7) and [wswade2](https://github.com/wswade2)__.                                               
margotgunning     Please add [jmurthy12](https://github.com/jmurthy12) and [CassKon](https://github.com/CassKon) as collaborators to your repo containing hw03. Please __review the hw03 submission of [emilymistick](https://github.com/emilymistick) and [teilhard1976](https://github.com/teilhard1976)__.                         
Maria815          Please add [cindyhurtado](https://github.com/cindyhurtado) and [qiaoyuet](https://github.com/qiaoyuet) as collaborators to your repo containing hw03. Please __review the hw03 submission of [yuanjisun](https://github.com/yuanjisun) and [lucymei](https://github.com/lucymei)__.                                 
Mathnstein        Please add [NSKrstic](https://github.com/NSKrstic) and [alexrod61](https://github.com/alexrod61) as collaborators to your repo containing hw03. Please __review the hw03 submission of [xinmiaow](https://github.com/xinmiaow) and [auduman](https://github.com/auduman)__.                                         
mattsada          Please add [k3vzhu](https://github.com/k3vzhu) and [hsmohammed](https://github.com/hsmohammed) as collaborators to your repo containing hw03. Please __review the hw03 submission of [HScheiber](https://github.com/HScheiber) and [navysealtf9k](https://github.com/navysealtf9k)__.                               
menglinzhou       Please add [mylinhthibodeau](https://github.com/mylinhthibodeau) and [Tangjiahui26](https://github.com/Tangjiahui26) as collaborators to your repo containing hw03. Please __review the hw03 submission of [rainerlempert](https://github.com/rainerlempert) and [Kozp](https://github.com/Kozp)__.                 
mlawre01          Please add [OliviaTabares](https://github.com/OliviaTabares) and [danaj191](https://github.com/danaj191) as collaborators to your repo containing hw03. Please __review the hw03 submission of [marbazua](https://github.com/marbazua) and [bcahn7](https://github.com/bcahn7)__.                                   
mylinhthibodeau   Please add [aiod01](https://github.com/aiod01) and [arthursunbao](https://github.com/arthursunbao) as collaborators to your repo containing hw03. Please __review the hw03 submission of [Tangjiahui26](https://github.com/Tangjiahui26) and [menglinzhou](https://github.com/menglinzhou)__.                       
navysealtf9k      Please add [mattsada](https://github.com/mattsada) and [HScheiber](https://github.com/HScheiber) as collaborators to your repo containing hw03. Please __review the hw03 submission of [SonjaS1](https://github.com/SonjaS1) and [arsbar24](https://github.com/arsbar24)__.                                         
nbendriem         Please add [angmelanie](https://github.com/angmelanie) and [gbraich](https://github.com/gbraich) as collaborators to your repo containing hw03. Please __review the hw03 submission of [oktokat](https://github.com/oktokat) and [julianheavyside](https://github.com/julianheavyside)__.                           
nicolehawe        Please add [zxkathy](https://github.com/zxkathy) and [Alexander-Morin](https://github.com/Alexander-Morin) as collaborators to your repo containing hw03. Please __review the hw03 submission of [angmelanie](https://github.com/angmelanie) and [gbraich](https://github.com/gbraich)__.                           
NSKrstic          Please add [wswade2](https://github.com/wswade2) and [yanchaoluo](https://github.com/yanchaoluo) as collaborators to your repo containing hw03. Please __review the hw03 submission of [alexrod61](https://github.com/alexrod61) and [Mathnstein](https://github.com/Mathnstein)__.                                 
oktokat           Please add [gbraich](https://github.com/gbraich) and [nbendriem](https://github.com/nbendriem) as collaborators to your repo containing hw03. Please __review the hw03 submission of [julianheavyside](https://github.com/julianheavyside) and [OliviaTabares](https://github.com/OliviaTabares)__.                 
OliviaTabares     Please add [oktokat](https://github.com/oktokat) and [julianheavyside](https://github.com/julianheavyside) as collaborators to your repo containing hw03. Please __review the hw03 submission of [danaj191](https://github.com/danaj191) and [mlawre01](https://github.com/mlawre01)__.                             
peterwhitman      Please add [swynes](https://github.com/swynes) and [ssheikho](https://github.com/ssheikho) as collaborators to your repo containing hw03. Please __review the hw03 submission of [diermc](https://github.com/diermc) and [jenncscampbell](https://github.com/jenncscampbell)__.                                     
qiaoyuet          Please add [abishekarun](https://github.com/abishekarun) and [cindyhurtado](https://github.com/cindyhurtado) as collaborators to your repo containing hw03. Please __review the hw03 submission of [Maria815](https://github.com/Maria815) and [yuanjisun](https://github.com/yuanjisun)__.                         
rainerlempert     Please add [Tangjiahui26](https://github.com/Tangjiahui26) and [menglinzhou](https://github.com/menglinzhou) as collaborators to your repo containing hw03. Please __review the hw03 submission of [Kozp](https://github.com/Kozp) and [k3vzhu](https://github.com/k3vzhu)__.                                       
rdwyer2           Please add [arsbar24](https://github.com/arsbar24) and [acavalla](https://github.com/acavalla) as collaborators to your repo containing hw03. Please __review the hw03 submission of [rishadhabib](https://github.com/rishadhabib) and [santiagodr](https://github.com/santiagodr)__.                               
rishadhabib       Please add [acavalla](https://github.com/acavalla) and [rdwyer2](https://github.com/rdwyer2) as collaborators to your repo containing hw03. Please __review the hw03 submission of [santiagodr](https://github.com/santiagodr) and [ilgan](https://github.com/ilgan)__.                                             
santiagodr        Please add [rdwyer2](https://github.com/rdwyer2) and [rishadhabib](https://github.com/rishadhabib) as collaborators to your repo containing hw03. Please __review the hw03 submission of [ilgan](https://github.com/ilgan) and [burkeprw](https://github.com/burkeprw)__.                                           
sdhanani          Please add [yeonukkim](https://github.com/yeonukkim) and [Shirlett](https://github.com/Shirlett) as collaborators to your repo containing hw03. Please __review the hw03 submission of [zxkathy](https://github.com/zxkathy) and [Alexander-Morin](https://github.com/Alexander-Morin)__.                           
sepkamal          Please add [KateJohnson](https://github.com/KateJohnson) and [Jennica416](https://github.com/Jennica416) as collaborators to your repo containing hw03. Please __review the hw03 submission of [yidie](https://github.com/yidie) and [shadowforti](https://github.com/shadowforti)__.                               
shadowforti       Please add [sepkamal](https://github.com/sepkamal) and [yidie](https://github.com/yidie) as collaborators to your repo containing hw03. Please __review the hw03 submission of [juansbr7](https://github.com/juansbr7) and [ChadFibke](https://github.com/ChadFibke)__.                                             
Shirlett          Please add [vmichalowski](https://github.com/vmichalowski) and [yeonukkim](https://github.com/yeonukkim) as collaborators to your repo containing hw03. Please __review the hw03 submission of [sdhanani](https://github.com/gvdr/stat545-hw-dhanani-selina) and [zxkathy](https://github.com/zxkathy)__.           
SonjaS1           Please add [HScheiber](https://github.com/HScheiber) and [navysealtf9k](https://github.com/navysealtf9k) as collaborators to your repo containing hw03. Please __review the hw03 submission of [arsbar24](https://github.com/arsbar24) and [acavalla](https://github.com/acavalla)__.                               
ssheikho          Please add [cheungamanda](https://github.com/cheungamanda) and [swynes](https://github.com/swynes) as collaborators to your repo containing hw03. Please __review the hw03 submission of [peterwhitman](https://github.com/peterwhitman) and [diermc](https://github.com/diermc)__.                                 
suminwei2772      Please add [hannahdxz](https://github.com/hannahdxz) and [estennw](https://github.com/estennw) as collaborators to your repo containing hw03. Please __review the hw03 submission of [wenzhengzzz](https://github.com/wenzhengzzz) and [xinyaofan](https://github.com/xinyaofan)__.                                 
susannaelsie      Please add [auduman](https://github.com/auduman) and [farihakhan](https://github.com/farihakhan) as collaborators to your repo containing hw03. Please __review the hw03 submission of [hsummers](https://github.com/hsummers) and [vibudh2209](https://github.com/vibudh2209)__.                                   
swynes            Please add [burkeprw](https://github.com/burkeprw) and [cheungamanda](https://github.com/cheungamanda) as collaborators to your repo containing hw03. Please __review the hw03 submission of [ssheikho](https://github.com/ssheikho) and [peterwhitman](https://github.com/peterwhitman)__.                         
Tangjiahui26      Please add [arthursunbao](https://github.com/arthursunbao) and [mylinhthibodeau](https://github.com/mylinhthibodeau) as collaborators to your repo containing hw03. Please __review the hw03 submission of [menglinzhou](https://github.com/menglinzhou) and [rainerlempert](https://github.com/rainerlempert)__.   
teilhard1976      Please add [margotgunning](https://github.com/margotgunning) and [emilymistick](https://github.com/emilymistick) as collaborators to your repo containing hw03. Please __review the hw03 submission of [vanflad](https://github.com/vanflad) and [winnietse1018](https://github.com/winnietse1018)__.               
vanflad           Please add [emilymistick](https://github.com/emilymistick) and [teilhard1976](https://github.com/teilhard1976) as collaborators to your repo containing hw03. Please __review the hw03 submission of [winnietse1018](https://github.com/winnietse1018) and [hannahdxz](https://github.com/hannahdxz)__.             
vibudh2209        Please add [susannaelsie](https://github.com/susannaelsie) and [hsummers](https://github.com/hsummers) as collaborators to your repo containing hw03. Please __review the hw03 submission of [aiod01](https://github.com/aiod01) and [arthursunbao](https://github.com/arthursunbao)__.                             
vmichalowski      Please add [juansbr7](https://github.com/juansbr7) and [ChadFibke](https://github.com/ChadFibke) as collaborators to your repo containing hw03. Please __review the hw03 submission of [yeonukkim](https://github.com/yeonukkim) and [Shirlett](https://github.com/Shirlett)__.                                     
wenzhengzzz       Please add [estennw](https://github.com/estennw) and [suminwei2772](https://github.com/suminwei2772) as collaborators to your repo containing hw03. Please __review the hw03 submission of [xinyaofan](https://github.com/xinyaofan) and [KateJohnson](https://github.com/KateJohnson)__.                           
winnietse1018     Please add [teilhard1976](https://github.com/teilhard1976) and [vanflad](https://github.com/vanflad) as collaborators to your repo containing hw03. Please __review the hw03 submission of [hannahdxz](https://github.com/hannahdxz) and [estennw](https://github.com/estennw)__.                                   
wswade2           Please add [marbazua](https://github.com/marbazua) and [bcahn7](https://github.com/bcahn7) as collaborators to your repo containing hw03. Please __review the hw03 submission of [yanchaoluo](https://github.com/yanchaoluo) and [NSKrstic](https://github.com/NSKrstic)__.                                         
xinmiaow          Please add [alexrod61](https://github.com/alexrod61) and [Mathnstein](https://github.com/Mathnstein) as collaborators to your repo containing hw03. Please __review the hw03 submission of [auduman](https://github.com/auduman) and [farihakhan](https://github.com/farihakhan)__.                                 
xinyaofan         Please add [suminwei2772](https://github.com/suminwei2772) and [wenzhengzzz](https://github.com/wenzhengzzz) as collaborators to your repo containing hw03. Please __review the hw03 submission of [KateJohnson](https://github.com/KateJohnson) and [Jennica416](https://github.com/Jennica416)__.                 
yanchaoluo        Please add [bcahn7](https://github.com/bcahn7) and [wswade2](https://github.com/wswade2) as collaborators to your repo containing hw03. Please __review the hw03 submission of [NSKrstic](https://github.com/NSKrstic) and [alexrod61](https://github.com/alexrod61)__.                                             
yeonukkim         Please add [ChadFibke](https://github.com/ChadFibke) and [vmichalowski](https://github.com/vmichalowski) as collaborators to your repo containing hw03. Please __review the hw03 submission of [Shirlett](https://github.com/Shirlett) and [sdhanani](https://github.com/gvdr/stat545-hw-dhanani-selina)__.         
yidie             Please add [Jennica416](https://github.com/Jennica416) and [sepkamal](https://github.com/sepkamal) as collaborators to your repo containing hw03. Please __review the hw03 submission of [shadowforti](https://github.com/shadowforti) and [juansbr7](https://github.com/juansbr7)__.                               
yuanjisun         Please add [qiaoyuet](https://github.com/qiaoyuet) and [Maria815](https://github.com/Maria815) as collaborators to your repo containing hw03. Please __review the hw03 submission of [lucymei](https://github.com/lucymei) and [jmurthy12](https://github.com/jmurthy12)__.                                         
ZimingY           Please add [jenncscampbell](https://github.com/jenncscampbell) and [dorawyy](https://github.com/dorawyy) as collaborators to your repo containing hw03. Please __review the hw03 submission of [abishekarun](https://github.com/abishekarun) and [cindyhurtado](https://github.com/cindyhurtado)__.                 
zxkathy           Please add [Shirlett](https://github.com/Shirlett) and [sdhanani](https://github.com/gvdr/stat545-hw-dhanani-selina) as collaborators to your repo containing hw03. Please __review the hw03 submission of [Alexander-Morin](https://github.com/Alexander-Morin) and [nicolehawe](https://github.com/nicolehawe)__. 
