---
output:
  html_document:
    toc: true
    toc_depth: 4
---

### cm003 2014-09-10 Wednesday overview

  * Elicit your name, GitHub username, Twitter handle (if you have) via an app (URL and username/password given in class)
  * Basics of R objects (TBC in future classes)
  * Just enough Git and Markdown knowledge for you to submit homework
    - Homework will be due before class Monday 2014-09-15. Not posted yet but will be creating a basic (R?) Markdown document and posting to GitHub.
  * What's next?
    - DATA!!
    - Exploring the Gapminder data
    - `data.frame`
    - `ggplot2`
    
#### Slides and links

Slides available on slideshare

*not yet*

Notes and and some links from the slides

*not yet*

#### For R novices

You did finish working through: [R basics, workspace and working directory, RStudio projects](block002_hello-r-workspace-wd-project.html), right?

  * Because I assume you've got a little script like [toy-line.r](https://github.com/STAT545-UBC/STAT545-UBC.github.io/blob/master/block002_toy-line.r) written by now. We've probably used it in class today.
  * That also contained helpful information on sending R code to the Console from the script editor. Important!
  
We will start to talk about R objects today

  * [The many flavors of R objects](block004_basic-r-objects.html)

#### For those familiar with R

Check out [swirl](http://swirlstats.com). Work through one or more interactive courses with the goal of writing a short review (include in homework?). Feeling more ambitious? Check out `swirlify` and [create a new lesson](http://swirlstats.com/instructors.html). I'd be happy to help think up topics.

#### Things we might need

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

Sample files I created originally for a [talk and mini workshop at SFU](https://github.com/jennybc/2013-11_sfu):

  * [Simple Markdown](https://github.com/jennybc/2013-11_sfu/blob/master/simple-markdown.md)
  * [Simple __R__ Markdown](https://github.com/jennybc/2013-11_sfu/blob/master/simple-r-markdown.rmd) and the associated [intermediate Markdown file](https://github.com/jennybc/2013-11_sfu/blob/master/simple-r-markdown.md)