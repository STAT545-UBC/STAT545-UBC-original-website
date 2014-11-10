---
title: "Write your own R package"
output:
  html_document:
    toc: true
    toc_depth: 2
---

*Temporary file holding links and stuff I might use 2014-11-10*

<http://www.stats.uwo.ca/faculty/murdoch/ism2013/5Vignettes.pdf>

Packages are a big deal

  * 13 base, 15 recommended packages
  * CRAN 5K (isn't over 6K now?)
  * Bioconductor, R-forge, Omegahat
  * not to mention GitHub!

What package for

  * make R objects available: data, functions
  * help pages documenting those objects
  * README and vignettes show how to combine goodies in the package to accomplish real stuff
  * optionally, external code
  * tests to make sure code works and stays that way as it evolves
 
library = directory where packages live on your computer

`library(foo)` loads the package foo from a library

  * now functions and data define by `foo` are available
  * you can access their official documentation
  * writing a package is about making that good stuff happen for YOUR functions and data

`.libPaths()` to see which libraries R knows about

`lapply(.libPaths(), dir)` to see what's in them

You can add libraries to this list to consult via `.Renviron` in case you want to separate those from outside world and your personal package(s)

What is a package? <http://r-pkgs.had.co.nz/r.html>

  * source, bundled, binary, installed, in memory

Build an analogy re: R scripts

  * I tell students to save source
  * students might resist if this means giving up interactivity
  * everyone wins with an IDE like RStudio, where develop and some application can be interactive, but script can be `source()`d or run via `Rscript` and/or `make` in "production"
  * the `devtools` package (and the integration features offered by RStudio) play exactly this role for R package development
  * someone tells me to write a package
  * I might resist if this means giving up my interactive development and informal testing/application workflow
  * everyone wins with a helper package like `devtools`
  * makes it easy to go into a world where it's as if your package has been built + installed + loaded AND still be tweaking the code

Other than making R functions and data available, other killer features of making a package

  * documentation
  * testing
  * R CMD check
  * distribution via CRAN or GitHub
  