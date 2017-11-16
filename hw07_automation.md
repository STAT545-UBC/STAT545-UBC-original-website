# Automating Data-analysis Pipelines

Due Friday 2017-November-14.

## Big picture

(We started this in class during the lecture.)

  * Write (or extract from a previous analysis) three or more R scripts to carry out a small data analysis.
  * The output of the first script must be the input of the second, and so on.
  * Something like this:
    - First script: download some data.
    - Second script: read the data, perform some analysis and write numerical data to file in CSV or TSV format.
    - Third script: read the output of the second script, generate some figures and save them to files.
    - Fourth script: an Rmd, actually, that presents original data, the statistical summaries, and/or the figures in a little report.
    - A fifth script to rule them all, i.e. to run the others in sequence.
    
You can use Make, Remake or (if you feel the urge for something more) a combinantion of Make and Remake.

## Templates you can follow

+ A bare bones example which uses only R:
  [01_justR][]
+ An example that also uses Make to run the pipeline:
  [02_rAndMake][]
+ An example that runs and R script and a renders an Rmarkdown file to HTML using Make:
  [03_knitWithoutRStudio][]

[01_justR]: https://github.com/STAT545-UBC/STAT545-UBC.github.io/tree/master/automation10_holding-area/01_automation-example_just-r
[02_rAndMake]: https://github.com/STAT545-UBC/STAT545-UBC.github.io/tree/master/automation10_holding-area/02_automation-example_r-and-make
[03_knitWithoutRStudio]: https://github.com/STAT545-UBC/STAT545-UBC.github.io/tree/master/automation10_holding-area/03_automation-example_render-without-rstudio

## More detailed instructions (optional)

If you don't feel like dreaming up your own thing, here's a Gapminder blueprint that is a minimal but respectable way to complete the assignment. You are welcome to remix R code already written by someone in this class, but do credit/link appropriately, e.g. in comments.

Jennifer Bryan has provided a template, using a different dataset, [01_justR][], that should help make this concrete.

### Download the data

Download the raw data for our example, [gapminder.tsv][].

+ Option 1: via an R script using [download.file][]

    ```r
	download.file("https://raw.githubusercontent.com/jennybc/gapminder/master/inst/gapminder.tsv", destfile="gapminder.tsv")
    ```

+ Option 2: in a [shell](git09_shell.html) script using `curl` or `wget`.

    ```bash
    curl -o gapminder.tsv https://raw.githubusercontent.com/jennybc/gapminder/master/inst/gapminder.tsv
    wget https://raw.githubusercontent.com/jennybc/gapminder/master/inst/gapminder.tsv
    ```

[gapminder.tsv]: https://github.com/jennybc/gapminder/blob/master/inst/gapminder.tsv
[download.file]: http://stat.ethz.ch/R-manual/R-patched/library/utils/html/download.file.html

### Perform exploratory analyses

+ Bring the data in as data frame.
+ Save a couple descriptive plots to file with highly informative names.
+ Reorder the continents based on life expectancy. You decide the details.
+ Sort the actual data in a deliberate fashion. You decide the details, but this should *at least* implement your new continent ordering.
+ Write the Gapminder data to file(s), for immediate and future reuse.

### Perform statistical analyses

+ Import the data created in the first script.
+ Make sure your new continent order is still in force. You decide the details.
+ Fit a linear regression of life expectancy on year within each country. Write the estimated intercepts, slopes, and residual error variance (or sd) to file. The R package `broom` may be useful here.
+ Find the 3 or 4 "worst" and "best" countries for each continent. You decide the details.

### Generate figures

Create a figure for each continent, and write one file per continent, with an informative name. The figure should give scatterplots of life expectancy vs. year, faceting on country, fitted line overlaid.

### Automate the pipeline

Write a master R script that simply `source()`s the three scripts, one after the other. Tip: you may want a second "clean up / reset" script that deletes all the output your scripts leave behind, so you can easily test and refine your strategy, i.e. without repeatedly  deleting stuff "by hand". You can run the master script or the cleaning script from a [shell](git09_shell.html) with `Rscript`.

Render your RMarkdown report generating Markdown and HTML using `rmarkdown::render`.

+ To render an RMarkdown report and emulate RStudio's "Knit HTML" button, use
  `rmarkdown::render('myAwesomeReport.rmd')`
+ To render an R script and emulate RStudio's "Compile Notebook" button, use
  `rmarkdown::render('myAwesomeScript.R')`

Write a `Makefile` to automate your pipeline using `make`. See the [Links](#links) section below for help. Also demonstrated in the example [02_rAndMake][] and in the example [03_knitWithoutRStudio][]

+ To run an R script use `Rscript myAwesomeScript.R`
+ To render an RMarkdown report, use `Rscript -e "rmarkdown::render('myAwesomeReport.rmd')"`
+ To render an R script, use `Rscript -e "rmarkdown::render('myAwesomeScript.R')"`
+ See the Makefile in [03_knitWithoutRStudio][] to see these commands in action

Provide a link to a `README.md` page that explains how your pipeline works and links to the remaining files. Your peers and the TAs should be able to go to this landing page and re-run your analysis quickly and easily.

Consider including an image showing a graphical view (the dependency diagram) of your pipeline using [makefile2graph](https://github.com/lindenb/makefile2graph). On Mac or Linux you can install `makefile2graph` using [Homebrew](http://brew.sh) or [Linuxbrew](http://linuxbrew.sh) with the command `brew install makefile2graph`.

## I want to aim higher!

Follow the basic Gapminder blueprint above, but find a different data aggregation task, different panelling/faceting emphasis, focus on different variables, etc.

Use non-Gapminder data -- like the singer data or your own?

This means you'll need to spend more time on data cleaning and sanity checking. You will probably have an entire script (or more!) devoted to data prep. Examples:

+ Are there wonky factors? Consider bringing in as character, addressing their deficiencies, then converting to factor.
+ Are there variables you're just willing to drop at this point? Do it!
+ Are there dates and times that need special handling? Do it!
+ Are there annoying observations that require very special handling or crap up your figures (e.g. Oceania)? Drop them!

Experiment with running R code saved in a script from within R Markdown. Here's some official documentation on [code externalization](http://yihui.name/knitr/demo/externalization/).

Embed pre-existing figures in an R Markdown document, i.e. an R script creates the figures, then the report incorporates them. General advice on writing figures to file is [here](block017_write-figure-to-file.html). See an example of this in [an R Markdown file in one of the examples](https://github.com/jennybc/STAT545A_2013/blob/master/hw06_scaffolds/03_knitWithoutRStudio/03_doStuff.Rmd).

Import pre-existing data in an R Markdown document, then format nicely as a table.

Use Pandoc and/or LaTeX to explore new territory in document compilation. You could use Pandoc as an alternative to `rmarkdown` (or `knitr`) for Markdown to HTML conversion; you'd still use `rmarkdown` for conversion of R Markdown to Markdown. You would use LaTeX to get PDF output from Markdown.

## Useful links

+ [An example of a data analysis pipeline using Make](https://github.com/sjackman/makefile-example/) by [Shaun Jackman](http://sjackman.ca)
+ [Automating Data Analysis Pipelines](http://sjackman.ca/makefile-slides/) slides by [Shaun Jackman](http://sjackman.ca)
+ [An introduction to `Make`](http://kbroman.github.io/minimal_make/) by Karl Broman aimed at stats / data science types
+ Blog post [Using Make for reproducible scientific analyses](http://www.bendmorris.com/2013/09/using-make-for-reproducible-scientific.html) by Ben Morris
+ [Slides on `Make`](http://software-carpentry.org/v4/make/index.html) from Software Carpentry
+ Mike Bostock on [Why Use Make](http://bost.ocks.org/mike/make/)
+ Zachary M. Jones on [GNU Make for Reproducible Data Analysis](http://zmjones.com/make.html)

## Authors

Written mostly by [Shaun Jackman][] and [Jenny Bryan][] with a little edit from [Giulio Dalla Riva][].

[Shaun Jackman]: http://sjackman.ca/
[Jenny Bryan]: http://www.stat.ubc.ca/~jenny/
[Giulio Dalla Riva]: https://www.gvdallariva.net
[CC BY 3.0]: http://creativecommons.org/licenses/by/3.0/

## Peer Review


The peer review is ready and is due __November 17, 2017__ (before midnight)! Here's what you'll need to do:

0. Find your github username in the table below. If it's not there, let Giulio know! Slack me `@giulio`.
1. Add the _people who will be giving you a review_ as collaborators to the repo containing your homework submission.
2. Give a review of this homework for the two people you've been assigned to. There should be an issue in their repo titled something like `hw0x ready for grading` -- put your review in there as a comment.
    - If there is no such issue, make one! (in _their_ repo)
    - Please don't mix up your reviewers and reviewees!

** If you were assigned to a MISSING repo, please contact me @gvdr **

** If you did not yet communicate me your github handle, please do **

Check out the [guidelines for giving a peer review](http://stat545.com/peer-review02_peer-evaluation-guidelines.html).


Your_github       Instructions                                                                                                                                                                                                                                                                                                      
----------------  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
abishekarun       Please add [xinmiaow](https://github.com/xinmiaow) and [wswade2](https://github.com/wswade2) as collaborators to your repo containing hw07. Please __review the hw07 submission of [cheungamanda](https://github.com/cheungamanda) and [sepkamal](https://github.com/sepkamal)__.                                 
Alexander-Morin   Please add [arsbar24](https://github.com/arsbar24) and [peterwhitman](https://github.com/peterwhitman) as collaborators to your repo containing hw07. Please __review the hw07 submission of [ZimingY](https://github.com/ZimingY) and [margotgunning](https://github.com/margotgunning)__.                       
AnhKhoaVo         Please add [emwest](https://github.com/emwest) and [suminwei2772](https://github.com/suminwei2772) as collaborators to your repo containing hw07. Please __review the hw07 submission of [zxkathy](https://github.com/zxkathy) and [xinyaofan](https://github.com/xinyaofan)__.                                   
arsbar24          Please add [emilymistick](https://github.com/emilymistick) and [marbazua](https://github.com/marbazua) as collaborators to your repo containing hw07. Please __review the hw07 submission of [peterwhitman](https://github.com/peterwhitman) and [Alexander-Morin](https://github.com/Alexander-Morin)__.         
arthursunbao      Please add [vanflad](https://github.com/vanflad) and [swynes](https://github.com/swynes) as collaborators to your repo containing hw07. Please __review the hw07 submission of [emilymistick](https://github.com/emilymistick) and [marbazua](https://github.com/marbazua)__.                                     
bcahn7            Please add [vibudh2209](https://github.com/vibudh2209) and [qiaoyuet](https://github.com/qiaoyuet) as collaborators to your repo containing hw07. Please __review the hw07 submission of [CassKon](https://github.com/CassKon) and [mlawre01](https://github.com/mlawre01)__.                                     
CassKon           Please add [qiaoyuet](https://github.com/qiaoyuet) and [bcahn7](https://github.com/bcahn7) as collaborators to your repo containing hw07. Please __review the hw07 submission of [mlawre01](https://github.com/mlawre01) and [mylinhthibodeau](https://github.com/mylinhthibodeau)__.                             
cheungamanda      Please add [wswade2](https://github.com/wswade2) and [abishekarun](https://github.com/abishekarun) as collaborators to your repo containing hw07. Please __review the hw07 submission of [sepkamal](https://github.com/sepkamal) and [Kozp](https://github.com/Kozp)__.                                           
dorawyy           Please add [Kozp](https://github.com/Kozp) and [yidie](https://github.com/yidie) as collaborators to your repo containing hw07. Please __review the hw07 submission of [emwest](https://github.com/emwest) and [suminwei2772](https://github.com/suminwei2772)__.                                                 
emilymistick      Please add [swynes](https://github.com/swynes) and [arthursunbao](https://github.com/arthursunbao) as collaborators to your repo containing hw07. Please __review the hw07 submission of [marbazua](https://github.com/marbazua) and [arsbar24](https://github.com/arsbar24)__.                                   
emwest            Please add [yidie](https://github.com/yidie) and [dorawyy](https://github.com/dorawyy) as collaborators to your repo containing hw07. Please __review the hw07 submission of [suminwei2772](https://github.com/suminwei2772) and [AnhKhoaVo](https://github.com/AnhKhoaVo)__.                                     
farihakhan        Please add [xinyaofan](https://github.com/xinyaofan) and [gbraich](https://github.com/gbraich) as collaborators to your repo containing hw07. Please __review the hw07 submission of [ilgan](https://github.com/ilgan) and [yuanjisun](https://github.com/yuanjisun)__.                                           
gbraich           Please add [zxkathy](https://github.com/zxkathy) and [xinyaofan](https://github.com/xinyaofan) as collaborators to your repo containing hw07. Please __review the hw07 submission of [farihakhan](https://github.com/farihakhan) and [ilgan](https://github.com/ilgan)__.                                         
hannahdxz         Please add [yuanjisun](https://github.com/yuanjisun) and [menglinzhou](https://github.com/menglinzhou) as collaborators to your repo containing hw07. Please __review the hw07 submission of [wenzhengzzz](https://github.com/wenzhengzzz) and [Mathnstein](https://github.com/Mathnstein)__.                     
heathersummers    Please add [santiagodr](https://github.com/santiagodr) and [mattsada](https://github.com/mattsada) as collaborators to your repo containing hw07. Please __review the hw07 submission of [SonjaS1](https://github.com/SonjaS1) and [vibudh2209](https://github.com/vibudh2209)__.                                 
HScheiber         Please add [yeonukkim](https://github.com/yeonukkim) and [hsmohammed](https://github.com/hsmohammed) as collaborators to your repo containing hw07. Please __review the hw07 submission of [santiagodr](https://github.com/santiagodr) and [mattsada](https://github.com/mattsada)__.                             
hsmohammed        Please add [Mathnstein](https://github.com/Mathnstein) and [yeonukkim](https://github.com/yeonukkim) as collaborators to your repo containing hw07. Please __review the hw07 submission of [HScheiber](https://github.com/HScheiber) and [santiagodr](https://github.com/santiagodr)__.                           
ilgan             Please add [gbraich](https://github.com/gbraich) and [farihakhan](https://github.com/farihakhan) as collaborators to your repo containing hw07. Please __review the hw07 submission of [yuanjisun](https://github.com/yuanjisun) and [menglinzhou](https://github.com/menglinzhou)__.                             
jmurthy12         Please add [yanchaoluo](https://github.com/yanchaoluo) and [Shirlett](https://github.com/Shirlett) as collaborators to your repo containing hw07. Please __review the hw07 submission of [juansbr7](https://github.com/juansbr7) and [KateJohnson](https://github.com/KateJohnson)__.                             
juansbr7          Please add [Shirlett](https://github.com/Shirlett) and [jmurthy12](https://github.com/jmurthy12) as collaborators to your repo containing hw07. Please __review the hw07 submission of [KateJohnson](https://github.com/KateJohnson) and [vanflad](https://github.com/vanflad)__.                                 
KateJohnson       Please add [jmurthy12](https://github.com/jmurthy12) and [juansbr7](https://github.com/juansbr7) as collaborators to your repo containing hw07. Please __review the hw07 submission of [vanflad](https://github.com/vanflad) and [swynes](https://github.com/swynes)__.                                           
Kozp              Please add [cheungamanda](https://github.com/cheungamanda) and [sepkamal](https://github.com/sepkamal) as collaborators to your repo containing hw07. Please __review the hw07 submission of [yidie](https://github.com/yidie) and [dorawyy](https://github.com/dorawyy)__.                                       
marbazua          Please add [arthursunbao](https://github.com/arthursunbao) and [emilymistick](https://github.com/emilymistick) as collaborators to your repo containing hw07. Please __review the hw07 submission of [arsbar24](https://github.com/arsbar24) and [peterwhitman](https://github.com/peterwhitman)__.               
margotgunning     Please add [Alexander-Morin](https://github.com/Alexander-Morin) and [ZimingY](https://github.com/ZimingY) as collaborators to your repo containing hw07. Please __review the hw07 submission of [xinmiaow](https://github.com/xinmiaow) and [wswade2](https://github.com/wswade2)__.                             
Mathnstein        Please add [hannahdxz](https://github.com/hannahdxz) and [wenzhengzzz](https://github.com/wenzhengzzz) as collaborators to your repo containing hw07. Please __review the hw07 submission of [yeonukkim](https://github.com/yeonukkim) and [hsmohammed](https://github.com/hsmohammed)__.                         
mattsada          Please add [HScheiber](https://github.com/HScheiber) and [santiagodr](https://github.com/santiagodr) as collaborators to your repo containing hw07. Please __review the hw07 submission of [heathersummers](https://github.com/heathersummers) and [SonjaS1](https://github.com/SonjaS1)__.                       
menglinzhou       Please add [ilgan](https://github.com/ilgan) and [yuanjisun](https://github.com/yuanjisun) as collaborators to your repo containing hw07. Please __review the hw07 submission of [hannahdxz](https://github.com/hannahdxz) and [wenzhengzzz](https://github.com/wenzhengzzz)__.                                   
mlawre01          Please add [bcahn7](https://github.com/bcahn7) and [CassKon](https://github.com/CassKon) as collaborators to your repo containing hw07. Please __review the hw07 submission of [mylinhthibodeau](https://github.com/mylinhthibodeau) and [rainerlempert](https://github.com/rainerlempert)__.                     
mylinhthibodeau   Please add [CassKon](https://github.com/CassKon) and [mlawre01](https://github.com/mlawre01) as collaborators to your repo containing hw07. Please __review the hw07 submission of [rainerlempert](https://github.com/rainerlempert) and [Tangjiahui26](https://github.com/Tangjiahui26)__.                       
peterwhitman      Please add [marbazua](https://github.com/marbazua) and [arsbar24](https://github.com/arsbar24) as collaborators to your repo containing hw07. Please __review the hw07 submission of [Alexander-Morin](https://github.com/Alexander-Morin) and [ZimingY](https://github.com/ZimingY)__.                           
qiaoyuet          Please add [SonjaS1](https://github.com/SonjaS1) and [vibudh2209](https://github.com/vibudh2209) as collaborators to your repo containing hw07. Please __review the hw07 submission of [bcahn7](https://github.com/bcahn7) and [CassKon](https://github.com/CassKon)__.                                           
rainerlempert     Please add [mlawre01](https://github.com/mlawre01) and [mylinhthibodeau](https://github.com/mylinhthibodeau) as collaborators to your repo containing hw07. Please __review the hw07 submission of [Tangjiahui26](https://github.com/Tangjiahui26) and [rishadhabib](https://github.com/rishadhabib)__.           
rishadhabib       Please add [rainerlempert](https://github.com/rainerlempert) and [Tangjiahui26](https://github.com/Tangjiahui26) as collaborators to your repo containing hw07. Please __review the hw07 submission of [vmichalowski](https://github.com/vmichalowski) and [yanchaoluo](https://github.com/yanchaoluo)__.         
santiagodr        Please add [hsmohammed](https://github.com/hsmohammed) and [HScheiber](https://github.com/HScheiber) as collaborators to your repo containing hw07. Please __review the hw07 submission of [mattsada](https://github.com/mattsada) and [heathersummers](https://github.com/heathersummers)__.                     
sepkamal          Please add [abishekarun](https://github.com/abishekarun) and [cheungamanda](https://github.com/cheungamanda) as collaborators to your repo containing hw07. Please __review the hw07 submission of [Kozp](https://github.com/Kozp) and [yidie](https://github.com/yidie)__.                                       
Shirlett          Please add [vmichalowski](https://github.com/vmichalowski) and [yanchaoluo](https://github.com/yanchaoluo) as collaborators to your repo containing hw07. Please __review the hw07 submission of [jmurthy12](https://github.com/jmurthy12) and [juansbr7](https://github.com/juansbr7)__.                         
SonjaS1           Please add [mattsada](https://github.com/mattsada) and [heathersummers](https://github.com/heathersummers) as collaborators to your repo containing hw07. Please __review the hw07 submission of [vibudh2209](https://github.com/vibudh2209) and [qiaoyuet](https://github.com/qiaoyuet)__.                       
suminwei2772      Please add [dorawyy](https://github.com/dorawyy) and [emwest](https://github.com/emwest) as collaborators to your repo containing hw07. Please __review the hw07 submission of [AnhKhoaVo](https://github.com/AnhKhoaVo) and [zxkathy](https://github.com/zxkathy)__.                                             
swynes            Please add [KateJohnson](https://github.com/KateJohnson) and [vanflad](https://github.com/vanflad) as collaborators to your repo containing hw07. Please __review the hw07 submission of [arthursunbao](https://github.com/arthursunbao) and [emilymistick](https://github.com/emilymistick)__.                   
Tangjiahui26      Please add [mylinhthibodeau](https://github.com/mylinhthibodeau) and [rainerlempert](https://github.com/rainerlempert) as collaborators to your repo containing hw07. Please __review the hw07 submission of [rishadhabib](https://github.com/rishadhabib) and [vmichalowski](https://github.com/vmichalowski)__. 
vanflad           Please add [juansbr7](https://github.com/juansbr7) and [KateJohnson](https://github.com/KateJohnson) as collaborators to your repo containing hw07. Please __review the hw07 submission of [swynes](https://github.com/swynes) and [arthursunbao](https://github.com/arthursunbao)__.                             
vibudh2209        Please add [heathersummers](https://github.com/heathersummers) and [SonjaS1](https://github.com/SonjaS1) as collaborators to your repo containing hw07. Please __review the hw07 submission of [qiaoyuet](https://github.com/qiaoyuet) and [bcahn7](https://github.com/bcahn7)__.                                 
vmichalowski      Please add [Tangjiahui26](https://github.com/Tangjiahui26) and [rishadhabib](https://github.com/rishadhabib) as collaborators to your repo containing hw07. Please __review the hw07 submission of [yanchaoluo](https://github.com/yanchaoluo) and [Shirlett](https://github.com/Shirlett)__.                     
wenzhengzzz       Please add [menglinzhou](https://github.com/menglinzhou) and [hannahdxz](https://github.com/hannahdxz) as collaborators to your repo containing hw07. Please __review the hw07 submission of [Mathnstein](https://github.com/Mathnstein) and [yeonukkim](https://github.com/yeonukkim)__.                         
wswade2           Please add [margotgunning](https://github.com/margotgunning) and [xinmiaow](https://github.com/xinmiaow) as collaborators to your repo containing hw07. Please __review the hw07 submission of [abishekarun](https://github.com/abishekarun) and [cheungamanda](https://github.com/cheungamanda)__.               
xinmiaow          Please add [ZimingY](https://github.com/ZimingY) and [margotgunning](https://github.com/margotgunning) as collaborators to your repo containing hw07. Please __review the hw07 submission of [wswade2](https://github.com/wswade2) and [abishekarun](https://github.com/abishekarun)__.                           
xinyaofan         Please add [AnhKhoaVo](https://github.com/AnhKhoaVo) and [zxkathy](https://github.com/zxkathy) as collaborators to your repo containing hw07. Please __review the hw07 submission of [gbraich](https://github.com/gbraich) and [farihakhan](https://github.com/farihakhan)__.                                     
yanchaoluo        Please add [rishadhabib](https://github.com/rishadhabib) and [vmichalowski](https://github.com/vmichalowski) as collaborators to your repo containing hw07. Please __review the hw07 submission of [Shirlett](https://github.com/Shirlett) and [jmurthy12](https://github.com/jmurthy12)__.                       
yeonukkim         Please add [wenzhengzzz](https://github.com/wenzhengzzz) and [Mathnstein](https://github.com/Mathnstein) as collaborators to your repo containing hw07. Please __review the hw07 submission of [hsmohammed](https://github.com/hsmohammed) and [HScheiber](https://github.com/HScheiber)__.                       
yidie             Please add [sepkamal](https://github.com/sepkamal) and [Kozp](https://github.com/Kozp) as collaborators to your repo containing hw07. Please __review the hw07 submission of [dorawyy](https://github.com/dorawyy) and [emwest](https://github.com/emwest)__.                                                     
yuanjisun         Please add [farihakhan](https://github.com/farihakhan) and [ilgan](https://github.com/ilgan) as collaborators to your repo containing hw07. Please __review the hw07 submission of [menglinzhou](https://github.com/menglinzhou) and [hannahdxz](https://github.com/hannahdxz)__.                                 
ZimingY           Please add [peterwhitman](https://github.com/peterwhitman) and [Alexander-Morin](https://github.com/Alexander-Morin) as collaborators to your repo containing hw07. Please __review the hw07 submission of [margotgunning](https://github.com/margotgunning) and [xinmiaow](https://github.com/xinmiaow)__.       
zxkathy           Please add [suminwei2772](https://github.com/suminwei2772) and [AnhKhoaVo](https://github.com/AnhKhoaVo) as collaborators to your repo containing hw07. Please __review the hw07 submission of [xinyaofan](https://github.com/xinyaofan) and [gbraich](https://github.com/gbraich)__.                             
