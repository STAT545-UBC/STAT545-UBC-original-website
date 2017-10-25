## Topic list

This material gets updated during Sept - Nov each year on a rolling basis.

  * Get your R act together
    - [Install R and Rstudio](block000_r-rstudio-install.html) (or update! get current!)
    - [Basic R and RStudio, workspace, working directory, RStudio Project](block002_hello-r-workspace-wd-project.html)
    - [Test drive R Markdown](block007_first-use-rmarkdown.html)
  * [Git, GitHub, and RStudio](http://happygitwithr.com)
    - Content now here: <http://happygitwithr.com>. Install Git, install a Git client or GUI, establish pull/push connection from computer to GitHub in the shell, establish GitHub connection via RStudio, credential caching, troubleshooting.
    - [Take possession of your STAT 545 repo](git08_claim-stat545-repo.html)
  * Data analysis 1: data frames, the tidyverse, and tibbles
    - [Basic care and feeding of data in R](block006_care-feeding-data.html): data frames (and tibbles) are awesome.
    - [Introduction to dplyr](block009_dplyr-intro.html): filter, select, the pipe.
    - [dplyr functions for a single dataset](block010_dplyr-end-single-table.html): single table verbs.
    - [Tidy data using Lord of the Rings](https://github.com/jennybc/lotr-tidy#readme): tidy data, tidyr.
    - Join (a.k.a. merge) two tables: [dplyr join cheatsheet](bit001_dplyr-cheatsheet.html) with comic characters and publishers
    - [Table look up](bit008_lookup.html)
    - [Split-Apply-Combine](block024_group-nest-split-map.html) with the tidyverse (nesting, list-columns, map inside mutate) *under development*.
  * Data analysis 2: vectors and files
    - [Be the boss of your factors](block029_factors.html) *under redevelopment, in light of forcats*
    - [Character vectors](block028_character-data.html): basic manipulation and regular expressions.
    - [Character encoding](block032_character-encoding.html)
    - [Writing and reading files](block026_file-out-in.html)
  * R as a programming language
    - [R objects (beyond data.frames) and indexing](block004_basic-r-objects.html)
    - Writing your own R functions [Part 1](block011_write-your-own-function-01.html): get something that works, check arguments
    - Writing your own R functions [Part 2](block011_write-your-own-function-02.html): generalize, set default argument values
    - Writing your own R functions [Part 3](block011_write-your-own-function-03.html):`NA` handling, `...`, unit test
    - [Function-writing Practicum](block012_function-regress-lifeexp-on-year.html): fit a linear model and return estimated coefficients
  * [All the graph things](graph00_index.html)
    - R graphics landscape *[slides](https://speakerdeck.com/jennybc/ggplot2-tutorial)*
    - [`ggplot2` tutorial](https://github.com/jennybc/ggplot2-tutorial), heavy on code and examples
    - [Do's and don'ts of making effective graphs](block015_graph-dos-donts.html)
    - [R Graph Catalog](http://shiny.stat.ubc.ca/r-graph-catalog/), a visual, clickable index of 100+ figures + `ggplot2` code to make them
    - [Using colors in R](block018_colors.html)
    - [Taking control of qualitative colors in `ggplot2`](block019_enforce-color-scheme.html)
    - [Secrets of a happy graphing life](block016_secrets-happy-graphing.html)
    - [Writing figures to file](block017_write-figure-to-file.html)
    - [Multiple plots on a page](block020_multiple-plots-on-a-page.html)
  * [All the package things](packages00_index.html)
    - [slides](https://speakerdeck.com/jennybc/ubc-stat545-2015-writing-your-first-r-package)
    - [System preparation for package development](packages01_system-prep.html)
    - [Write your own R package](packages06_foofactors-package.html)
  * [All the automation things](automation00_index.html)
    - <a href="automation01_slides/index.html" target="_blank">slides</a>
    - [Special considerations for Windows](automation02_windows.html)
    - [Test drive `Make`](automation03_make-test-drive.html) from a shell and RStudio
    - [Hands-on activity](automation04_make-activity.html)
    - [Example pipelines](automation00_index.html#more-examples)
  * Get data from the web
    - [Slides](webdata01_slides.html)
    - Lesson 1: [Use API-wrapping packages](webdata02_activity.html)
    - Lesson 2: [DIY web data](webdata03_activity.html)
  * [All the Shiny things](shiny00_index.html)
    - [Slides on Google Docs](https://docs.google.com/presentation/d/1dXhqqsD7dPOOdcC5Y7RW--dEU7UfU52qlb0YD3kKeLw/edit?usp=sharing)
    - [Shiny tutorial with hands-on activity to build app with BC Liquor Store dataset](shiny01_activity.html)
  * Deprecated material that I no longer use. But last I checked, it's not actually *wrong*.
      - Overview of split-apply-combine: [slides on speakerdeck](https://speakerdeck.com/jennybc/ubc-stat545-split-apply-combine-intro)
    - [Split-apply-combine with `dplyr::do()`](block023_dplyr-do.html)
    - Example: [a wrapper around `lm` to use with `dplyr::do()`](block025_lm-poly.html)
    - [Split-apply-combine with `plyr`](block013_plyr-ddply.html)
    - [Why and how to tidy data](bit002_tidying-lotr-data.html)
    - Be the boss of your factors: [2015 version](block014_factors.html), pre-forcats
    - [2014 Write an R package, hands-on activity, part 1](packages02_activity.html)
    - [2014 Write an R package, hands-on activity, part 2](packages03_activity_part2.html)

## Short random things

  * [Draw the rest of the owl](bit007_draw-the-rest-of-the-owl.html), a pep talk for building off simple examples
  * [Using `dplyr` + `purrr` + `tidyr`](https://github.com/jennybc/analyze-github-stuff-with-r) to analyze data about GitHub repos via the [`gh` package](https://github.com/gaborcsardi/gh)
  * [Using `dplyr` + `purrr` + `tidyr` + `xml2`](https://github.com/jennybc/manipulate-xml-with-purrr-dplyr-tidyr) to tame the annoying XML from Google Sheets
  * [Make browsing your GitHub repos more rewarding](bit006_github-browsability-wins.html)
  * [Cheatsheet](bit001_dplyr-cheatsheet.html) for `dplyr` join functions
  * [Workflow for sending email with R and `gmailr`](https://github.com/jennybc/send-email-with-r)
  * [Store an API key as an environment variable](bit003_api-key-env-var.html)
  * [Lesson I contributed](bit002_tidying-lotr-data.html) to [Data Carpentry](http://software-carpentry.org/blog/2014/05/our-first-data-carpentry-workshop.html) on tidying data

