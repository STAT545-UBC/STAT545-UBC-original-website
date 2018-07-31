# Homework 04: Tidy data and joins

### Overview

You have learned alot about data wrangling! You know how to use the tidyverse to:

  * Filter rows and select variables in a principled or name-based manner
  * Modify variables and create new variables
  * Group rows of a data frame and do summarizing or mutating computations within group
  * Reshape a data frame
  * Get new information into a data frame via a joining

The goal of this homework is to solidify your data wrangling skills by working some realistic problems in the grey area between data aggregation and data reshaping.

If you internalize that there are multiple solutions to most problems, you will spend less time banging your head against the wall in data analysis. If something's really hard, sneak up on it from a different angle.

Due anytime Tuesday October 10th 2017.

### Choose your own adventure

Pick one of the data reshaping prompts and do it.

Pick a join prompt and do it.

It is fine to work with a new dataset and/or create variations on these problem themes.

### General data reshaping and relationship to aggregation

__Problem__: You have data in one "shape" but you wish it were in another. Usually this is because the alternative shape is superior for presenting a table, making a figure, or doing aggregation and statistical analysis.

__Solution__: Reshape your data. For simple reshaping, `gather()` and `spread()` from `tidyr` will suffice. Do the thing that it possible / easier now that your data has a new shape.

__Prompts__:

Activity #1

  * Make you own cheatsheet similar to Tyler Rinker's [minimal guide to `tidyr`](https://github.com/trinker/tidyr_in_a_nutshell).

Activity #2

  * Make a tibble with one row per year and columns for life expectancy for two or more countries.
    - Use `knitr::kable()` to make this table look pretty in your rendered homework.
    - Take advantage of this new data shape to scatterplot life expectancy for one country against that of another.

Activity #3

  * Compute some measure of life expectancy (mean? median? min? max?) for all possible combinations of continent and year. Reshape that to have one row per year and one variable for each continent. Or the other way around: one row per continent and one variable per year.
    - Use `knitr::kable()` to make these tables look pretty in your rendered homework.
    - Is there a plot that is easier to make with the data in this shape versis the usual form? If so (or you think so), try it! Reflect.

Activity #4

  * In [Window functions](http://stat545.com/block010_dplyr-end-single-table.html#window-functions), we formed a tibble with 24 rows: 2 per year, giving the country with both the lowest and highest life expectancy (in Asia). Take that table (or a similar one for all continents) and reshape it so you have one row per year or per year * continent combination.

Activity #5

  * Previous TA Andrew MacDonald has a nice [data manipulation sampler](https://gist.github.com/aammd/11386424). Make up a similar set of exercises for yourself, in the abstract or (even better) using Gapminder or other data, and solve them.

### Join, merge, look up

__Problem__: You have two data sources and you need info from both in one new data object.

__Solution__: Perform a __join__, which borrows terminology from the database world, specifically SQL.

__Prompts__:

Activity #1

  * Create a second data frame, complementary to Gapminder. Join this with (part of) Gapminder using a `dplyr` join function and make some observations about the process and result. Explore the different types of joins. Examples of a second data frame you could build:
    - One row per country, a country variable and one or more variables with extra info, such as language spoken, NATO membership, national animal, or capitol city. If you really want to be helpful, you could attempt to make a pull request to resolve [this issue](https://github.com/jennybc/gapminder/issues/13), where I would like to bring ISO country codes into the gapminder package.
    - One row per continent, a continent variable and one or more variables with extra info, such as northern versus southern hemisphere.

Activity #2

  * Create your own cheatsheet patterned [after mine](bit001_dplyr-cheatsheet.html) but focused on something you care about more than comics! Inspirational examples:
    - Pets I have owned + breed + friendly vs. unfriendly + ??. Join to a table of pet breed, including variables for furry vs not furry, mammal true or false, etc.
    - Movies and studios....
    - Athletes and teams....

You will likely need to iterate between your data prep and your joining to make your explorations comprehensive and interesting. For example, you will want a specific amount (or lack) of overlap between the two data.frames, in order to demonstrate all the different joins. You will want both the data frames to be as small as possible, while still retaining the expository value.

Activity #3

  * This is really an optional add-on to either of the previous activities.
  * Explore the base function `merge()`, which also does joins. Compare and contrast with dplyr joins.
  * Explore the base function `match()`, which is related to joins and merges, but is really more of a "table lookup". Compare and contrast with a true join/merge.
  
## Peer Review


The peer review is ready and is due __October 13, 2017__! Here's what you'll need to do:

0. Find your github username in the table below. If it's not there, let Giulio know! Slack me `@giulio`.
1. Add the _people who will be giving you a review_ as collaborators to the repo containing your homework submission.
2. Give a review of this homework for the two people you've been assigned to. There should be an issue in their repo titled something like `hw0x ready for grading` -- put your review in there as a comment.
    - If there is no such issue, make one! (in _their_ repo)
    - Please don't mix up your reviewers and reviewees!

Check out the [guidelines for giving a peer review](http://stat545.com/peer-review02_peer-evaluation-guidelines.html).


Your_github       Instructions                                                                                                                                                                                                                                                                                                  
----------------  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
abishekarun       Please add [farihakhan](https://github.com/farihakhan) and [Tangjiahui26](https://github.com/Tangjiahui26) as collaborators to your repo containing hw04. Please __review the hw04 submission of [mylinhthibodeau](https://github.com/mylinhthibodeau) and [KateJohnson](https://github.com/KateJohnson)__.   
acavalla          Please add [peterwhitman](https://github.com/peterwhitman) and [navysealtf9k](https://github.com/navysealtf9k) as collaborators to your repo containing hw04. Please __review the hw04 submission of [sepkamal](https://github.com/sepkamal) and [Mathnstein](https://github.com/Mathnstein)__.               
aiod01            Please add [juansbr7](https://github.com/juansbr7) and [estennw](https://github.com/estennw) as collaborators to your repo containing hw04. Please __review the hw04 submission of [rishadhabib](https://github.com/rishadhabib) and [winnietse1018](https://github.com/winnietse1018)__.                     
Alexander-Morin   Please add [angmelanie](https://github.com/angmelanie) and [Maria815](https://github.com/Maria815) as collaborators to your repo containing hw04. Please __review the hw04 submission of [gbraich](https://github.com/gbraich) and [heathersummers](https://github.com/heathersummers)__.                     
alexrod61         Please add [santiagodr](https://github.com/santiagodr) and [julianheavyside](https://github.com/julianheavyside) as collaborators to your repo containing hw04. Please __review the hw04 submission of [qiaoyuet](https://github.com/qiaoyuet) and [bcahn7](https://github.com/bcahn7)__.                     
angmelanie        Please add [arsbar24](https://github.com/arsbar24) and [xinmiaow](https://github.com/xinmiaow) as collaborators to your repo containing hw04. Please __review the hw04 submission of [Maria815](https://github.com/Maria815) and [Alexander-Morin](https://github.com/Alexander-Morin)__.                     
arsbar24          Please add [suminwei2772](https://github.com/suminwei2772) and [lucymei](https://github.com/lucymei) as collaborators to your repo containing hw04. Please __review the hw04 submission of [xinmiaow](https://github.com/xinmiaow) and [angmelanie](https://github.com/angmelanie)__.                         
arthursunbao      Please add [swynes](https://github.com/swynes) and [nicolehawe](https://github.com/nicolehawe) as collaborators to your repo containing hw04. Please __review the hw04 submission of [rdwyer2](https://github.com/rdwyer2) and [diermc](https://github.com/diermc)__.                                         
auduman           Please add [sepkamal](https://github.com/sepkamal) and [Mathnstein](https://github.com/Mathnstein) as collaborators to your repo containing hw04. Please __review the hw04 submission of [cheungamanda](https://github.com/cheungamanda) and [oktokat](https://github.com/oktokat)__.                         
bcahn7            Please add [alexrod61](https://github.com/alexrod61) and [qiaoyuet](https://github.com/qiaoyuet) as collaborators to your repo containing hw04. Please __review the hw04 submission of [vibudh2209](https://github.com/vibudh2209) and [k3vzhu](https://github.com/k3vzhu)__.                                 
burkeprw          Please add [HScheiber](https://github.com/HScheiber) and [mlawre01](https://github.com/mlawre01) as collaborators to your repo containing hw04. Please __review the hw04 submission of [ilgan](https://github.com/ilgan) and [vanflad](https://github.com/vanflad)__.                                         
CassKon           Please add [ilgan](https://github.com/ilgan) and [vanflad](https://github.com/vanflad) as collaborators to your repo containing hw04. Please __review the hw04 submission of [ChadFibke](https://github.com/ChadFibke) and [cindyhurtado](https://github.com/cindyhurtado)__.                                 
ChadFibke         Please add [vanflad](https://github.com/vanflad) and [CassKon](https://github.com/CassKon) as collaborators to your repo containing hw04. Please __review the hw04 submission of [cindyhurtado](https://github.com/cindyhurtado) and [swynes](https://github.com/swynes)__.                                   
cheungamanda      Please add [Mathnstein](https://github.com/Mathnstein) and [auduman](https://github.com/auduman) as collaborators to your repo containing hw04. Please __review the hw04 submission of [oktokat](https://github.com/oktokat) and [emilymistick](https://github.com/emilymistick)__.                           
cindyhurtado      Please add [CassKon](https://github.com/CassKon) and [ChadFibke](https://github.com/ChadFibke) as collaborators to your repo containing hw04. Please __review the hw04 submission of [swynes](https://github.com/swynes) and [nicolehawe](https://github.com/nicolehawe)__.                                   
danaj191          Please add [nbendriem](https://github.com/nbendriem) and [dorawyy](https://github.com/dorawyy) as collaborators to your repo containing hw04. Please __review the hw04 submission of [NSKrstic](https://github.com/NSKrstic) and [sdhanani](https://github.com/gvdr/stat545-hw-dhanani-selina)__.             
diermc            Please add [arthursunbao](https://github.com/arthursunbao) and [rdwyer2](https://github.com/rdwyer2) as collaborators to your repo containing hw04. Please __review the hw04 submission of [ZimingY](https://github.com/ZimingY) and [Shirlett](https://github.com/Shirlett)__.                               
dorawyy           Please add [winnietse1018](https://github.com/winnietse1018) and [nbendriem](https://github.com/nbendriem) as collaborators to your repo containing hw04. Please __review the hw04 submission of [danaj191](https://github.com/danaj191) and [NSKrstic](https://github.com/NSKrstic)__.                       
emilymistick      Please add [cheungamanda](https://github.com/cheungamanda) and [oktokat](https://github.com/oktokat) as collaborators to your repo containing hw04. Please __review the hw04 submission of [yanchaoluo](https://github.com/yanchaoluo) and [santiagodr](https://github.com/santiagodr)__.                     
estennw           Please add [susannaelsie](https://github.com/susannaelsie) and [juansbr7](https://github.com/juansbr7) as collaborators to your repo containing hw04. Please __review the hw04 submission of [aiod01](https://github.com/aiod01) and [rishadhabib](https://github.com/rishadhabib)__.                         
farihakhan        Please add [vibudh2209](https://github.com/vibudh2209) and [k3vzhu](https://github.com/k3vzhu) as collaborators to your repo containing hw04. Please __review the hw04 submission of [Tangjiahui26](https://github.com/Tangjiahui26) and [abishekarun](https://github.com/abishekarun)__.                     
gbraich           Please add [Maria815](https://github.com/Maria815) and [Alexander-Morin](https://github.com/Alexander-Morin) as collaborators to your repo containing hw04. Please __review the hw04 submission of [heathersummers](https://github.com/heathersummers) and [wswade2](https://github.com/wswade2)__.           
hannahdxz         Please add [Shirlett](https://github.com/Shirlett) and [Kozp](https://github.com/Kozp) as collaborators to your repo containing hw04. Please __review the hw04 submission of [suminwei2772](https://github.com/suminwei2772) and [lucymei](https://github.com/lucymei)__.                                     
heathersummers    Please add [Alexander-Morin](https://github.com/Alexander-Morin) and [gbraich](https://github.com/gbraich) as collaborators to your repo containing hw04. Please __review the hw04 submission of [wswade2](https://github.com/wswade2) and [margotgunning](https://github.com/margotgunning)__.               
HScheiber         Please add [teilhard1976](https://github.com/teilhard1976) and [marbazua](https://github.com/marbazua) as collaborators to your repo containing hw04. Please __review the hw04 submission of [mlawre01](https://github.com/mlawre01) and [burkeprw](https://github.com/burkeprw)__.                           
hsmohammed        Please add [OliviaTabares](https://github.com/OliviaTabares) and [menglinzhou](https://github.com/menglinzhou) as collaborators to your repo containing hw04. Please __review the hw04 submission of [SonjaS1](https://github.com/SonjaS1) and [rainerlempert](https://github.com/rainerlempert)__.           
ilgan             Please add [mlawre01](https://github.com/mlawre01) and [burkeprw](https://github.com/burkeprw) as collaborators to your repo containing hw04. Please __review the hw04 submission of [vanflad](https://github.com/vanflad) and [CassKon](https://github.com/CassKon)__.                                       
jenncscampbell    Please add [rainerlempert](https://github.com/rainerlempert) and [vmichalowski](https://github.com/vmichalowski) as collaborators to your repo containing hw04. Please __review the hw04 submission of [peterwhitman](https://github.com/peterwhitman) and [navysealtf9k](https://github.com/navysealtf9k)__. 
Jennica416        Please add [wswade2](https://github.com/wswade2) and [margotgunning](https://github.com/margotgunning) as collaborators to your repo containing hw04. Please __review the hw04 submission of [OliviaTabares](https://github.com/OliviaTabares) and [menglinzhou](https://github.com/menglinzhou)__.           
jmurthy12         Please add [xinyaofan](https://github.com/xinyaofan) and [shadowforti](https://github.com/shadowforti) as collaborators to your repo containing hw04. Please __review the hw04 submission of [ssheikho](https://github.com/ssheikho) and [susannaelsie](https://github.com/susannaelsie)__.                   
juansbr7          Please add [ssheikho](https://github.com/ssheikho) and [susannaelsie](https://github.com/susannaelsie) as collaborators to your repo containing hw04. Please __review the hw04 submission of [estennw](https://github.com/estennw) and [aiod01](https://github.com/aiod01)__.                                 
julianheavyside   Please add [yanchaoluo](https://github.com/yanchaoluo) and [santiagodr](https://github.com/santiagodr) as collaborators to your repo containing hw04. Please __review the hw04 submission of [alexrod61](https://github.com/alexrod61) and [qiaoyuet](https://github.com/qiaoyuet)__.                         
k3vzhu            Please add [bcahn7](https://github.com/bcahn7) and [vibudh2209](https://github.com/vibudh2209) as collaborators to your repo containing hw04. Please __review the hw04 submission of [farihakhan](https://github.com/farihakhan) and [Tangjiahui26](https://github.com/Tangjiahui26)__.                       
KateJohnson       Please add [abishekarun](https://github.com/abishekarun) and [mylinhthibodeau](https://github.com/mylinhthibodeau) as collaborators to your repo containing hw04. Please __review the hw04 submission of [mattsada](https://github.com/mattsada) and [xinyaofan](https://github.com/xinyaofan)__.             
Kozp              Please add [ZimingY](https://github.com/ZimingY) and [Shirlett](https://github.com/Shirlett) as collaborators to your repo containing hw04. Please __review the hw04 submission of [hannahdxz](https://github.com/hannahdxz) and [suminwei2772](https://github.com/suminwei2772)__.                           
lucymei           Please add [hannahdxz](https://github.com/hannahdxz) and [suminwei2772](https://github.com/suminwei2772) as collaborators to your repo containing hw04. Please __review the hw04 submission of [arsbar24](https://github.com/arsbar24) and [xinmiaow](https://github.com/xinmiaow)__.                         
marbazua          Please add [wenzhengzzz](https://github.com/wenzhengzzz) and [teilhard1976](https://github.com/teilhard1976) as collaborators to your repo containing hw04. Please __review the hw04 submission of [HScheiber](https://github.com/HScheiber) and [mlawre01](https://github.com/mlawre01)__.                   
margotgunning     Please add [heathersummers](https://github.com/heathersummers) and [wswade2](https://github.com/wswade2) as collaborators to your repo containing hw04. Please __review the hw04 submission of [Jennica416](https://github.com/Jennica416) and [OliviaTabares](https://github.com/OliviaTabares)__.           
Maria815          Please add [xinmiaow](https://github.com/xinmiaow) and [angmelanie](https://github.com/angmelanie) as collaborators to your repo containing hw04. Please __review the hw04 submission of [Alexander-Morin](https://github.com/Alexander-Morin) and [gbraich](https://github.com/gbraich)__.                   
Mathnstein        Please add [acavalla](https://github.com/acavalla) and [sepkamal](https://github.com/sepkamal) as collaborators to your repo containing hw04. Please __review the hw04 submission of [auduman](https://github.com/auduman) and [cheungamanda](https://github.com/cheungamanda)__.                             
mattsada          Please add [mylinhthibodeau](https://github.com/mylinhthibodeau) and [KateJohnson](https://github.com/KateJohnson) as collaborators to your repo containing hw04. Please __review the hw04 submission of [xinyaofan](https://github.com/xinyaofan) and [shadowforti](https://github.com/shadowforti)__.       
menglinzhou       Please add [Jennica416](https://github.com/Jennica416) and [OliviaTabares](https://github.com/OliviaTabares) as collaborators to your repo containing hw04. Please __review the hw04 submission of [hsmohammed](https://github.com/hsmohammed) and [SonjaS1](https://github.com/SonjaS1)__.                   
mlawre01          Please add [marbazua](https://github.com/marbazua) and [HScheiber](https://github.com/HScheiber) as collaborators to your repo containing hw04. Please __review the hw04 submission of [burkeprw](https://github.com/burkeprw) and [ilgan](https://github.com/ilgan)__.                                       
mylinhthibodeau   Please add [Tangjiahui26](https://github.com/Tangjiahui26) and [abishekarun](https://github.com/abishekarun) as collaborators to your repo containing hw04. Please __review the hw04 submission of [KateJohnson](https://github.com/KateJohnson) and [mattsada](https://github.com/mattsada)__.               
navysealtf9k      Please add [jenncscampbell](https://github.com/jenncscampbell) and [peterwhitman](https://github.com/peterwhitman) as collaborators to your repo containing hw04. Please __review the hw04 submission of [acavalla](https://github.com/acavalla) and [sepkamal](https://github.com/sepkamal)__.               
nbendriem         Please add [rishadhabib](https://github.com/rishadhabib) and [winnietse1018](https://github.com/winnietse1018) as collaborators to your repo containing hw04. Please __review the hw04 submission of [dorawyy](https://github.com/dorawyy) and [danaj191](https://github.com/danaj191)__.                     
nicolehawe        Please add [cindyhurtado](https://github.com/cindyhurtado) and [swynes](https://github.com/swynes) as collaborators to your repo containing hw04. Please __review the hw04 submission of [arthursunbao](https://github.com/arthursunbao) and [rdwyer2](https://github.com/rdwyer2)__.                         
NSKrstic          Please add [dorawyy](https://github.com/dorawyy) and [danaj191](https://github.com/danaj191) as collaborators to your repo containing hw04. Please __review the hw04 submission of [sdhanani](https://github.com/gvdr/stat545-hw-dhanani-selina) and [zxkathy](https://github.com/zxkathy)__.                 
oktokat           Please add [auduman](https://github.com/auduman) and [cheungamanda](https://github.com/cheungamanda) as collaborators to your repo containing hw04. Please __review the hw04 submission of [emilymistick](https://github.com/emilymistick) and [yanchaoluo](https://github.com/yanchaoluo)__.                 
OliviaTabares     Please add [margotgunning](https://github.com/margotgunning) and [Jennica416](https://github.com/Jennica416) as collaborators to your repo containing hw04. Please __review the hw04 submission of [menglinzhou](https://github.com/menglinzhou) and [hsmohammed](https://github.com/hsmohammed)__.           
peterwhitman      Please add [vmichalowski](https://github.com/vmichalowski) and [jenncscampbell](https://github.com/jenncscampbell) as collaborators to your repo containing hw04. Please __review the hw04 submission of [navysealtf9k](https://github.com/navysealtf9k) and [acavalla](https://github.com/acavalla)__.       
qiaoyuet          Please add [julianheavyside](https://github.com/julianheavyside) and [alexrod61](https://github.com/alexrod61) as collaborators to your repo containing hw04. Please __review the hw04 submission of [bcahn7](https://github.com/bcahn7) and [vibudh2209](https://github.com/vibudh2209)__.                   
rainerlempert     Please add [hsmohammed](https://github.com/hsmohammed) and [SonjaS1](https://github.com/SonjaS1) as collaborators to your repo containing hw04. Please __review the hw04 submission of [vmichalowski](https://github.com/vmichalowski) and [jenncscampbell](https://github.com/jenncscampbell)__.             
rdwyer2           Please add [nicolehawe](https://github.com/nicolehawe) and [arthursunbao](https://github.com/arthursunbao) as collaborators to your repo containing hw04. Please __review the hw04 submission of [diermc](https://github.com/diermc) and [ZimingY](https://github.com/ZimingY)__.                             
rishadhabib       Please add [estennw](https://github.com/estennw) and [aiod01](https://github.com/aiod01) as collaborators to your repo containing hw04. Please __review the hw04 submission of [winnietse1018](https://github.com/winnietse1018) and [nbendriem](https://github.com/nbendriem)__.                             
santiagodr        Please add [emilymistick](https://github.com/emilymistick) and [yanchaoluo](https://github.com/yanchaoluo) as collaborators to your repo containing hw04. Please __review the hw04 submission of [julianheavyside](https://github.com/julianheavyside) and [alexrod61](https://github.com/alexrod61)__.       
sdhanani          Please add [danaj191](https://github.com/danaj191) and [NSKrstic](https://github.com/NSKrstic) as collaborators to your repo containing hw04. Please __review the hw04 submission of [zxkathy](https://github.com/zxkathy) and [yidie](https://github.com/yidie)__.                                           
sepkamal          Please add [navysealtf9k](https://github.com/navysealtf9k) and [acavalla](https://github.com/acavalla) as collaborators to your repo containing hw04. Please __review the hw04 submission of [Mathnstein](https://github.com/Mathnstein) and [auduman](https://github.com/auduman)__.                         
shadowforti       Please add [mattsada](https://github.com/mattsada) and [xinyaofan](https://github.com/xinyaofan) as collaborators to your repo containing hw04. Please __review the hw04 submission of [jmurthy12](https://github.com/jmurthy12) and [ssheikho](https://github.com/ssheikho)__.                               
Shirlett          Please add [diermc](https://github.com/diermc) and [ZimingY](https://github.com/ZimingY) as collaborators to your repo containing hw04. Please __review the hw04 submission of [Kozp](https://github.com/Kozp) and [hannahdxz](https://github.com/hannahdxz)__.                                               
SonjaS1           Please add [menglinzhou](https://github.com/menglinzhou) and [hsmohammed](https://github.com/hsmohammed) as collaborators to your repo containing hw04. Please __review the hw04 submission of [rainerlempert](https://github.com/rainerlempert) and [vmichalowski](https://github.com/vmichalowski)__.       
ssheikho          Please add [shadowforti](https://github.com/shadowforti) and [jmurthy12](https://github.com/jmurthy12) as collaborators to your repo containing hw04. Please __review the hw04 submission of [susannaelsie](https://github.com/susannaelsie) and [juansbr7](https://github.com/juansbr7)__.                   
suminwei2772      Please add [Kozp](https://github.com/Kozp) and [hannahdxz](https://github.com/hannahdxz) as collaborators to your repo containing hw04. Please __review the hw04 submission of [lucymei](https://github.com/lucymei) and [arsbar24](https://github.com/arsbar24)__.                                           
susannaelsie      Please add [jmurthy12](https://github.com/jmurthy12) and [ssheikho](https://github.com/ssheikho) as collaborators to your repo containing hw04. Please __review the hw04 submission of [juansbr7](https://github.com/juansbr7) and [estennw](https://github.com/estennw)__.                                   
swynes            Please add [ChadFibke](https://github.com/ChadFibke) and [cindyhurtado](https://github.com/cindyhurtado) as collaborators to your repo containing hw04. Please __review the hw04 submission of [nicolehawe](https://github.com/nicolehawe) and [arthursunbao](https://github.com/arthursunbao)__.             
Tangjiahui26      Please add [k3vzhu](https://github.com/k3vzhu) and [farihakhan](https://github.com/farihakhan) as collaborators to your repo containing hw04. Please __review the hw04 submission of [abishekarun](https://github.com/abishekarun) and [mylinhthibodeau](https://github.com/mylinhthibodeau)__.               
teilhard1976      Please add [yeonukkim](https://github.com/yeonukkim) and [wenzhengzzz](https://github.com/wenzhengzzz) as collaborators to your repo containing hw04. Please __review the hw04 submission of [marbazua](https://github.com/marbazua) and [HScheiber](https://github.com/HScheiber)__.                         
vanflad           Please add [burkeprw](https://github.com/burkeprw) and [ilgan](https://github.com/ilgan) as collaborators to your repo containing hw04. Please __review the hw04 submission of [CassKon](https://github.com/CassKon) and [ChadFibke](https://github.com/ChadFibke)__.                                         
vibudh2209        Please add [qiaoyuet](https://github.com/qiaoyuet) and [bcahn7](https://github.com/bcahn7) as collaborators to your repo containing hw04. Please __review the hw04 submission of [k3vzhu](https://github.com/k3vzhu) and [farihakhan](https://github.com/farihakhan)__.                                       
vmichalowski      Please add [SonjaS1](https://github.com/SonjaS1) and [rainerlempert](https://github.com/rainerlempert) as collaborators to your repo containing hw04. Please __review the hw04 submission of [jenncscampbell](https://github.com/jenncscampbell) and [peterwhitman](https://github.com/peterwhitman)__.       
wenzhengzzz       Please add [yuanjisun](https://github.com/yuanjisun) and [yeonukkim](https://github.com/yeonukkim) as collaborators to your repo containing hw04. Please __review the hw04 submission of [teilhard1976](https://github.com/teilhard1976) and [marbazua](https://github.com/marbazua)__.                       
winnietse1018     Please add [aiod01](https://github.com/aiod01) and [rishadhabib](https://github.com/rishadhabib) as collaborators to your repo containing hw04. Please __review the hw04 submission of [nbendriem](https://github.com/nbendriem) and [dorawyy](https://github.com/dorawyy)__.                                 
wswade2           Please add [gbraich](https://github.com/gbraich) and [heathersummers](https://github.com/heathersummers) as collaborators to your repo containing hw04. Please __review the hw04 submission of [margotgunning](https://github.com/margotgunning) and [Jennica416](https://github.com/Jennica416)__.           
xinmiaow          Please add [lucymei](https://github.com/lucymei) and [arsbar24](https://github.com/arsbar24) as collaborators to your repo containing hw04. Please __review the hw04 submission of [angmelanie](https://github.com/angmelanie) and [Maria815](https://github.com/Maria815)__.                                 
xinyaofan         Please add [KateJohnson](https://github.com/KateJohnson) and [mattsada](https://github.com/mattsada) as collaborators to your repo containing hw04. Please __review the hw04 submission of [shadowforti](https://github.com/shadowforti) and [jmurthy12](https://github.com/jmurthy12)__.                     
yanchaoluo        Please add [oktokat](https://github.com/oktokat) and [emilymistick](https://github.com/emilymistick) as collaborators to your repo containing hw04. Please __review the hw04 submission of [santiagodr](https://github.com/santiagodr) and [julianheavyside](https://github.com/julianheavyside)__.           
yeonukkim         Please add [yidie](https://github.com/yidie) and [yuanjisun](https://github.com/yuanjisun) as collaborators to your repo containing hw04. Please __review the hw04 submission of [wenzhengzzz](https://github.com/wenzhengzzz) and [teilhard1976](https://github.com/teilhard1976)__.                         
yidie             Please add [sdhanani](https://github.com/gvdr/stat545-hw-dhanani-selina) and [zxkathy](https://github.com/zxkathy) as collaborators to your repo containing hw04. Please __review the hw04 submission of [yuanjisun](https://github.com/yuanjisun) and [yeonukkim](https://github.com/yeonukkim)__.           
yuanjisun         Please add [zxkathy](https://github.com/zxkathy) and [yidie](https://github.com/yidie) as collaborators to your repo containing hw04. Please __review the hw04 submission of [yeonukkim](https://github.com/yeonukkim) and [wenzhengzzz](https://github.com/wenzhengzzz)__.                                   
ZimingY           Please add [rdwyer2](https://github.com/rdwyer2) and [diermc](https://github.com/diermc) as collaborators to your repo containing hw04. Please __review the hw04 submission of [Shirlett](https://github.com/Shirlett) and [Kozp](https://github.com/Kozp)__.                                                 
zxkathy           Please add [NSKrstic](https://github.com/NSKrstic) and [sdhanani](https://github.com/gvdr/stat545-hw-dhanani-selina) as collaborators to your repo containing hw04. Please __review the hw04 submission of [yidie](https://github.com/yidie) and [yuanjisun](https://github.com/yuanjisun)__.                 
