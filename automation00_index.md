---
title: Automating data analysis pipelines
output:
  html_document:
    toc: true
    toc_depth: 4
---

Although we spend alot of time working with data interactively, this sort of hands-on babysitting is not always appropriate. We have a philosphy of "source is real" in this class and that philosophy can be implemented on a grander scale. Just as we save R code in a script so we can replay analytical steps, we can also record how a series of scripts and commands work together to produce a set of analytical results. This is what we mean by automating data analysis or building an analytical pipeline.

### Overview

[slides](automation01_slides/slides.html)

Why and how we automate data analyses + examples.

### Install `make`

[Windows installation](automation02_windows.html)

(If you are running Mac OS or Linux, `make` should already be installed.)
  
### Test drive `make` and RStudio

[Test drive of `make`](automation03_make-test-drive.html).

Walk before you run! Prove that `make` is actually installed and that it can be found and executed from the shell and from RStudio. It is also important to tell RStudio to NOT substitute spaces for tabs when editing a `Makefile` (applies to any text editor).

### Hands-on activity

[This fully developed example](automation04_make-activity.html) shows you

  * How to run an R script non-interactively
  * How to use `make`
    - to record which files are inputs vs. intermediates vs. outputs
    - to capture how scripts and commands convert inputs to outputs
    - to re-run parts of an analysis that are out-of-date
  * The intersection of R and `make`, i.e. how to
    - run snippets of R code
    - run an entire R script
    - render an R Markdown document (or R script)
  * The interface between RStudio and `make`
  * How to use `make` from the shell
  * How Git facilitates the process of building a pipeline

### Resources

[xkcd comic on automation](http://xkcd.com/1319/). 'Automating' comes from the roots 'auto-' meaning 'self-', and 'mating', meaning 'screwing'.

Karl Broman covers GNU Make in his course [Tools for Reproducible Research](http://kbroman.org/Tools4RR/pages/schedule.html) *(see first week)*

Karl Broman also wrote [An introduction to `Make`](http://kbroman.github.io/minimal_make/), aimed at stats / data science types
 
[Using Make for reproducible scientific analyses](http://www.bendmorris.com/2013/09/using-make-for-reproducible-scientific.html), blog post by Ben Morris

Software Carpentry's [Slides on `Make`](http://software-carpentry.org/v4/make/index.html)

Zachary M. Jones wrote [GNU Make for Reproducible Data Analysis](http://zmjones.com/make.html)

[Keeping tabs on your data analysis workflow](http://www.adamlaiacano.com/post/45356689519/keeping-tabs-on-your-data-analysis-workflow), blog post by Adam Laiacano, who works at Tumblr

Mike Bostock, of D3.js and New York Times fame, explains [Why Use Make](http://bost.ocks.org/mike/make/): "it's about the benefits of capturing workflows via a file-based dependency-tracking build system"

[Make for Data Scientists](http://bitaesthetics.com/posts/make-for-data-scientists.html), blog post by Paul Butler, who also made a [beautiful map of Facebook connections](https://www.facebook.com/notes/facebook-engineering/visualizing-friendships/469716398919) using R

Other, more modern data-oriented alternatives to `make`

  * [Drake](https://github.com/Factual/drake), a kind of "make for data"
  * [Nextflow](http://www.nextflow.io) for "data-driven computational pipelines"
  * [`maker`](https://github.com/richfitz/maker), "Make-like build management, reimagined for R"
  
[Managing Projects with GNU Make, Third Edition By Robert Mecklenburg](http://www.oreilly.com/openbook/make3/book/) is a fantastic book but, sadly, is very focused on compiling software

Rstudio's [website documenting R Markdown](http://rmarkdown.rstudio.com) is generated from [this repo](https://github.com/rstudio/rmarkdown/tree/gh-pages) using [this 20 line Makefile](https://github.com/rstudio/rmarkdown/blob/gh-pages/Makefile), which is sort of amazing. This is why we study regular expressions and follow filename conventions, people!

[littler](http://dirk.eddelbuettel.com/code/littler.html) is an R package maintained by Dirk Eddelbuettel that "provides the `r` program, a simplified command-line interface for GNU R."