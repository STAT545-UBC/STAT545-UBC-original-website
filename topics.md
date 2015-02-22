## Topic list

  * [Install R and Rstudio](block000_r-rstudio-install.html)
  * [All the Git and GitHub (and RStudio) things](git00_index.html)
    - [Install Git](git01_git-install.html)
    - [Install a Git client](git02_git-clients.html) *optional but recommended*
    - [Tell RStudio where to find Git](git03_rstudio-meet-git.html)
    - [Introduce yourself to Git](git04_introduce-self-to-git.html)
    - [Test connection between RStudio and GitHub](git05_first-use-git-rstudio.html)
    - [GitHub credential caching](git06_credential-caching.html)
    - [STAT545 RStudio and GitHub workflow](git07_git-usage.html)
  * [Basic R and RStudio, workspace, working directory, RStudio Project](block002_hello-r-workspace-wd-project.html)
  * [Basic care and feeding of data in R](block006_care-feeding-data.html)
  * [R objects (beyond data.frames) and indexing](block004_basic-r-objects.html)
  * [Test drive R Markdown](block007_first-use-rmarkdown.html)
  * [All the graph things](graph00_index.html), an annotated index
    - R graphics landscape *[slides](http://www.slideshare.net/jenniferbryan5811/cm005-intro-ggplot2)*
    - [`ggplot2` tutorial](https://github.com/jennybc/ggplot2-tutorial), heavy on code and examples
    - [Do's and don'ts of making effective graphs](block015_graph-dos-donts.html)
    - [R Graph Catalog](http://shinyapps.stat.ubc.ca/r-graph-catalog/), a visual, clickable index of 100+ figures + `ggplot2` code to make them
    - [Using colors in R](block018_colors.html)
    - [Taking control of qualitative colors in `ggplot2`](block019_enforce-color-scheme.html)
    - [Secrets of a happy graphing life](block016_secrets-happy-graphing.html)
    - [Writing figures to file](block017_write-figure-to-file.html)
    - [Multiple plots on a page](block020_multiple-plots-on-a-page.html)
  * The `dplyr` package for data manipulation
    - [Introduction to dplyr](block009_dplyr-intro.html)
    - [`dplyr` functions for a single dataset](block010_dplyr-end-single-table.html)
    - [Cheatsheet](bit001_dplyr-cheatsheet.html) for `dplyr` join functions
  * Writing your own R functions
    - [Part 1](block011_write-your-own-function-01.html): get something that works, check arguments
    - [Part 2](block011_write-your-own-function-02.html): generalize, set default argument values
    - [Part 3](block011_write-your-own-function-03.html):`NA` handling, `...`, unit test
    - [Function-writing Practicum](block012_function-regress-lifeexp-on-year.html): fit a linear model and return estimated coefficients
  * The `plyr` package for split-apply-combine
    - Data aggregation overview [*slides*](http://www.slideshare.net/jenniferbryan5811/cm009-data-aggregation) 
    - [Using `plyr` with data.frames](block013_plyr-ddply.html)
  * [Be the boss of your factors](block014_factors.html)
  * Writing and reading files
    - [Indicative code from hands on activities](https://github.com/STAT545-UBC/STAT545-UBC.github.io/blob/master/cm011_files-out-in-script.r)
    - [2013 lesson](http://www.stat.ubc.ca/~jenny/STAT545A/block05_getNumbersOut.html) *2014 update: do data manipulation with `dplyr`*
  * [Why and how to tidy data](bit002_tidying-lotr-data.html)
  * [Regular expressions](block022_regular-expression.html) and more about character data
  * [All the automation things](automation00_index.html)
    - <a href="automation01_slides/index.html" target="_blank">slides</a>
    - [Special considerations for Windows](automation02_windows.html)
    - [Test drive `Make`](automation03_make-test-drive.html) from a shell and RStudio
    - [Hands-on activity](automation04_make-activity.html)
    - [Example pipelines](automation00_index.html#more-examples)
  * [All the package things](packages00_index.html)
    - [slides](https://speakerdeck.com/jennybc/ubc-stat545-2014-cm107-context-for-writing-your-first-r-package-week)
    - [System preparation for package development](packages01_system-prep.html)
    - [Hands-on activity, part 1](packages02_activity.html)
    - [Hands-on activity, part 2](packages02_activity_part2.html)
  * [All the Shiny things](shiny00_index.html)
    - [slides](shiny01_slides.pdf)
    - [Getting your system set up for Shiny](shiny02_setup.html)
    - [Hands-on activity-build a shiny app](shiny03_activity.html)
    - [Shiny and other interactive plotting links](shiny04_links.html)
  * Get data from the web
    - *make usual landing page and add bullet points*
    - class meeting [one](cm111_data-from-web.html) and [two](cm112_data-from-web.html)  

## Course-specific material

  * [Class meeting 001](cm001_course-intro-sw-install-account-signup.html) deals with "What is data science? What is data carpentry?" and includes links re: use of Twitter in academia.
  * [Class meeting 002](cm002_r-rstudio-intro.html) provides some Deep Thoughts about data analytic work, then shifts into a hands-on intro to R and RStudio.
  * [Class meeting 003](cm003_r-objects-git-toe-dip.html) Started basic flavors of R objects; Git(Hub) and (R) Markdown crash course so first homework can be submitted. All hands-on.
  * [Class meeting 004](cm004_care-feeding-data.html) Data.frames are awesome. Let's explore one (Gapminder).
  * [Class meeting 005](cm005_still-data-ggplot2-rmarkdown.html) Continue exploring data in a data.frame, maybe using `ggplot2` and in an R Markdown document
  * [Class meeting 006](cm006_q-and-a-more-ggplot2.html) Open Q and A on all content and course mechanics so far, complete introduction to `ggplot2`
  * [Class meeting 007](cm007_dplyr-intro.html) Introduction to `dplyr`
  * [Class meeting 008](cm008_write-function-day1.html) Writing your own R functions, beginning
  * [Class meeting 009](cm009_write-function-data-agg.html) Writing your own R functions, conclusion; data aggregation with `plyr`
  * [Class meeting 010](cm010_factors.html) Be the boss of your factors
  * [Class meeting 011](cm011_files-out-in.html) Writing to file, reading from file
  * [Class meeting 012](cm012_effective-graphs.html) Effective graphs
  * [Class meeting 101](cm101_practical-graph-tips.html) Practical graphing
  * [Class meeting 102](cm102_data-manipulation-finale.html) Tidy data
  * [Class meeting 103](cm103_regular-expressions.html) Regular expressions
  * [Class meeting 104](cm104_data-cleaning.html) Data cleaning
  * [Class meeting 105](cm105_pipelines.html) Automating Data-analysis Pipelines
  * [Class meeting 106](cm106_pipelines.html) More automating Data-analysis Pipelines
  * [Class meeting 107](cm107_packages.html) Writing an R package
  * [Class meeting 108](cm108_packages.html) More writing an R package
  * [Class meeting 109](cm109_shiny.html) Build a Shiny app
  * [Class meeting 110](cm110_shiny.html) More build a Shiny app
  * [Class meeting 111](cm111_data-from-web.html) Get data from the web via an API
  * [Class meeting 112](cm112_data-from-web.html) Get data from the web via an API and web scraping
  * [General homework guidelines](hw00_homework-guidelines.html)
  * [General homework rubric](peer-review01_marking-rubric.html) to apply in peer review
  * [Evaluation of peer review](peer-review02_peer-evaluation-guidelines.html)
  * [Homework 01](hw01_edit-README.html) Edit `README.md`
  * [Homework 02](hw02_explore-gapminder-use-rmarkdown.html) Explore Gapminder and use R markdown
  * [Homework 03](hw03_dplyr-and-more-ggplot2.html) Manipulate and summarize the Gapminder data with `dplyr`; make companion figs with `ggplot2`
  * [Homework 04](http://stat545-ubc.github.io/hw04_write-function-use-plyr.html) Manipulate and summarize the Gapminder data with custom functions and `plyr` 
  * [Homework 05](hw05_factor-boss-files-out-in.html) Prove you are in control of factors by writing and reading files
  * [Homework 06](hw06_repo-hygiene-figure-boss.html) *Optional, unmarked* activities for the STAT 545A / STAT 547M transition
  * [Homework 07](hw07_data-wrangling-grand-finale.html) Data wrangling Grand Finale
  * [Homework 08](hw08_data-cleaning.html) re: handling character data and data cleaning
  * [Homework 09](hw09_automation.html) Automating Data-analysis Pipelines
  * [Homework 10](hw10_package.html) Write an R package
  * [Homework 11](hw11_build-shiny-app) Build a Shiny app
  * [Homework 12](hw12_data-from-web) Get data from the web

## Short random things

  * [Lesson I contributed](bit002_tidying-lotr-data.html) to [Data Carpentry](http://software-carpentry.org/blog/2014/05/our-first-data-carpentry-workshop.html) on tidying data
  * [Cheatsheet](bit001_dplyr-cheatsheet.html) for `dplyr` join functions
  * [Store an API key as an environment variable](bit003_api-key-env-var.html)
  * [Workflow for sending email with R and `gmailr`](https://github.com/jennybc/send-email-with-r)
  * [Make browsing your GitHub repos more rewarding](bit006_github-browsability-wins.html)

## What's coming

Topics traditionally covered in STAT 545A, with light updating:

  * ~~Introduction to R and the [RStudio IDE](http://www.rstudio.com/products/rstudio/)~~ *done*
  * ~~R scripts and workspaces, RStudio Projects; how to get your work done~~ *done*
  * ~~Creating reports from R scripts and [R Markdown](http://rmarkdown.rstudio.com), using [`knitr`](http://yihui.name/knitr/)~~ *done*
  * ~~Deep thoughts about data analytic work~~ *done*
  * ~~Care and feeding of data in R; data frames~~ *done*
  * ~~R objects -- beyond data frames~~ *done*
  * ~~Indexing, subsetting~~ *done*
  * Data aggregation; "apply" functions, ~~[`plyr`](http://plyr.had.co.nz)~~, ~~[`dplyr`](https://github.com/hadley/dplyr)~~ *done*
  * ~~Making figures with `ggplot2` (was `lattice` in past)~~ *done*
  * ~~How to help yourself, how to ask questions to get useful answers~~ *done*
  * ~~How to get data in and out of R, staying as "open" as possible~~ *done*
  * ~~How to get figures out of R~~ *done*
  * ~~Be the boss of your factors, i.e. categorical variables~~ *done*
  * ~~Use of color in R~~ *done*
  * Single quantitative variable: visualizations and descriptive statistics
  * Two quantitative variables: visualizations and descriptive statistics
  * Categorical variables: visualizations and descriptive statistics
  * Multivariate visualizations
  * ~~Visualizing and summarizing data when "grouped"~~ *done*
  * Coding style and project organization
  
New topics for STAT 545A and/or STAT 547M will be selected from here:

  * Bash shell / unix basics, personal system administration.
  * ~~Version control with Git, collaboration via [GitHub](https://github.com)~~ *done*
  * ~~The tabular data mentality, "tidy" data, data reshaping~~ *done*
  * ~~Regular expressions, programmatic transformation and searching of character data~~ *done*
  * ~~Writing R functions~~ *done*
  * ~~Creating interactive pages, apps, and graphics via [Shiny](http://shiny.rstudio.com)~~ *done* and (maybe) [`ggvis`](http://ggvis.rstudio.com)
  * ~~Unit testing, at least as a mentality. Maybe will cover formal unit testing, e.g. `testthat`~~ *done*
  * Stats particularly useful in exploration (and often neglected in standard intro stats courses)
    - robust summary statistics
    - robust regression
    - smoothing
    - density estimation
    - cluster analysis, PCA, SVD, MDS
  * ~~Embrace the web:~~ *done*
    - ~~getting data from the web, e.g. using an API or via scraping~~
    - ~~exposing your hard work on the web (data, code, results)~~
  * ~~Distributing data and code to the world via an R package~~ *done*
  * ~~Automating an analytical pipeline, e.g. via `Make`.~~ *done*
