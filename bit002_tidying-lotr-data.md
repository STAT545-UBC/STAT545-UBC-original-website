---
title: Data Carpentry lesson on tidy data
output:
  html_document:
    toc: true
    toc_depth: 4
---

This is a lesson on tidying data. Specifically, what to do when a conceptual variable is spread out over 2 or more variables in a data frame.

Data used: words spoken by characters of different races and gender in the Lord of the Rings movie trilogy

  * [directory of this lesson](https://github.com/datacarpentry/datacarpentry/tree/master/lessons/tidy-data) in the Data Carpentry GitHub repo
  * [01-intro](https://github.com/datacarpentry/datacarpentry/blob/master/lessons/tidy-data/01-intro.md) shows untidy and tidy data. Then we demonstrate how tidy data is more useful for analysis and visualization. Includes references, resources, and exercises.
  * [02-tidy](https://github.com/datacarpentry/datacarpentry/blob/master/lessons/tidy-data/02-tidy.md) shows __how__ to tidy data, using `gather()` from the `tidyr` package. Includes references, resources, and exercises.
  * [03-tidy-bonus-content](https://github.com/datacarpentry/datacarpentry/blob/master/lessons/tidy-data/03-tidy-bonus-content.md) is not part of the lesson but may be useful as learners try to apply the principles of tidy data in more general settings. Includes links to packages used.

Learner-facing dependencies:

  * files in the `tidy-data` sub-directory of the Data Carpentry `data` directory
  * `tidyr` package (only true dependency)
  * `ggplot2` is used for illustration but is not mission critical 
  * `dplyr` and `reshape2` are used in the bonus content

Instructor dependencies:

  * `curl` if you execute the code to grab the Lord of the Rings data used in examples from GitHub. Note that the files are also included in the `datacarpentry/data/tidy-data` directory, so data download is avoidable.
  * `rmarkdown`, `knitr`, and `xtable` if you want to compile the `Rmd` to `md` and `html`
