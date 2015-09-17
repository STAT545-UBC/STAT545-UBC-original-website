---
output:
  html_document:
    toc: true
    toc_depth: 4
---

### cm003 2015-09-15 Tuesday overview

  * Please take this survey (yes of course it's a Shiny app!):
    - <http://shiny.stat.ubc.ca/STAT545/stat545-basic-info/>
    - this is how we get your GitHub username, match you against the course list, and give you a private course repository within the [STAT 545 Organization](https://github.com/STAT545-UBC)
    - username and password for survey given in class
  * Hands-on work
    - run a `.R` script or an `.Rmd` document, while also converting it to `.html`
    - continued work installing and configuring Git + GitHub + RStudio
    - go to the [landing page for links](git00_index.html)
    - continued encouragement to learn [RStudio keyboard shortcuts](https://support.rstudio.com/hc/en-us/articles/200711853-Keyboard-Shortcuts) ... lots of "wait, how are you doing that so fast?"
  * What's coming?
    - DATA!!
    - Exploring the Gapminder data
    - `data.frame`
    - `ggplot2`
    
#### Slides and links

There were no slides

#### For R novices

You did finish working through: [R basics, workspace and working directory, RStudio projects](block002_hello-r-workspace-wd-project.html), right?

  * Because I assume you've got a little script like [toy-line.r](https://github.com/STAT545-UBC/STAT545-UBC.github.io/blob/master/block002_toy-line.r) written by now. We've probably used it in class today.
  * That also contained helpful information on sending R code to the Console from the script editor. Important!
  
#### For those familiar with R

Check out [swirl](http://swirlstats.com). Work through one or more interactive courses with the goal of writing a short review (include in homework?). Feeling more ambitious? Check out `swirlify` and [create a new lesson](http://swirlstats.com/instructors.html). I'd be happy to help think up topics.

#### Things we might need

*We did not need these (demos were more basic), but I'll leave this here anyway.*

Parking these snippets here in case needed during class:

Example YAML frontmatter to cause intermediate Markdown to be saved when rendering an R Markdown document:

```yaml
---
title: "Something fascinating"
author: "Jenny Bryan"
date: "10 September, 2014"
output:
  html_document:
    keep_md: TRUE
---
```

Example YAML frontmatter to cause intermediate Markdown to be saved when rendering an R script (the same stuff but with `#'` at the beginning of each line:

```yaml
#' ---
#' title: "Something fascinating"
#' author: "Jenny Bryan"
#' date: "10 September, 2014"
#' output:
#'   html_document:
#'     keep_md: TRUE
#' ---
```
