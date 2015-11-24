## Topic list

  * [Install R and Rstudio](block000_r-rstudio-install.html)
  * [All the Git and GitHub (and RStudio) things](git00_index.html)
    - [Install Git](git01_git-install.html)
    - [Install a Git client](git02_git-clients.html)
    - [Introduce yourself to Git](git04_introduce-self-to-git.html)
    - [GitHub, can you hear me?](git05_github-connection.html)
    - [Test connection between RStudio and GitHub](git07_git-github-rstudio.html)
    - [GitHub credential caching](git06_credential-caching.html)
    - [When RStudio can't find Git](git03_rstudio-meet-git.html)
    - [Take possession of your STAT 545 repo](git08_claim-stat545-repo.html)
    - [Troubleshooting](git66_rstudio-git-github-hell.html)
    - [The Shell](git09_shell.html)
  * [Basic R and RStudio, workspace, working directory, RStudio Project](block002_hello-r-workspace-wd-project.html)
  * [Basic care and feeding of data in R](block006_care-feeding-data.html)
  * [R objects (beyond data.frames) and indexing](block004_basic-r-objects.html)
  * [Test drive R Markdown](block007_first-use-rmarkdown.html)
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
  * The `dplyr` package for data manipulation
    - [Introduction to dplyr](block009_dplyr-intro.html)
    - [`dplyr` functions for a single dataset](block010_dplyr-end-single-table.html)
    - Overview of split-apply-combine: [slides on speakerdeck](https://speakerdeck.com/jennybc/ubc-stat545-split-apply-combine-intro)
    - [Split-apply-combine with `dplyr::do()`](block023_dplyr-do.html)
    - Example: [a wrapper around `lm` to use with `dplyr::do()`](block025_lm-poly.html)
    - [Cheatsheet](bit001_dplyr-cheatsheet.html) for `dplyr` join functions
    - Legacy material on [split-apply-combine with `plyr`](block013_plyr-ddply.html)
  * Writing your own R functions
    - [Part 1](block011_write-your-own-function-01.html): get something that works, check arguments
    - [Part 2](block011_write-your-own-function-02.html): generalize, set default argument values
    - [Part 3](block011_write-your-own-function-03.html):`NA` handling, `...`, unit test
    - [Function-writing Practicum](block012_function-regress-lifeexp-on-year.html): fit a linear model and return estimated coefficients
  * [Be the boss of your factors](block014_factors.html)
  * [Writing and reading files](block026_file-out-in.html)
  * [Why and how to tidy data](bit002_tidying-lotr-data.html)
  * Strings and Regular Expressions
    - [(2014) Intro to regular expressions](block022_regular-expression.html) and more about character data
    - [(2015) Regular expressions and character data in R](block027_regular-expressions.html): applying regex in R
  * [All the package things](packages00_index.html)
    - [slides](https://speakerdeck.com/jennybc/ubc-stat545-2015-writing-your-first-r-package)
    - [System preparation for package development](packages01_system-prep.html)
    - [2015 Hands-on activity, part 1](packages04_foofactors-package-01.html)
    - [2015 Hands-on activity, part 2](packages05_foofactors-package-02.html)
    - [2014 Hands-on activity, part 1](packages02_activity.html)
    - [2014 Hands-on activity, part 2](packages03_activity_part2.html)
  * [All the automation things](automation00_index.html)
    - <a href="automation01_slides/index.html" target="_blank">slides</a>
    - [Special considerations for Windows](automation02_windows.html)
    - [Test drive `Make`](automation03_make-test-drive.html) from a shell and RStudio
    - [Hands-on activity](automation04_make-activity.html)
    - [Example pipelines](automation00_index.html#more-examples)
  * Get data from the web *all still from 2014*
    - *make usual landing page and add bullet points*
    - class meeting [one](cm111_data-from-web.html) and [two](cm112_data-from-web.html) 
  * [All the Shiny things](shiny00_index.html) *all still from 2014*
    - [slides](shiny01_slides.pdf)
    - [Getting your system set up for Shiny](shiny02_setup.html)
    - [Hands-on activity-build a shiny app](shiny03_activity.html)
    - [Shiny and other interactive plotting links](shiny04_links.html)

## Homework

  * [Homework 01](hw01_edit-README.html) Edit `README.md`
  * [Homework 02](hw02_explore-gapminder-use-rmarkdown.html) Explore Gapminder and use R markdown
  * [Homework 03](hw03_dplyr-and-more-ggplot2.html) Manipulate, summarize, visualize Gapminder with `dplyr` and `ggplot2`
  * [Homework 04](hw04_write-function-split-apply-combine.html) Use split-apply-combine with your functions within data.frames 
  * [Homework 05](hw05_factor-figure-boss-repo-hygiene.html) Prove you are in control of factors and figures. Clean up your repo.
  * Homework 06 *did not exist; it's "clean up your repo" and was folded into homework 05*
  * [Homework 07](hw07_data-wrangling-candy.html) Clean and wrangle the `candy` survey
  * [Homework 08](hw08_package.html) Write an R package
  * 2014 [Homework 09](hw09_automation.html) Automating Data-analysis Pipelines
  * 2014 [Homework 11](hw11_build-shiny-app.html) Build a Shiny app
  * 2014 [Homework 12](hw12_data-from-web.html) Get data from the web

## Short random things

  * [Lesson I contributed](bit002_tidying-lotr-data.html) to [Data Carpentry](http://software-carpentry.org/blog/2014/05/our-first-data-carpentry-workshop.html) on tidying data
  * [Cheatsheet](bit001_dplyr-cheatsheet.html) for `dplyr` join functions
  * [Store an API key as an environment variable](bit003_api-key-env-var.html)
  * [Workflow for sending email with R and `gmailr`](https://github.com/jennybc/send-email-with-r)
  * [Make browsing your GitHub repos more rewarding](bit006_github-browsability-wins.html)
