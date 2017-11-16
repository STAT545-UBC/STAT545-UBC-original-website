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
----------------  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
abishekarun       Please add [ZimingY](https://github.com/ZimingY) and [zxkathy](https://github.com/zxkathy) as collaborators to your repo containing hw07. Please __review the hw07 submission of [xinmiaow](https://github.com/xinmiaow) and [qiaoyuet](https://github.com/qiaoyuet)__.                                     
Alexander-Morin   Please add [Shirlett](https://github.com/Shirlett) and [Kozp](https://github.com/Kozp) as collaborators to your repo containing hw07. Please __review the hw07 submission of [xinyaofan](https://github.com/xinyaofan) and [hannahdxz](https://github.com/hannahdxz)__.                                     
AnhKhoaVo         Please add [yanchaoluo](https://github.com/yanchaoluo) and [hsmohammed](https://github.com/hsmohammed) as collaborators to your repo containing hw07. Please __review the hw07 submission of [heathersummers](https://github.com/heathersummers) and [Mathnstein](https://github.com/Mathnstein)__.         
arsbar24          Please add [gbraich](https://github.com/gbraich) and [menglinzhou](https://github.com/menglinzhou) as collaborators to your repo containing hw07. Please __review the hw07 submission of [SonjaS1](https://github.com/SonjaS1) and [KateJohnson](https://github.com/KateJohnson)__.                         
arthursunbao      Please add [juansbr7](https://github.com/juansbr7) and [rishadhabib](https://github.com/rishadhabib) as collaborators to your repo containing hw07. Please __review the hw07 submission of [yanchaoluo](https://github.com/yanchaoluo) and [hsmohammed](https://github.com/hsmohammed)__.                   
bcahn7            Please add [peterwhitman](https://github.com/peterwhitman) and [yidie](https://github.com/yidie) as collaborators to your repo containing hw07. Please __review the hw07 submission of [Shirlett](https://github.com/Shirlett) and [Kozp](https://github.com/Kozp)__.                                       
CassKon           Please add [qiaoyuet](https://github.com/qiaoyuet) and [swynes](https://github.com/swynes) as collaborators to your repo containing hw07. Please __review the hw07 submission of [yeonukkim](https://github.com/yeonukkim) and [vibudh2209](https://github.com/vibudh2209)__.                               
cheungamanda      Please add [wenzhengzzz](https://github.com/wenzhengzzz) and [sepkamal](https://github.com/sepkamal) as collaborators to your repo containing hw07. Please __review the hw07 submission of [santiagodr](https://github.com/santiagodr) and [margotgunning](https://github.com/margotgunning)__.             
dorawyy           Please add [vanflad](https://github.com/vanflad) and [mattsada](https://github.com/mattsada) as collaborators to your repo containing hw07. Please __review the hw07 submission of [peterwhitman](https://github.com/peterwhitman) and [yidie](https://github.com/yidie)__.                                 
emilymistick      Please add [SonjaS1](https://github.com/SonjaS1) and [KateJohnson](https://github.com/KateJohnson) as collaborators to your repo containing hw07. Please __review the hw07 submission of [juansbr7](https://github.com/juansbr7) and [rishadhabib](https://github.com/rishadhabib)__.                       
emwest            Please add [farihakhan](https://github.com/farihakhan) and [ilgan](https://github.com/ilgan) as collaborators to your repo containing hw07. Please __review the hw07 submission of [rainerlempert](https://github.com/rainerlempert) and [mlawre01](https://github.com/mlawre01)__.                         
farihakhan        Please add [heathersummers](https://github.com/heathersummers) and [Mathnstein](https://github.com/Mathnstein) as collaborators to your repo containing hw07. Please __review the hw07 submission of [ilgan](https://github.com/ilgan) and [emwest](https://github.com/emwest)__.                           
gbraich           Please add [yuanjisun](https://github.com/yuanjisun) and [suminwei2772](https://github.com/suminwei2772) as collaborators to your repo containing hw07. Please __review the hw07 submission of [menglinzhou](https://github.com/menglinzhou) and [arsbar24](https://github.com/arsbar24)__.                 
hannahdxz         Please add [Alexander-Morin](https://github.com/Alexander-Morin) and [xinyaofan](https://github.com/xinyaofan) as collaborators to your repo containing hw07. Please __review the hw07 submission of [marbazua](https://github.com/marbazua) and [HScheiber](https://github.com/HScheiber)__.               
heathersummers    Please add [hsmohammed](https://github.com/hsmohammed) and [AnhKhoaVo](https://github.com/AnhKhoaVo) as collaborators to your repo containing hw07. Please __review the hw07 submission of [Mathnstein](https://github.com/Mathnstein) and [farihakhan](https://github.com/farihakhan)__.                   
HScheiber         Please add [hannahdxz](https://github.com/hannahdxz) and [marbazua](https://github.com/marbazua) as collaborators to your repo containing hw07. Please __review the hw07 submission of [jmurthy12](https://github.com/jmurthy12) and [vmichalowski](https://github.com/vmichalowski)__.                     
hsmohammed        Please add [arthursunbao](https://github.com/arthursunbao) and [yanchaoluo](https://github.com/yanchaoluo) as collaborators to your repo containing hw07. Please __review the hw07 submission of [AnhKhoaVo](https://github.com/AnhKhoaVo) and [heathersummers](https://github.com/heathersummers)__.       
ilgan             Please add [Mathnstein](https://github.com/Mathnstein) and [farihakhan](https://github.com/farihakhan) as collaborators to your repo containing hw07. Please __review the hw07 submission of [emwest](https://github.com/emwest) and [rainerlempert](https://github.com/rainerlempert)__.                   
jmurthy12         Please add [marbazua](https://github.com/marbazua) and [HScheiber](https://github.com/HScheiber) as collaborators to your repo containing hw07. Please __review the hw07 submission of [vmichalowski](https://github.com/vmichalowski) and [wswade2](https://github.com/wswade2)__.                         
juansbr7          Please add [KateJohnson](https://github.com/KateJohnson) and [emilymistick](https://github.com/emilymistick) as collaborators to your repo containing hw07. Please __review the hw07 submission of [rishadhabib](https://github.com/rishadhabib) and [arthursunbao](https://github.com/arthursunbao)__.     
KateJohnson       Please add [arsbar24](https://github.com/arsbar24) and [SonjaS1](https://github.com/SonjaS1) as collaborators to your repo containing hw07. Please __review the hw07 submission of [emilymistick](https://github.com/emilymistick) and [juansbr7](https://github.com/juansbr7)__.                           
Kozp              Please add [bcahn7](https://github.com/bcahn7) and [Shirlett](https://github.com/Shirlett) as collaborators to your repo containing hw07. Please __review the hw07 submission of [Alexander-Morin](https://github.com/Alexander-Morin) and [xinyaofan](https://github.com/xinyaofan)__.                     
marbazua          Please add [xinyaofan](https://github.com/xinyaofan) and [hannahdxz](https://github.com/hannahdxz) as collaborators to your repo containing hw07. Please __review the hw07 submission of [HScheiber](https://github.com/HScheiber) and [jmurthy12](https://github.com/jmurthy12)__.                         
margotgunning     Please add [cheungamanda](https://github.com/cheungamanda) and [santiagodr](https://github.com/santiagodr) as collaborators to your repo containing hw07. Please __review the hw07 submission of [yuanjisun](https://github.com/yuanjisun) and [suminwei2772](https://github.com/suminwei2772)__.           
Mathnstein        Please add [AnhKhoaVo](https://github.com/AnhKhoaVo) and [heathersummers](https://github.com/heathersummers) as collaborators to your repo containing hw07. Please __review the hw07 submission of [farihakhan](https://github.com/farihakhan) and [ilgan](https://github.com/ilgan)__.                     
mattsada          Please add [mlawre01](https://github.com/mlawre01) and [vanflad](https://github.com/vanflad) as collaborators to your repo containing hw07. Please __review the hw07 submission of [dorawyy](https://github.com/dorawyy) and [peterwhitman](https://github.com/peterwhitman)__.                             
menglinzhou       Please add [suminwei2772](https://github.com/suminwei2772) and [gbraich](https://github.com/gbraich) as collaborators to your repo containing hw07. Please __review the hw07 submission of [arsbar24](https://github.com/arsbar24) and [SonjaS1](https://github.com/SonjaS1)__.                             
mlawre01          Please add [emwest](https://github.com/emwest) and [rainerlempert](https://github.com/rainerlempert) as collaborators to your repo containing hw07. Please __review the hw07 submission of [vanflad](https://github.com/vanflad) and [mattsada](https://github.com/mattsada)__.                             
mylinhthibodeau   Please add [vibudh2209](https://github.com/vibudh2209) and [Tangjiahui26](https://github.com/Tangjiahui26) as collaborators to your repo containing hw07. Please __review the hw07 submission of [wenzhengzzz](https://github.com/wenzhengzzz) and [sepkamal](https://github.com/sepkamal)__.               
peterwhitman      Please add [mattsada](https://github.com/mattsada) and [dorawyy](https://github.com/dorawyy) as collaborators to your repo containing hw07. Please __review the hw07 submission of [yidie](https://github.com/yidie) and [bcahn7](https://github.com/bcahn7)__.                                             
qiaoyuet          Please add [abishekarun](https://github.com/abishekarun) and [xinmiaow](https://github.com/xinmiaow) as collaborators to your repo containing hw07. Please __review the hw07 submission of [swynes](https://github.com/swynes) and [CassKon](https://github.com/CassKon)__.                                 
rainerlempert     Please add [ilgan](https://github.com/ilgan) and [emwest](https://github.com/emwest) as collaborators to your repo containing hw07. Please __review the hw07 submission of [mlawre01](https://github.com/mlawre01) and [vanflad](https://github.com/vanflad)__.                                             
rishadhabib       Please add [emilymistick](https://github.com/emilymistick) and [juansbr7](https://github.com/juansbr7) as collaborators to your repo containing hw07. Please __review the hw07 submission of [arthursunbao](https://github.com/arthursunbao) and [yanchaoluo](https://github.com/yanchaoluo)__.             
santiagodr        Please add [sepkamal](https://github.com/sepkamal) and [cheungamanda](https://github.com/cheungamanda) as collaborators to your repo containing hw07. Please __review the hw07 submission of [margotgunning](https://github.com/margotgunning) and [yuanjisun](https://github.com/yuanjisun)__.             
sepkamal          Please add [mylinhthibodeau](https://github.com/mylinhthibodeau) and [wenzhengzzz](https://github.com/wenzhengzzz) as collaborators to your repo containing hw07. Please __review the hw07 submission of [cheungamanda](https://github.com/cheungamanda) and [santiagodr](https://github.com/santiagodr)__. 
Shirlett          Please add [yidie](https://github.com/yidie) and [bcahn7](https://github.com/bcahn7) as collaborators to your repo containing hw07. Please __review the hw07 submission of [Kozp](https://github.com/Kozp) and [Alexander-Morin](https://github.com/Alexander-Morin)__.                                     
SonjaS1           Please add [menglinzhou](https://github.com/menglinzhou) and [arsbar24](https://github.com/arsbar24) as collaborators to your repo containing hw07. Please __review the hw07 submission of [KateJohnson](https://github.com/KateJohnson) and [emilymistick](https://github.com/emilymistick)__.             
suminwei2772      Please add [margotgunning](https://github.com/margotgunning) and [yuanjisun](https://github.com/yuanjisun) as collaborators to your repo containing hw07. Please __review the hw07 submission of [gbraich](https://github.com/gbraich) and [menglinzhou](https://github.com/menglinzhou)__.                 
swynes            Please add [xinmiaow](https://github.com/xinmiaow) and [qiaoyuet](https://github.com/qiaoyuet) as collaborators to your repo containing hw07. Please __review the hw07 submission of [CassKon](https://github.com/CassKon) and [yeonukkim](https://github.com/yeonukkim)__.                                 
Tangjiahui26      Please add [yeonukkim](https://github.com/yeonukkim) and [vibudh2209](https://github.com/vibudh2209) as collaborators to your repo containing hw07. Please __review the hw07 submission of [mylinhthibodeau](https://github.com/mylinhthibodeau) and [wenzhengzzz](https://github.com/wenzhengzzz)__.       
vanflad           Please add [rainerlempert](https://github.com/rainerlempert) and [mlawre01](https://github.com/mlawre01) as collaborators to your repo containing hw07. Please __review the hw07 submission of [mattsada](https://github.com/mattsada) and [dorawyy](https://github.com/dorawyy)__.                         
vibudh2209        Please add [CassKon](https://github.com/CassKon) and [yeonukkim](https://github.com/yeonukkim) as collaborators to your repo containing hw07. Please __review the hw07 submission of [Tangjiahui26](https://github.com/Tangjiahui26) and [mylinhthibodeau](https://github.com/mylinhthibodeau)__.           
vmichalowski      Please add [HScheiber](https://github.com/HScheiber) and [jmurthy12](https://github.com/jmurthy12) as collaborators to your repo containing hw07. Please __review the hw07 submission of [wswade2](https://github.com/wswade2) and [ZimingY](https://github.com/ZimingY)__.                                 
wenzhengzzz       Please add [Tangjiahui26](https://github.com/Tangjiahui26) and [mylinhthibodeau](https://github.com/mylinhthibodeau) as collaborators to your repo containing hw07. Please __review the hw07 submission of [sepkamal](https://github.com/sepkamal) and [cheungamanda](https://github.com/cheungamanda)__.   
wswade2           Please add [jmurthy12](https://github.com/jmurthy12) and [vmichalowski](https://github.com/vmichalowski) as collaborators to your repo containing hw07. Please __review the hw07 submission of [ZimingY](https://github.com/ZimingY) and [zxkathy](https://github.com/zxkathy)__.                           
xinmiaow          Please add [zxkathy](https://github.com/zxkathy) and [abishekarun](https://github.com/abishekarun) as collaborators to your repo containing hw07. Please __review the hw07 submission of [qiaoyuet](https://github.com/qiaoyuet) and [swynes](https://github.com/swynes)__.                                 
xinyaofan         Please add [Kozp](https://github.com/Kozp) and [Alexander-Morin](https://github.com/Alexander-Morin) as collaborators to your repo containing hw07. Please __review the hw07 submission of [hannahdxz](https://github.com/hannahdxz) and [marbazua](https://github.com/marbazua)__.                         
yanchaoluo        Please add [rishadhabib](https://github.com/rishadhabib) and [arthursunbao](https://github.com/arthursunbao) as collaborators to your repo containing hw07. Please __review the hw07 submission of [hsmohammed](https://github.com/hsmohammed) and [AnhKhoaVo](https://github.com/AnhKhoaVo)__.             
yeonukkim         Please add [swynes](https://github.com/swynes) and [CassKon](https://github.com/CassKon) as collaborators to your repo containing hw07. Please __review the hw07 submission of [vibudh2209](https://github.com/vibudh2209) and [Tangjiahui26](https://github.com/Tangjiahui26)__.                           
yidie             Please add [dorawyy](https://github.com/dorawyy) and [peterwhitman](https://github.com/peterwhitman) as collaborators to your repo containing hw07. Please __review the hw07 submission of [bcahn7](https://github.com/bcahn7) and [Shirlett](https://github.com/Shirlett)__.                               
yuanjisun         Please add [santiagodr](https://github.com/santiagodr) and [margotgunning](https://github.com/margotgunning) as collaborators to your repo containing hw07. Please __review the hw07 submission of [suminwei2772](https://github.com/suminwei2772) and [gbraich](https://github.com/gbraich)__.             
ZimingY           Please add [vmichalowski](https://github.com/vmichalowski) and [wswade2](https://github.com/wswade2) as collaborators to your repo containing hw07. Please __review the hw07 submission of [zxkathy](https://github.com/zxkathy) and [abishekarun](https://github.com/abishekarun)__.                       
zxkathy           Please add [wswade2](https://github.com/wswade2) and [ZimingY](https://github.com/ZimingY) as collaborators to your repo containing hw07. Please __review the hw07 submission of [abishekarun](https://github.com/abishekarun) and [xinmiaow](https://github.com/xinmiaow)__.                               
