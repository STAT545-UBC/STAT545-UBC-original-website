# Homework 06: Data wrangling wrap up

### Overview

Consult the [general homework guidelines](hw00_homework-guidelines.html).

Due anytime Wednesday 2017-11-08.

Pick (at least) two of the six (numbered) topics below and do one of the exercise prompts listed, or something comparable using your dataset of choice.

### 1. Character data

Read and work the exercises in the [Strings
chapter](http://r4ds.had.co.nz/strings.html) or R for Data Science.

### 2. Writing functions

Pick one:

  * Write one (or more) functions that do something useful to pieces of the
Gapminder or Singer data. It is logical to think about computing on the mini-data frames
corresponding to the data for each specific country, location, year, band, album, ... This would pair well with
the prompt below about working with a nested data frame, as you could apply your
function there.
    - Make it something you can't easily do with built-in functions.
Make it something that's not trivial to do with the simple `dplyr` verbs. The
linear regression function [presented
here](block012_function-regress-lifeexp-on-year.html) is a good starting point.
You could generalize that to do quadratic regression (include a squared term) or
use robust regression, using `MASS::rlm()` or `robustbase::lmrob()`.
  * If you plan to complete the homework where we build an R package, write a couple of experimental functions exploring some functionality that is useful to you in real life and that might form the basis of your personal package.

### 3. Work with the candy data

In 2015, we explored a dataset based on a Halloween candy survey (but it included many other odd and interesting questions). Work on something from [this homework from 2015](hw07_2015_data-wrangling-candy.html). It is good practice on basic
data ingest, exploration, character data cleanup, and wrangling.

### 4. Work with the `singer` data

The `singer_location` dataframe in the `singer` package contains geographical information stored in two different formats: 1. as a (dirty!) variable named `city`; 2. as a latitude / longitude pair (stored in `latitude`, `longitude` respectively). The function `revgeocode` from the `ggmap` library allows you to retrieve some information for a pair (vector) of longitude, latitude (warning: notice the order in which you need to pass lat and long). Read its manual page.

1. Use `purrr` to map latitude and longitude into human readable information on the band's origin places. Notice that `revgeocode(... , output = "more")` outputs a dataframe, while `revgeocode(... , output = "address")` returns a string: you have the option of dealing with nested dataframes.  
You will need to pay attention to two things:  
    *  Not all of the track have a latitude and longitude: what can we do with the missing information? (_filtering_, ...)
    *  Not all of the time we make a research through `revgeocode()` we get a result. What can we do to avoid those errors to bite us? (look at _possibly()_ in `purrr`...)


2. Try to check wether the place in `city` corresponds to the information you retrieved.

3. If you still have time, you can go visual: give a look to the library [`leaflet`](https://rstudio.github.io/leaflet) and plot some information about the bands. A snippet of code is provided below.  
```r
singer_locations %>%  
  leaflet()  %>%   
  addTiles() %>%  
  addCircles(popup = ~artist_name)
```

### 5. Work with a list

Work through and write up a lesson from the [purrr
tutorial](https://jennybc.github.io/purrr-tutorial/index.html):

  * [Trump Android
Tweets](https://jennybc.github.io/purrr-tutorial/ls08_trump-tweets.html)
  * [Simplifying data from a list of GitHub
users](https://jennybc.github.io/purrr-tutorial/ls02_map-extraction-advanced.html)

### 6. Work with a nested data frame

Create a nested data frame and map a function over the list column holding the
nested data. Use list extraction or other functions to pull interesting
information out of these results and work your way back to a simple data frame
you can visualize and explore.

Here's a fully developed prompt for Gapminder:

  * See the [split-apply-combine lesson from
class](block024_group-nest-split-map.html)
  * Nest the data by country (and continent).
  * Fit a model of life expectancy against year. Possibly quadratic,
possibly robust (see above prompt re: function writing).
  * Use functions for working with fitted models or the [broom
package](https://github.com/tidyverse/broom) to get information out of your
linear models.
  * Use the usual dplyr, tidyr, and ggplot2 workflows to explore,
e.g., the estimated cofficients.

Inspiration for the modelling and downstream inspiration

  * Find countries with interesting stories. - Sudden, substantial departures from the temporal trend is interesting. How could you operationalize this notion of "interesting"?
  * Use the residuals to detect countries where your model is a
terrible fit. Examples: Are there are 1 or more freakishly large residuals, in
an absolute sense or relative to some estimate of background variability? Are
there strong patterns in the sign of the residuals? E.g., all pos, then all neg,
then pos again.
  * Fit a regression using ordinary least squares and a robust
technique. Determine the difference in estimated parameters under the two
approaches. If it is large, consider that country "interesting".
  * Compare a linear and quadratic fit

### Report your process

You're encouraged to reflect on what was hard/easy, problems you solved, helpful tutorials you read, etc. Give credit to your sources, whether it's a blog post, a fellow student, an online tutorial, etc.

### Submit the assignment

Follow instructions on [How to submit
homework](hw00_homework-guidelines.html#how-to-submit-homework)

### Rubric

Check minus: One or more elements are missing or sketchy. Missed opportunities
to complement code and numbers with a figure and interpretation. Technical
problem that is relatively easy to fix. It's hard to find the report in this
crazy repo.

Check: Hits all the elements. No obvious mistakes. Pleasant to read. No heroic
detective work required. Well done! *This should be the most typical mark!*

Check plus: Exceeded the requirements in number of dimensions. Developed novel
tasks that were indeed interesting and "worked". Impressive use of R -- maybe
involving functions, packages or workflows that weren't given in class
materials. Impeccable organization of repo and report. You learned something new
from reviewing their work and you're eager to incorporate it into your work.

## Peer Review


The peer review is ready and is due __November 13, 2017__ (before midnight)! Here's what you'll need to do:

0. Find your github username in the table below. If it's not there, let Giulio know! Slack me `@giulio`.
1. Add the _people who will be giving you a review_ as collaborators to the repo containing your homework submission.
2. Give a review of this homework for the two people you've been assigned to. There should be an issue in their repo titled something like `hw0x ready for grading` -- put your review in there as a comment.
    - If there is no such issue, make one! (in _their_ repo)
    - Please don't mix up your reviewers and reviewees!

** If you were assigned to a MISSING repo, please contact me @gvdr **

** If you did not yet communicate me your github handle, please do **

Check out the [guidelines for giving a peer review](http://stat545.com/peer-review02_peer-evaluation-guidelines.html).


Your_github       Instructions                                                                                                                                                                                                                                                                                                
----------------  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
abishekarun       Please add [ZimingY](https://github.com/ZimingY) and [zxkathy](https://github.com/zxkathy) as collaborators to your repo containing hw07. Please __review the hw07 submission of [xinmiaow](https://github.com/xinmiaow) and [MISSING](https://github.com/MISSING)__.                                       
AnhKhoaVo         Please add [yanchaoluo](https://github.com/yanchaoluo) and [hsmohammed](https://github.com/hsmohammed) as collaborators to your repo containing hw07. Please __review the hw07 submission of [heathersummers](https://github.com/heathersummers) and [Mathnstein](https://github.com/Mathnstein)__.         
arsbar24          Please add [gbraich](https://github.com/gbraich) and [menglinzhou](https://github.com/menglinzhou) as collaborators to your repo containing hw07. Please __review the hw07 submission of [SonjaS1](https://github.com/SonjaS1) and [KateJohnson](https://github.com/KateJohnson)__.                         
arthursunbao      Please add [juansbr7](https://github.com/juansbr7) and [rishadhabib](https://github.com/rishadhabib) as collaborators to your repo containing hw07. Please __review the hw07 submission of [yanchaoluo](https://github.com/yanchaoluo) and [hsmohammed](https://github.com/hsmohammed)__.                   
bcahn7            Please add [peterwhitman](https://github.com/peterwhitman) and [yidie](https://github.com/yidie) as collaborators to your repo containing hw07. Please __review the hw07 submission of [Shirlett](https://github.com/Shirlett) and [Kozp](https://github.com/Kozp)__.                                       
CassKon           Please add [MISSING](https://github.com/MISSING) and [swynes](https://github.com/swynes) as collaborators to your repo containing hw07. Please __review the hw07 submission of [yeonukkim](https://github.com/yeonukkim) and [vibudh2209](https://github.com/vibudh2209)__.                                 
cheungamanda      Please add [wenzhengzzz](https://github.com/wenzhengzzz) and [sepkamal](https://github.com/sepkamal) as collaborators to your repo containing hw07. Please __review the hw07 submission of [santiagodr](https://github.com/santiagodr) and [margotgunning](https://github.com/margotgunning)__.             
dorawyy           Please add [vanflad](https://github.com/vanflad) and [mattsada](https://github.com/mattsada) as collaborators to your repo containing hw07. Please __review the hw07 submission of [peterwhitman](https://github.com/peterwhitman) and [yidie](https://github.com/yidie)__.                                 
emilymistick      Please add [SonjaS1](https://github.com/SonjaS1) and [KateJohnson](https://github.com/KateJohnson) as collaborators to your repo containing hw07. Please __review the hw07 submission of [juansbr7](https://github.com/juansbr7) and [rishadhabib](https://github.com/rishadhabib)__.                       
emwest            Please add [Shirlett](https://github.com/Shirlett) and [Kozp](https://github.com/Kozp) as collaborators to your repo containing hw07. Please __review the hw07 submission of [xinyaofan](https://github.com/xinyaofan) and [hannahdxz](https://github.com/hannahdxz)__.                                     
farihakhan        Please add [heathersummers](https://github.com/heathersummers) and [Mathnstein](https://github.com/Mathnstein) as collaborators to your repo containing hw07. Please __review the hw07 submission of [ilgan](https://github.com/ilgan) and [MISSING](https://github.com/MISSING)__.                         
gbraich           Please add [yuanjisun](https://github.com/yuanjisun) and [suminwei2772](https://github.com/suminwei2772) as collaborators to your repo containing hw07. Please __review the hw07 submission of [menglinzhou](https://github.com/menglinzhou) and [arsbar24](https://github.com/arsbar24)__.                 
hannahdxz         Please add [emwest](https://github.com/emwest) and [xinyaofan](https://github.com/xinyaofan) as collaborators to your repo containing hw07. Please __review the hw07 submission of [marbazua](https://github.com/marbazua) and [HScheiber](https://github.com/HScheiber)__.                                 
heathersummers    Please add [hsmohammed](https://github.com/hsmohammed) and [AnhKhoaVo](https://github.com/AnhKhoaVo) as collaborators to your repo containing hw07. Please __review the hw07 submission of [Mathnstein](https://github.com/Mathnstein) and [farihakhan](https://github.com/farihakhan)__.                   
HScheiber         Please add [hannahdxz](https://github.com/hannahdxz) and [marbazua](https://github.com/marbazua) as collaborators to your repo containing hw07. Please __review the hw07 submission of [jmurthy12](https://github.com/jmurthy12) and [vmichalowski](https://github.com/vmichalowski)__.                     
hsmohammed        Please add [arthursunbao](https://github.com/arthursunbao) and [yanchaoluo](https://github.com/yanchaoluo) as collaborators to your repo containing hw07. Please __review the hw07 submission of [AnhKhoaVo](https://github.com/AnhKhoaVo) and [heathersummers](https://github.com/heathersummers)__.       
ilgan             Please add [Mathnstein](https://github.com/Mathnstein) and [farihakhan](https://github.com/farihakhan) as collaborators to your repo containing hw07. Please __review the hw07 submission of [MISSING](https://github.com/MISSING) and [rainerlempert](https://github.com/rainerlempert)__.                 
jmurthy12         Please add [marbazua](https://github.com/marbazua) and [HScheiber](https://github.com/HScheiber) as collaborators to your repo containing hw07. Please __review the hw07 submission of [vmichalowski](https://github.com/vmichalowski) and [wswade2](https://github.com/wswade2)__.                         
juansbr7          Please add [KateJohnson](https://github.com/KateJohnson) and [emilymistick](https://github.com/emilymistick) as collaborators to your repo containing hw07. Please __review the hw07 submission of [rishadhabib](https://github.com/rishadhabib) and [arthursunbao](https://github.com/arthursunbao)__.     
KateJohnson       Please add [arsbar24](https://github.com/arsbar24) and [SonjaS1](https://github.com/SonjaS1) as collaborators to your repo containing hw07. Please __review the hw07 submission of [emilymistick](https://github.com/emilymistick) and [juansbr7](https://github.com/juansbr7)__.                           
Kozp              Please add [bcahn7](https://github.com/bcahn7) and [Shirlett](https://github.com/Shirlett) as collaborators to your repo containing hw07. Please __review the hw07 submission of [emwest](https://github.com/emwest) and [xinyaofan](https://github.com/xinyaofan)__.                                       
marbazua          Please add [xinyaofan](https://github.com/xinyaofan) and [hannahdxz](https://github.com/hannahdxz) as collaborators to your repo containing hw07. Please __review the hw07 submission of [HScheiber](https://github.com/HScheiber) and [jmurthy12](https://github.com/jmurthy12)__.                         
margotgunning     Please add [cheungamanda](https://github.com/cheungamanda) and [santiagodr](https://github.com/santiagodr) as collaborators to your repo containing hw07. Please __review the hw07 submission of [yuanjisun](https://github.com/yuanjisun) and [suminwei2772](https://github.com/suminwei2772)__.           
Mathnstein        Please add [AnhKhoaVo](https://github.com/AnhKhoaVo) and [heathersummers](https://github.com/heathersummers) as collaborators to your repo containing hw07. Please __review the hw07 submission of [farihakhan](https://github.com/farihakhan) and [ilgan](https://github.com/ilgan)__.                     
mattsada          Please add [mlawre01](https://github.com/mlawre01) and [vanflad](https://github.com/vanflad) as collaborators to your repo containing hw07. Please __review the hw07 submission of [dorawyy](https://github.com/dorawyy) and [peterwhitman](https://github.com/peterwhitman)__.                             
menglinzhou       Please add [suminwei2772](https://github.com/suminwei2772) and [gbraich](https://github.com/gbraich) as collaborators to your repo containing hw07. Please __review the hw07 submission of [arsbar24](https://github.com/arsbar24) and [SonjaS1](https://github.com/SonjaS1)__.                             
Benjamin Hives    Please add [abishekarun](https://github.com/abishekarun) and [xinmiaow](https://github.com/xinmiaow) as collaborators to your repo containing hw07. Please __review the hw07 submission of [swynes](https://github.com/swynes) and [CassKon](https://github.com/CassKon)__.                                 
Cathy Tang        Please add [farihakhan](https://github.com/farihakhan) and [ilgan](https://github.com/ilgan) as collaborators to your repo containing hw07. Please __review the hw07 submission of [rainerlempert](https://github.com/rainerlempert) and [mlawre01](https://github.com/mlawre01)__.                         
mlawre01          Please add [MISSING](https://github.com/MISSING) and [rainerlempert](https://github.com/rainerlempert) as collaborators to your repo containing hw07. Please __review the hw07 submission of [vanflad](https://github.com/vanflad) and [mattsada](https://github.com/mattsada)__.                           
mylinhthibodeau   Please add [vibudh2209](https://github.com/vibudh2209) and [Tangjiahui26](https://github.com/Tangjiahui26) as collaborators to your repo containing hw07. Please __review the hw07 submission of [wenzhengzzz](https://github.com/wenzhengzzz) and [sepkamal](https://github.com/sepkamal)__.               
peterwhitman      Please add [mattsada](https://github.com/mattsada) and [dorawyy](https://github.com/dorawyy) as collaborators to your repo containing hw07. Please __review the hw07 submission of [yidie](https://github.com/yidie) and [bcahn7](https://github.com/bcahn7)__.                                             
rainerlempert     Please add [ilgan](https://github.com/ilgan) and [MISSING](https://github.com/MISSING) as collaborators to your repo containing hw07. Please __review the hw07 submission of [mlawre01](https://github.com/mlawre01) and [vanflad](https://github.com/vanflad)__.                                           
rishadhabib       Please add [emilymistick](https://github.com/emilymistick) and [juansbr7](https://github.com/juansbr7) as collaborators to your repo containing hw07. Please __review the hw07 submission of [arthursunbao](https://github.com/arthursunbao) and [yanchaoluo](https://github.com/yanchaoluo)__.             
santiagodr        Please add [sepkamal](https://github.com/sepkamal) and [cheungamanda](https://github.com/cheungamanda) as collaborators to your repo containing hw07. Please __review the hw07 submission of [margotgunning](https://github.com/margotgunning) and [yuanjisun](https://github.com/yuanjisun)__.             
sepkamal          Please add [mylinhthibodeau](https://github.com/mylinhthibodeau) and [wenzhengzzz](https://github.com/wenzhengzzz) as collaborators to your repo containing hw07. Please __review the hw07 submission of [cheungamanda](https://github.com/cheungamanda) and [santiagodr](https://github.com/santiagodr)__. 
Shirlett          Please add [yidie](https://github.com/yidie) and [bcahn7](https://github.com/bcahn7) as collaborators to your repo containing hw07. Please __review the hw07 submission of [Kozp](https://github.com/Kozp) and [emwest](https://github.com/emwest)__.                                                       
SonjaS1           Please add [menglinzhou](https://github.com/menglinzhou) and [arsbar24](https://github.com/arsbar24) as collaborators to your repo containing hw07. Please __review the hw07 submission of [KateJohnson](https://github.com/KateJohnson) and [emilymistick](https://github.com/emilymistick)__.             
suminwei2772      Please add [margotgunning](https://github.com/margotgunning) and [yuanjisun](https://github.com/yuanjisun) as collaborators to your repo containing hw07. Please __review the hw07 submission of [gbraich](https://github.com/gbraich) and [menglinzhou](https://github.com/menglinzhou)__.                 
swynes            Please add [xinmiaow](https://github.com/xinmiaow) and [MISSING](https://github.com/MISSING) as collaborators to your repo containing hw07. Please __review the hw07 submission of [CassKon](https://github.com/CassKon) and [yeonukkim](https://github.com/yeonukkim)__.                                   
Tangjiahui26      Please add [yeonukkim](https://github.com/yeonukkim) and [vibudh2209](https://github.com/vibudh2209) as collaborators to your repo containing hw07. Please __review the hw07 submission of [mylinhthibodeau](https://github.com/mylinhthibodeau) and [wenzhengzzz](https://github.com/wenzhengzzz)__.       
vanflad           Please add [rainerlempert](https://github.com/rainerlempert) and [mlawre01](https://github.com/mlawre01) as collaborators to your repo containing hw07. Please __review the hw07 submission of [mattsada](https://github.com/mattsada) and [dorawyy](https://github.com/dorawyy)__.                         
vibudh2209        Please add [CassKon](https://github.com/CassKon) and [yeonukkim](https://github.com/yeonukkim) as collaborators to your repo containing hw07. Please __review the hw07 submission of [Tangjiahui26](https://github.com/Tangjiahui26) and [mylinhthibodeau](https://github.com/mylinhthibodeau)__.           
vmichalowski      Please add [HScheiber](https://github.com/HScheiber) and [jmurthy12](https://github.com/jmurthy12) as collaborators to your repo containing hw07. Please __review the hw07 submission of [wswade2](https://github.com/wswade2) and [ZimingY](https://github.com/ZimingY)__.                                 
wenzhengzzz       Please add [Tangjiahui26](https://github.com/Tangjiahui26) and [mylinhthibodeau](https://github.com/mylinhthibodeau) as collaborators to your repo containing hw07. Please __review the hw07 submission of [sepkamal](https://github.com/sepkamal) and [cheungamanda](https://github.com/cheungamanda)__.   
wswade2           Please add [jmurthy12](https://github.com/jmurthy12) and [vmichalowski](https://github.com/vmichalowski) as collaborators to your repo containing hw07. Please __review the hw07 submission of [ZimingY](https://github.com/ZimingY) and [zxkathy](https://github.com/zxkathy)__.                           
xinmiaow          Please add [zxkathy](https://github.com/zxkathy) and [abishekarun](https://github.com/abishekarun) as collaborators to your repo containing hw07. Please __review the hw07 submission of [MISSING](https://github.com/MISSING) and [swynes](https://github.com/swynes)__.                                   
xinyaofan         Please add [Kozp](https://github.com/Kozp) and [emwest](https://github.com/emwest) as collaborators to your repo containing hw07. Please __review the hw07 submission of [hannahdxz](https://github.com/hannahdxz) and [marbazua](https://github.com/marbazua)__.                                           
yanchaoluo        Please add [rishadhabib](https://github.com/rishadhabib) and [arthursunbao](https://github.com/arthursunbao) as collaborators to your repo containing hw07. Please __review the hw07 submission of [hsmohammed](https://github.com/hsmohammed) and [AnhKhoaVo](https://github.com/AnhKhoaVo)__.             
yeonukkim         Please add [swynes](https://github.com/swynes) and [CassKon](https://github.com/CassKon) as collaborators to your repo containing hw07. Please __review the hw07 submission of [vibudh2209](https://github.com/vibudh2209) and [Tangjiahui26](https://github.com/Tangjiahui26)__.                           
yidie             Please add [dorawyy](https://github.com/dorawyy) and [peterwhitman](https://github.com/peterwhitman) as collaborators to your repo containing hw07. Please __review the hw07 submission of [bcahn7](https://github.com/bcahn7) and [Shirlett](https://github.com/Shirlett)__.                               
yuanjisun         Please add [santiagodr](https://github.com/santiagodr) and [margotgunning](https://github.com/margotgunning) as collaborators to your repo containing hw07. Please __review the hw07 submission of [suminwei2772](https://github.com/suminwei2772) and [gbraich](https://github.com/gbraich)__.             
ZimingY           Please add [vmichalowski](https://github.com/vmichalowski) and [wswade2](https://github.com/wswade2) as collaborators to your repo containing hw07. Please __review the hw07 submission of [zxkathy](https://github.com/zxkathy) and [abishekarun](https://github.com/abishekarun)__.                       
zxkathy           Please add [wswade2](https://github.com/wswade2) and [ZimingY](https://github.com/ZimingY) as collaborators to your repo containing hw07. Please __review the hw07 submission of [abishekarun](https://github.com/abishekarun) and [xinmiaow](https://github.com/xinmiaow)__.                               
