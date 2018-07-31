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


### 2.1 DESCRIPTION file

Every R package has this. It contains the package's metadata. Let's edit it:

- Add a title and brief description. 
    - R is picky about these! Check out [the rules](http://r-pkgs.had.co.nz/description.html#pkg-description).
- Add your name.
    - Use the [`Authors@R` field](http://r-pkgs.had.co.nz/description.html#author) instead of the default `Author` and `Maintainer` fields. 
- Pick a [license](http://r-pkgs.had.co.nz/description.html#license).

### 2.2 Testing with `testthat`

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

## Wave 3: Higher-level User Documentation

### 3.1 Package Documentation

Just like we do for functions, we can make a manual (`.Rd`) page for our entire R package, too. For example, check out the documentation for `ggplot2`:

```
?ggplot2         # Can execute only if `ggplot2` is loaded.
package?ggplot2  # Always works.
```

To do so, just execute `devtools::use_package_doc()`. You'll see a new R script come up with `roxygen2`-style documentation to `NULL`. Document as you'd do functions, and run `roxygen2::roxygenise()` or `devtools::document()` to generate the `.Rd` file. 

Here's sample documentation:

```
#' Convenient Computation of Powers
#'
#' Are you tired of using the power operator, \code{^} or \code{**} in R?
#' Use this package to call functions that apply common powers
#' to your vectors.
#'
#' @name powers
#' @author Vincenzo Coia
#' @note This package isn't actually meant to be serious. It's just for
#' teaching purposes.
#' @docType package
```

### 3.2 Vignettes

It's a good idea to write a vignette (or several) for your R package to show how the package is useful as a whole. Documentation for individual functions don't suffice for this purpose!

To write a vignette called `"my_vignette"`, just run

```
devtools::use_vignette("my_vignette")
```

Some things happen automatically, but it's up to you to modify the `.Rmd` document to provide adequate instruction. Change the template to suit your package. The only real "catch" to doing this is _making sure the title is replaced in both instances_.

Then just `Knit`, and then run `devtools::build_vignettes()` to build the vignettes. 

__Note__: You'll have to remove `inst/doc` from your `.gitignore` file that gets created, if you want to push it to github. 

### 3.3 README

Just as most projects should have a `README` file in the main directory, so should an R package. 

__Purposes__:

- Inform someone stumbling across your project what they've stumbled across.
    - At a high level (like "This is an R package"), but also
    - somewhat at a lower level too, like your description file. This becomes a little redundant.
- I like to use the README to inform _developers_ the main workflow and spirit behind _developing_ the package.
    - There are some things that you'd want other potential developers to know about the package as a whole, yet are irrelevant to users!

__How to do it__:

You could just make and edit a `README.md` file like normal. But you'll probably want to briefly demonstrate some code, so you'll need an `.Rmd`. Let `devtools` set that up for you:

```
devtools::use_readme_rmd()
```

`knit` and you're done!

## Exercises

Create the above three types of documentation, without looking at [my version](https://github.com/vincenzocoia/powers). Then compare. 

Ideally, you'll have more to document because you've been working on expanding this (or another) R package for Homework 9 already.

## Wave 4

### 4.1 Dependencies

We can use functions from other R packages within our homemade R package, too. We need to do two things:

- Use the syntax `package_name::function_name()` whenever you want to use `function_name` from `package_name`. 
- Indicate that your R package depends on `package_name` in the DESCRIPTION file by executing the command `devtools::use_package("package_name")`.

There are other methods, but this is the easiest. 

__Example__: Add `ggplot2` dependency to plot the resulting computations. Do so by adding a plot to `pow` -- change `pow`'s guts to the following:

```
res <- x^a
p <- ggplot2::qplot(x, res)
print(p)
return(res)
```

__Note__: Here's an example of the benefits of not having your functions do too much -- I only needed to change `pow` alone to get the changes to work for `square` and `cube`. 

### 4.2 Adding data to your R package

You can store _and document_ datasets within R packages. Here's one useful way.

__Note__: This currently doesn't seem to be present in the companion tutorial from Jenny. Check out [the R Packages "data chapter"](http://r-pkgs.had.co.nz/data.html) for a resource.

In the console:

1. Store your data as R objects. Say you have two: `foo` and `bar`.
2. Execute `devtools::use_data(foo, bar)`. 

`foo` and `bar` will be saved as `.Rdata` files in the new `/data` directory. These are available upon loading the package. 

To document the data, for each object (i.e., for each of `foo` and `bar`), put `roxygen2`-style documentation above _the character_ `"foo"` and `"bar"` in an R script in the `/R` folder.

__Example__:

Add `tenvec` to the package:

```
tenvec <- 1:10
devtools::use_data(tenvec)
```

Then make a new R script in the `/R` folder containing:

```
#' Integer vector from 1 to 10
#'
#' Self-explanatory!
#'
#' @format This (and the next) is a new tag that applies for data documentation.
#' @source Note that you shouldn't use the `@export` tag when documenting data!
"tenvec"
```

### 4.3 Launching your Package to GitHub

If I want to put an R package on GitHub, I typically just:

1. Click "New" in GitHub to make a new repo. Don't initialize with README.
2. Follow the instructions github provides, which involves two lines to execute in the terminal.
    - Those two lines can be found [here](http://happygitwithr.com/existing-github-last.html#connect-to-github) in Jenny's Happy git book.
    
There is also the [`devtools::use_github()` way](http://stat545.com/packages06_foofactors-package.html#use_github()) -- although, to me, it seems overly complicated (perhaps there's an advantage I don't know about). It's just a matter of following the instructions, which are not worth demonstrating here. 

## Exercise

Some things you might find value in trying:

- Make, store, and document more data -- perhaps `negtenvec`, the negative of `tenvec`. 
- Give the user an option as to whether they want to display the plot or not (hint: do so via function arguments).
- Try launching your package on github. 
    - Please do make it public. R packages are meant to be viewed by the world! If it makes you feel more comfortable, put a disclaimer at the top of the README if you don't want people to take it seriously. 
