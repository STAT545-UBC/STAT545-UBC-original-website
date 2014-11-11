---
title: Prepare your system for package development
output:
  html_document:
    toc: true
    toc_depth: 4
---

*warning: under development!*

Although we'll build a very simple package, we're still going to use the most modern and powerful tools for R package development. In theory, this could eventually involve compiling C/C++ code, which means you need what's called a "build environment."

Update R. *Bernhard is running R version 3.1.2.*

Update RStudio, possible even to the preview version. *Bernhard is running RStudio 0.98.1056*.

Install the following packages. If you already have them, update them. *versions reflect Bernhard's system*

  * devtools 1.6.1
  * roxygen2 4.0.2
  * testthat 0.9.1
  * knitr 1.7

Run `packageVersion("devtools")` to check your version of the above packages. Use `install.packages("devtools", dependencies=TRUE)` to install missing packages (check for non-zero exit status), or run `update.packages(ask=FALSE)` to get the latest version.

@jennbc to do: add the stuff I said/did about updating packages here.