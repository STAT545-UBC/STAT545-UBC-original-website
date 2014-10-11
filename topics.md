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
  * [Introduction to `ggplot2`](https://github.com/jennybc/ggplot2-tutorial) *links to materials from a May 2014 workshop*
  * [Test drive R Markdown](block007_first-use-rmarkdown.html)
  * The `dplyr` package for data manipulation
    - [Introduction to dplyr](block009_dplyr-intro.html)
    - [`dplyr` functions for a single dataset](block010_dplyr-end-single-table.html)
  * Writing your own R functions
    - [Part 1](block011_write-your-own-function-01.html): get something that works, check arguments
    - [Part 2](block011_write-your-own-function-02.html): generalize, set default argument values
    - [Part 3](block011_write-your-own-function-03.html):`NA` handling, `...`, unit test
    - [Function-writing Practicum](block012_function-regress-lifeexp-on-year.html): fit a linear model and return estimated coefficients
  * [Using `plyr` for data.frames](block013_plyr-ddply.html)
  * [Be the boss of your factors](block014_factors.html)
  * Writing and reading files
    - [Indicative code from hands on activities](https://github.com/STAT545-UBC/STAT545-UBC.github.io/blob/master/cm011_files-out-in-script.r)
    - [2013 lesson](http://www.stat.ubc.ca/~jenny/STAT545A/block05_getNumbersOut.html) *2014 update will data manipulation with `dplyr`*
  
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
  * [General homework guidelines](hw00_homework-guidelines.html)
  * [General homework rubric](peer-review01_marking-rubric.html) to apply in peer review
  * [Evaluation of peer review](peer-review02_peer-evaluation-guidelines.html)
  * [Homework 01](hw01_edit-README.html) Edit `README.md`
  * [Homework 02](hw02_explore-gapminder-use-rmarkdown.html) Explore Gapminder and use R markdown
  * [Homework 03](hw03_dplyr-and-more-ggplot2.html) Manipulate and summarize the Gapminder data with `dplyr`; make companion figs with `ggplot2`
  * [Homework 04](http://stat545-ubc.github.io/hw04_write-function-use-plyr.html) Manipulate and summarize the Gapminder data with custom functions and `plyr` 
  * [Homework 05](hw05_factor-boss-files-out-in.html) Prove you are in control of factors by writing and reading files

## Short random things

  * [Lesson I contributed](bit002_tidying-lotr-data.html) to [Data Carpentry](http://software-carpentry.org/blog/2014/05/our-first-data-carpentry-workshop.html) on tidying data
  * [Cheatsheet](bit001_dplyr-cheatsheet.html) for `dplyr` join functions

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
  * How to help yourself, how to ask questions to get useful answers
  * ~~How to get data in and out of R, staying as "open" as possible~~ *done*
  * How to get figures out of R
  * ~~Be the boss of your factors, i.e. categorical variables~~ *done*
  * Use of color in R
  * Single quantitative variable: visualizations and descriptive statistics
  * Two quantitative variables: visualizations and descriptive statistics
  * Categorical variables: visualizations and descriptive statistics
  * Multivariate visualizations
  * Visualizing and ~~summarizing data when "grouped"~~
  * Coding style and project organization
  
New topics for STAT 545A and/or STAT 547M will be selected from here:

  * Bash shell / unix basics, personal system administration.
  * ~~Version control with Git, collaboration via [GitHub](https://github.com)~~ *done*
  * The tabular data mentality, "tidy" data, data reshaping
  * Regular expressions, programmatic transformation and searching of character data
  * ~~Writing R functions~~ *done*
  * Creating interactive pages, apps, and graphics via [Shiny](http://shiny.rstudio.com) and (maybe) [`ggvis`](http://ggvis.rstudio.com)
  * ~~Unit testing, at least as a mentality. Maybe will cover formal unit testing, e.g. `testthat`~~ *done*
  * Stats particularly useful in exploration (and often neglected in standard intro stats courses)
    - robust summary statistics
    - robust regression
    - smoothing
    - density estimation
    - cluster analysis, PCA, SVD, MDS
  * Embrace the web:
    - getting data from the web, e.g. using an API or via scraping
    - exposing your hard work on the web (data, code, results)
  * Distributing data and code to the world via an R package
  * Automating an analytical pipeline, e.g. via `Make`.
  