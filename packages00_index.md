---
title: Write your own R package
output:
  html_document:
    toc: true
---

### Overview

Slides available on [speakerdeck](https://speakerdeck.com/jennybc/ubc-stat545-2015-writing-your-first-r-package)

<script async class="speakerdeck-embed" data-id="2f5adff04cb5013256c03a03dde42de4" data-ratio="1.33333333333333" src="//speakerdeck.com/assets/embed.js"></script> <div style="margin-bottom:5px"> <strong> <a href="https://speakerdeck.com/jennybc/ubc-stat545-2015-writing-your-first-r-package" title="UBC STAT545 2015 Writing your first R package" target="_blank">UBC STAT545 2015 Writing your first R package</a> </strong> from <strong><a href="https://speakerdeck.com/jennybc" target="_blank">Jennifer Bryan</a></strong> </div>

  * What is an R package?
  * What is a library?
  * Why make an R package?
  * Why `devtools` is integral to a happy workflow.

### Prepare your system for package development

[System prep and testing](packages01_system-prep.html)

Although we'll build a very simple package, we're still going to use the most modern and powerful tools for R package development. In theory, this could eventually involve compiling C/C++ code, which means you need what's called a "build environment." Follow the link above for help preparing your system.
  
### 2014 Hands-on activity

~~We build the `gameday` package to check if your favorite NHL team has a game today.~~

*In 2015, we will build a different package ... details coming soon.*

This fully developed example shows you

  * How to create a new R package
  * How to accept help from `devtools` and RStudio during development
  * Workflow for package development
  * How to document functions and your overall package
  * How to test the functions in your package
  * How to demonstrate your package's utility with a vignette
  * How to put your package on GitHub to share with the world

[2014 Day 1](packages02_activity.html) of hands-on work

[2014 Day 2](packages03_activity_part2.html) of hands-on work

[2014 Homework](hw10_package.html) that builds on the in-class work on `gameday`. [Hints](hw10_package_jenny-hints.html) on how to get started. [Peer review help](hw10_package_peer-review.html).

### Resources

[R packages](http://r-pkgs.had.co.nz) is a new book by Hadley Wickham.

Hilary Parker's [blog post](http://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/) on the epiphany of writing her first R package

  * "I was hit with that familiar feeling of the joy of optimization combined with the regret of past inefficiencies (joygret?). I wish I could go back in time and create the package the first moment I thought about it, and then use all the saved time to watch cat videos because that really would have been more productive."
  * the glorious result: <https://github.com/hilaryparker/cats>
  * see some usage in the [R Graph Catalog](http://shiny.stat.ubc.ca/r-graph-catalog/) *hint: filter for chapter "other"*

Some blog posts accompanying `devtools` releases highlight useful helper functions for package developers:

  * [v1.6 October 2014](http://blog.rstudio.org/2014/10/02/devtools-1-6/)
  * [v1.8 May 2015](http://blog.rstudio.org/2015/05/11/devtools-1-9-0/)
  * [v1.9.1 Septmber 2015](http://blog.rstudio.org/2015/09/13/devtools-1-9-1/)

Karl Broman's [guide to writing an R package](http://kbroman.org/pkg_primer/)

Karl Broman covers package development in his course [Tools for Reproducible Research](http://kbroman.org/Tools4RR/pages/schedule.html)

Jeff Leek's [guide to writing R packages](https://github.com/jtleek/rpackages)

[Building and Maintaining R Packages with devtools and roxygen2](http://thepoliticalmethodologist.com/2014/08/14/building-and-maintaining-r-packages-with-devtools-and-roxygen2/), blog post by Jacob Montgomery and Ryan T. Moore

[Writing Package Vignettes](http://www.stats.uwo.ca/faculty/murdoch/ism2013/5Vignettes.pdf), slides for a November 2013 talk by Duncan Murdoch

[Roxygen vignette on Generating Rd files](http://cran.r-project.org/web/packages/roxygen2/vignettes/rd.html)

[`testthat`: Get Started with Testing](http://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf), an article written by Hadley Wickham for *The R Journal,* Vol. 3/1, June 2011, pp. 5-10. *This may no longer be correct in every last detail, due to evolution of `testthat`, but it still makes an excellent, readable introduction to unit testing in R (packages)*.

[Writing R Extensions](http://cran.r-project.org/doc/manuals/r-release/R-exts.html), the One True Official Document on creating R packages

[How R Searches and Finds Stuff](http://obeautifulcode.com/R/How-R-Searches-And-Finds-Stuff/) is a fairly technical blog post for understanding the R search path, but also gives some great explanations on some differences between `Imports` vs `Depends` and why Depends is safer (added by daattali on 2015-01-01)
