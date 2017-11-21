---
title: "Building your own R package"
output:
  html_document:
    toc: true
    toc_depth: 3
---

### What we have already done

In class we developed a package and showed how to

  * set up the directory structure for a package and put it under version control with `File` -> `New Project`
  * define functions in R scripts located in the `R` directory of the package
  * use `load_all` and `Build & Reload` to simulate loading the package
  * use `Check` to check the package for coherence
  * use `Build & Reload` to properly build and install the package
  * edit the `DESCRIPTION` file of package metadata
  * specify a LICENSE
  * document and export the functions via `roxygen2` comments
  * document the package itself via `use_package()`
  * create documentation and manage the `NAMESPACE` file via `document()`
  * use `testthat` to implement unit testing
  * use a function from another package via `use_package()` and syntax like `otherpkg::foofunction()`
  * connect your local Git repo to a new remote on GitHub via `use_github()`
  * create a `README.md` that comes from rendering `README.Rmd` containing actual usage, via `use_readme_rmd()`
  * create a vignette via `use_vignette()` and build it via `build_vignettes()`

Consult the repository for an example repository that you can start with, where all of the above has been done. You are especially encouraged to walk through the commit history and scrutinize the diffs, noticing which files change at each point. You can fork it or use the Download ZIP button to get this as your starting point. Jenny Bryan has written instructions for both, regarding the `foofactors` package, located [here](hw09_package_onramp-peer-review.html).
  
Remember the [landing page for all the package material](packages00_index.html) also contains lots of [links](packages00_index.html#resources) with extra technical information and general inspiration.

### Your mission

In this homework you will either continue developing the [`powers`](https://github.com/vincenzocoia/powers) package developed in class or Jenny's [`foofactors`](https://github.com/jennybc/foofactors) package; or create your own package. If you do the latter, you must hit all the same points but you'll be starting from scratch.

Aim for the following elements:

  * Define and export at least one new function, i.e. make it available to a user. We'd prefer more than one. Feel free to improve (or delete) the functions we already have.
  * Give function arguments sensible defaults, where relevant.
  * Use assertions to add some validity checks of function input.
  * Document all exported functions.
  * Include at least three unit tests for every function that is exported.
    - There should be at least one expectation for success and one for failure.
  * Your package should pass `check()` without errors (warnings and notes are OK, though it would be great if there were none).
  * Keep updating the README and vignette to show usage of all the functions in the package. Your peer reviewers and TA will only have the README and vignette to go on when they try to use your package. Show them exactly what they can do! Remove boilerplate content from the vignette.
  * Push your package to GitHub, preferably a public repo. *If you are uncomfortable with that, please contact an instructor and we'll work around that.*
  * Write your reflections in a document in your normal STAT 545/547 course repo and open the usual issue there. Make sure to provide a link to your package, so TAs/prof/peers can find it for review!

Ideas for more `foofactor` functions to write:

  - detect factors that should be character because # unique values = length
  - write a version of reorder() that uses `desc()` a la `(d)plyr`
  - write a version of `factor()` that sets levels to the order in which they appear in the data, i.e. set the levels "as is"
  - functions to write and read data frames to plain text delimited files while retaining factor levels; maybe by writing/reading a companion file?

A general idea for advanced R packages is to develop an S3 Object Oriented (OO) R package (see [this reference](http://adv-r.had.co.nz/OO-essentials.html)). Be warned, though, that this may be a time sink, so is only for the super-eager (you can still get check-plus if you don't do this).

### Due date

Submit an issue with a link to your package sometime by the end of November 28, 2017.

## Rubric

Instructions on how to install a peer's package from GitHub are given by Jenny Bryan for the `foofactors` package [here](hw09_package_onramp-peer-review.html), but extend to other packages. Use the `README.md` and the vignette to figure out what the package does and how to use it.

Check minus: Package does not install. Or installation seemed go OK but one or more of the functions don't work. Or you do something that seems totally natural (probably copied from `README.md` or vignette) and get odd behavior.

Check: Hits most/all the elements. No obvious technical difficulties. Package pleasant to use. `README.md` and vignette are pleasant to read and provide accessible examples of usage. No heroic detective work required. Good work!

Check plus: Exceeded the requirements in number of dimensions. Took `foofactors` or `powers` farther than was required. Wrote a new package from scratch. Experience of installation and usage was dreamy because of excellent documentation and high functionality. You learned something new from reviewing their work and you’re eager to incorporate it into your work. Wow!

Recall the [general homework rubric](http://stat545-ubc.github.io/peer-review01_marking-rubric.html).

## Peer Review

...will be posted here when it's ready!