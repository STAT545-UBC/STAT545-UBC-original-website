---
title: "Automating Data-analysis Pipelines"
output:
  html_document:
    toc: true
    toc_depth: 2
---

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
