---
title: "Automating Data-analysis Pipelines"
output:
  html_document:
    toc: true
    toc_depth: 2
---

Big picture
================================================================================

+ Write three or more R scripts to carry out a data analysis pipeline
+ The output of the first script must be the input of the second, and so on
+ The first script will download some data
+ The second script will read that data, perform some analysis and write numerical data to file in CSV or TSV format
+ The third script will read the output of the second script, generate some figures and save them to files
+ Finally, a fourth script to rule them all will run your pipeline non-interactively, without RStudio
+ Feel free to add more stages to your pipeline if you're feeling adventurous

Templates
================================================================================

+ Bare bones example using only R:
  [01_justR][]
+ Example upgraded to include using Make to run the pipeline:
  [02_rAndMake][]
+ Example compiling an R script and an R Markdown file to HTML via the makefile:
  [03_knitWithoutRStudio][]

[01_justR]: https://github.com/STAT545-UBC/STAT545-UBC.github.io/tree/master/automation10_holding-area/01_automation-example_just-r
[02_rAndMake]: https://github.com/STAT545-UBC/STAT545-UBC.github.io/tree/master/automation10_holding-area/02_automation-example_r-and-make
[03_knitWithoutRStudio]: https://github.com/STAT545-UBC/STAT545-UBC.github.io/tree/master/automation10_holding-area/03_automation-example_render-without-rstudio

Please just tell me what to do
================================================================================

If you don't feel like dreaming up your own thing, here's a Gapminder blueprint that is a minimal but respectable way to complete the assignment. You are welcome to remix R code already written by someone, student or JB, in this class, but credit/link appropriately, e.g. in comments.

JB has provided a template, using a different dataset, [01_justR][], that should help make this concrete.

Download the data
------------------------------------------------------------

Download the raw data for our example, [lotr_raw.tsv][].

+ in an R script using [RCurl::getURL][] or [download.file][]
  note: `download.file` does not work with `https://`
  `followlocation` tells curl to follow the HTTP redirect used by bit.ly

    ```r
    cat(file = "lotr_raw.tsv",
      RCurl::getURL("http://bit.ly/lotr_raw-tsv", followlocation = TRUE))
    ```

+ in a shell script using `curl` or `wget`

    ```bash
    curl -L http://bit.ly/lotr_raw-tsv >lotr_raw.tsv
    wget http://bit.ly/lotr_raw-tsv -O lotr_raw.tsv
    ```

[lotr_raw.tsv]: https://gist.githubusercontent.com/sjackman/c10a5f7bcf6eebc1ba14/raw/b033c038605f9fdac855479714f65703be565b81/lotr_raw.tsv
[download.file]: http://stat.ethz.ch/R-manual/R-patched/library/utils/html/download.file.html
[RCurl::getURL]: http://www.omegahat.org/RCurl/

Perform exploratory analyses
------------------------------------------------------------

+ Import the data.
+ Save a couple descriptive plots to file with highly informative names.
+ Reorder the continents based on life expectancy. You decide the details.
+ Sort the actual data in a deliberate fashion. You decide the details, but this should *at least* implement your new continent ordering.
+ Write the Gapminder data to file(s), for immediate and future reuse.

Perform statistical analyses
------------------------------------------------------------

+ Import the data created in the first script.
+ Make sure your new continent order is still in force. You decide the details.
+ Fit a linear regression of life expectancy on year within each country. Write the estimated intercepts, slopes, and residual error variance (or sd) to file.
+ Find the 3 or 4 "worst" and "best" countries for each continent. You decide the details.
+ Write the linear regression info for just these countries to file.

Generate figures
------------------------------------------------------------

Create a single-page figure for each continent, including data only for the 6-8 "extreme" countries, and write to file. One file per continent, with an informative name. The figure should give scatterplots of life expectancy vs. year, panelling/faceting on country, fitted line overlaid.

Automate the pipeline
------------------------------------------------------------

Identify and test a method of running your pipeline non-interactively.

You could write a master R script that simply `source()`s the three scripts, one after the other. Tip: you will probably want a second "clean up / reset" script that deletes all the output your scripts leave behind, so you can easily test and refine your strategy, i.e. without repeatedly  deleting stuff "by hand". You can run the master script or the cleaning script from a shell with `R CMD BATCH` or `Rscript`.

> Dear Windows people: Recent versions of Windows have PowerShell, whose syntax resembles the Unix-type shells the Mac/Linux folks will have automatically. Try using that. See below for links to documentation on PowerShell and for help getting other software. Alternatively, install [msysGit][], which includes the command line *Git BASH*.

Provide a link to a page that explains how your pipeline works and links to the remaining files. The TAs should be able to go to this landing page and re-run your analysis quickly and easily. Consider including an image showing a graphical view of your pipeline.

[msysGit]: http://msysgit.github.io/

I want to aim higher!
================================================================================

Follow the basic Gapminder blueprint above, but find a different data aggregation task, different panelling/faceting emphasis, focus on different variables, etc.

Use non-Gapminder data.

This means you'll need to spend more time on data cleaning and sanity checking. You will probably have an entire script (or more!) devoted to data prep. Examples:

+ Are there wonky factors? Consider bringing in as character, addressing their deficiencies, then converting to factor.
+ Are there variables you're just willing to drop at this point? Do it!
+ Are there dates and times that need special handling? Do it!
+ Are there annoying observations that require very special handling or crap up your figures (e.g. Oceania)? Drop them!

Include some dynamic report generation in your pipeline. That is, create HTML from one or more plain R or R markdown files.

+ Example of how to emulate RStudio's "Compile Notebook" button from a shell:
  `Rscript -e "rmarkdown::render('myAwesomeScript.R')"`
  or using `knitr` instead of `rmarkdown`
  `Rscript -e "knitr::stitch_rmd('myAwesomeScript.R')"`
+ To emulate "Knit HTML", use `rmarkdown::render()` or knitr's `knitr::knit2html()`.
+ See [the Makefile in this example](03_knitWithoutRStudio/Makefile) to see these commands in action

Experiment with running R code saved in a script from within R Markdown. Here's some official documentation on [code externalization](http://yihui.name/knitr/demo/externalization/).

Embed pre-existing figures in and R Markdown document, i.e. an R script creates the figures, then the report incorporates them. General advice on writing figures to file is [here](http://www.stat.ubc.ca/~jenny/STAT545A/topic12_writeFigureToFile.html) and `ggplot2` has a purpose-built function `ggsave()` you should try. See an example of this in [an R Markdown file in one of the examples](https://github.com/jennybc/STAT545A_2013/blob/master/hw06_scaffolds/03_knitWithoutRStudio/03_doStuff.Rmd).

Import pre-existing data in an R Markdown document, then format nicely as a table.

Use Pandoc and/or LaTeX to explore new territory in document compilation. You could use Pandoc as an alternative to `rmarkdown` (or `knitr`) for Markdown to HTML conversion; you'd still use `rmarkdown` for conversion of R Markdown to Markdown. You would use LaTeX to get PDF output from R Markdown.

Use `Make` to run your pipeline. See below for help. Also demonstrated in the example [02_rAndMake][] and in the example [03_knitWithoutRStudio][]

Links
================================================================================

+ [An introduction to `Make`](http://kbroman.github.io/minimal_make/) by Karl Broman aimed at stats / data science types
+ Blog post [Using Make for reproducible scientific analyses](http://www.bendmorris.com/2013/09/using-make-for-reproducible-scientific.html) by Ben Morris
+ [Slides on `Make`](http://software-carpentry.org/v4/make/index.html) from Software Carpentry
+ Mike Bostock on [Why Use Make](http://bost.ocks.org/mike/make/)
+ Zachary M. Jones on [GNU Make for Reproducible Data Analysis](http://zmjones.com/make.html)

Authors
================================================================================

Written by [Shaun Jackman][] and [Jenny Bryan][].

This work is licensed under the [CC BY 3.0][] Creative Commons License.

[Shaun Jackman]: http://sjackman.ca/
[Jenny Bryan]: http://www.stat.ubc.ca/~jenny/
[CC BY 3.0]: http://creativecommons.org/licenses/by/3.0/
