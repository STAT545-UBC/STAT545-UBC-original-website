---
title: Automation
output:
  html_document:
    toc: true
    toc_depth: 4
---

Running R scripts at arm's length vs. interactively.

Using `Make` to record which files are inputs vs. outputs and how to use scripts and commands to make the outputs from the inputs. 

The intersection of R and `Make`: running R code snippets, running an entire R script, and rendering an R Markdown document.

The intersection of RStudio and `Make`: running the most important `Make` rules from the Build tab.

Using `Make` in the shell.

Check out the slides!

### Installation

  * Mac and Linux folks are already set
  * Link to page on Windows installation
    - installing Make
    - issue about Make on PATH
    - issue about which shell Make is using
  
### Test drive

  * Prove `Make` is working from the shell and RStudio
    - Bring the dummy Makefile forward out of activity with the echo commands

### TAB gotcha

  * definitive coverage here, link back here from other places

### Hands-on activity

  * Separate page
    - dependency graph of the pipeline
    - new RStudio project and Git repo
    - rule to copy and/or download words.txt
    - R script to compute table of word lengths
    - rule to run word length script
    - ?create all and clean targets at this point and play with them?
    - R snippet to create visual histogram
    - rule to create histogram
    - update all and clean targets; use them
    - R Markdown file to generate a report
    - rule to render the Markdown file
    - update all and clean targets; use them

### Resources

links!