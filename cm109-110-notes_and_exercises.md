---
title: "cm109 and cm110 Notes and Exercises"
subtitle: "Write your own R package -- Lecture Version"
date: 'November 21 and 23, 2017'
output: 
    html_document:
        toc: true
---

## Introduction

This is a tutorial to get you started with package development in R, meant to accompany two lectures of STAT 547. It's similar (and somewhat based off of) [Jenny's tutorial](http://stat545.com/packages06_foofactors-package.html). Jenny's is more comprehensive, so is useful as a learning resource. This tutorial focusses more exclusively on the RStudio workflow to building packages.

Why make a package in R? Here are just a few big reasons:

- Built-in checks that your functions are working and are sensible.
- Easy way to store and load your data.
- Allows for documentation of functions that you've written. 

Think _aid for a type of analysis_, not an analysis itself. 

I'll try to break this up into "waves" of instruction, with work periods in between. Work on your Homework 9 if you're ahead!

## Wave 1: The bare minimum, plus bare minimum best practices

### 1.1 Bare minimum 

Follow along as we make an R package called `powers` that contains a function `square` that squares its input. Let's initiate it:

- RStudio —> New project —> R Package
    - Initiate git (optional, but recommended).
- Check out the files that have been created

Now, delete the `man` folder and R scripts (if present), and start a new R script in the `R` directory, called `square.R`. Write a function called `square` that squares its input.

Build the package:

* `Build and Reload`, or in newer versions of RStudio, `Install and Restart`.
    * This compiles the package, and loads it.
    * Try leaving the project, do `library(powers)`, and use the function! Pretty cool, eh?

### 1.2 Documentation 

Comment above functions with `#’`, and use tags starting with `@`. Here's documentation for the `square` function -- copy and paste it above the `square` function.


```r
#' Square a vector
#'
#' That's it -- this function just squares a vector.
#'
#' @param x The vector to be squared.
#'
#' @return A vector that is the square of \code{x}.
#'
#' @details
#' This function isn't complicated.
#'
#' And it almost certainly doesn't need two paragraphs in the "Details"
#' section!
#'
#' Here are some reasons why putting a list in this section is excessive:
#' \itemize{
#'      \item This \code{square} function is quite simple.
#'      \item There's nothing else to say about \code{square}.
#' }
#'
#' @examples
#' square(1:10)
#' square(-5)
#' @export
```


Note: now that we’re using `roxygen2` to document our package, we need to specify which functions we wish to make viewable by the user by indicating the `@export` tag, as above.

Type `roxygen2::roxygenize()` in the console, or more simply, `document()` from 
the `devtools` package. Then `Build and Reload`/`Install and Restart` the package.

Notable things that have happened:

* Your function is now documented. Check it out with `?square`!
    * This happens due to the creation of an `Rd` file in the `man` folder.
* Your NAMESPACE is populated. Contains all things you want the user to see.

### 1.3 Checking 

It's a good idea to `check` your package early and often to see that everything is working. 

Click `Check` under the `Build` menu. It checks lots of things for you! We'll see more examples of this. 

### 1.4 Function Dependencies

Make another, more general function to compute any power:


```r
pow <- function(x, a=2) x^a
```

It can go in the same R script as `square`, or a different one -- your choice.

We'll make `square` depend on `pow`. 

Aftering `Build and Reload`/`Install and Restart`ing, you'll notice that you can't use `pow` because it's not `export`ed. But, `square` still works! We call `pow` an _internal_ function. 

__Note__: you should still document your internal function! But mention that the function is internal. Users will be able to access the documentation like normal, but still won't be able to (easily) use the function.

If you want to be able to use internal functions as a developer, but don't want users to have (easy) access to the functions, then run `load_all` instead of `Build and Reload`/`Install and Restart`. 


## Exercise

Using at least two `.R` scripts:

- Make and document `pow`. Try out other `roxygen2` tags.
- Make and document another function, say `cube`, that raises a vector to the power of 3.

Make sure at least `square` and `cube` are exported to the NAMESPACE. Optionally, `pow`. Make sure you `Check` the package often!

Finished early? Do more -- work on Assignment 9, and/or try out more documentation features that comes with `roxygen2`.

## Wave 2: More documentation, and testing


### DESCRIPTION file

Every R package has this. It contains the package's metadata. Let's edit it:

- Add a title and brief description. 
    - R is picky about these! Check out [the rules](http://r-pkgs.had.co.nz/description.html#pkg-description).
- Add your name.
    - Use the [`Authors@R` field](http://r-pkgs.had.co.nz/description.html#author) instead of the default `Author` and `Maintainer` fields. 
- Pick a [license](http://r-pkgs.had.co.nz/description.html#license).

### Testing with `testthat`

We've already seen package `Check`s -- this checks that the pieces of your R package are in place, and that even your examples don't throw errors. We should not only check that our functions are _working_, but that they give us results that we'd _expect_.

The `testthat` package is useful for this. Initialize it in your R package by running `devtools::use_testthat()`.

As a template, save the following script in a file called `test_square`.

```
context("Squaring non-numerics")

test_that("At least numeric values work.", {
    num_vec <- c(0, -4.6, 3.4)
    expect_identical(square(numeric(0)), numeric(0))
    expect_identical(square(num_vec), num_vec^2)
})

test_that("Logicals automatically convert to numeric.", {
    logic_vec <- c(TRUE, TRUE, FALSE)
    expect_identical(square(logic_vec), logic_vec^2)
})
```

Then, you can execute those tests by running `devtools::test()`, or clicking `Build` -> `Test package`. 

These sanity checks are very important as your R package becomes more complex! 

## Exercise

- Edit your DESCRIPTION file. Make sure things run smoothly when you `Check` the R package. 
- Move the `numeric(0)` test to a new file, under a new context.
- Extend the tests to include your `cube` function.

Done early? Work on your Homework 9 R package. 
