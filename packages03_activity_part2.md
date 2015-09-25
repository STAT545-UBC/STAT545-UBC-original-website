---
title: "Write your own R package, part 2"
author: "Bernhard Konrad"
date: ""
output:
  html_document:
    toc: true
    pandoc_args: "--preserve-tabs"
---

Where we left off after [part 1](packages02_activity.html):

+ Initialized `gameday` package with `devtools::create()`
+ Modified `DESCRIPTION`
+ Added `gday.R` function to the `gameday` package. It checks if your NHL team plays today
+ Added `roxygen2`-style documentation to `gday()`
+ Built package in RStudio with *Build & Reload* from the *Build* tab
+ What works now:
    * `library("gameday")` loads our package
    * `gday("canucks")` tells us if the *Vancouver Canucks* have a game today
    * `?gday` displays the help file we wrote

What we do next:

+ Create help file for the `gameday` package, which is displayed by `?gameday`.
+ Add a vignette.
+ Publish `gameday` on GitHub.
+ Add tests with `testthat`.
+ Show interactive *fix & test* workflow when we modify `gday()` and tests.

### Documentation for the package itself

We've already documented the `gday()` function. Next, let's add documentation of the `gameday` package itself (what you would see with `?gameday`). For that, create a new R script and save it as `R/gameday.r`. The content should be something like

```r
#' My first R package: gameday
#' 
#' A one-line sentence on what this packages does
#' 
#' Single paragraph with more detail on the package.
#' This can span several lines.
#' 
#' @docType package
#' @name gameday
NULL
```

+ `\@docType package` specifies that we document the package itself (instead of a function)
+ We don't have any R code to document, but `roxygen2` needs some R code here. Hence the convention is to put the dummy code `NULL`.

### Vignette

Vignettes allow you to give a broader overview of your package, and show new users what it can be used for and how to use it. Vignettes tell the story of your package. The good news is that, as of *R 3.0.0* you can use Rmarkdown to write your vignettes (previously LaTeX was required). It gets better: `devtools` provides a template for your vignette, to make the process of writing this user-friendly guide as easy as possible:

+ In your package, call `library(devtools)` and then `use_vignette("overview")`. This creates `vignettes/overview.Rmd` and adds

```sh
Suggests: knitr
VignetteBuilder: knitr
```

to your `DESCRIPTION` file.

+ Open `vignettes/overview.Rmd` and check the YAML:

        ---
        title: "Vignette Title"
        author: "Vignette Author"
        date: "`r Sys.Date()`"
        output: rmarkdown::html_vignette
        vignette: >
          %\VignetteIndexEntry{Vignette Title}
          %\VignetteEngine{knitr::rmarkdown}
          \usepackage[utf8]{inputenc}
        ---
        
    * Please edit the `title` and `author`, as well as the `Vignette Title`. Don't be confused about *vignette: >*, this just means that the following LaTeX lines are read as-is instead of being interpreted as YAML. After your changes, `vignettes/overview.Rmd` YAML should look similar to this:
    
        ---
        title: "Gameday Overview"
        author: "Bernhard Konrad"
        date: "`r Sys.Date()`"
        output: rmarkdown::html_vignette
        vignette: >
          %\VignetteIndexEntry{Gameday Overview}
          %\VignetteEngine{knitr::rmarkdown}
          %\usepackage[utf8]{inputenc}
        ---

* Now we can add the actual Rmarkdown of our vignette. This should show realistic usage -- something beyond the scope of the typical examples in a help file. In packages that are more sophisticated than `gameday`, it's fair to say that a vignette is where you show how to combine several functions from your package to accomplish something interesting to your audience. 
* Once you have your vignette in an acceptable state it is time to turn the Rmarkdown source into the vignette as the R package expects it. Since vignettes may take a long time to compile, this is **not** automatically done by *Build & Reload*. Instead, use `devtools::build_vignettes()`. This puts all required files in the folder `inst/doc`.
* You can now *Build & Reload* your package, it will also make the vignette available. To view it, simply use `browseVignettes(package = "gameday")`.

### Publish on GitHub

#### Commit locally

First we have to commit all our files to our local git repository, assuming you haven't been doing so all along. If you don't have a *Git* tab in RStudio, go to *Tools > Version Control > Project Setup* and choose *Git*. This will restart RStudio. Then, go to the *Git* tab, check all files and folders, click *commit*, add a *commit message* (eg "my first version of my first R package") and *commit*.

#### Create new, empty GitHub repository

We will now make our package publicly available on GitHub. If we want others to see and use our work we have to make this repository public.

1. Go to `github.com` and click on your username (should be on the top right).
2. Choose *Repositories -> New*
3. The repository name is *gameday*. You can leave *Description* empty. Choose **Public** and **do NOT initialize with a README**.
4. Copy the address of the repository. For me this is `https://github.com/BernhardKonrad/gameday`.

#### Connect local repo to GitHub repo

We have to inform our local Git repository about its companion on GitHub. In Git vocabulary, we need to *add a remote*. For this, we have to go back to the *[shell](git09_shell.html)*:

1. *Tools > Shell...*.
2. We will add the GitHub repository as a remote, using the traditional nickname `origin`: `git remote add origin https://github.com/BernhardKonrad/gameday`.
3. Push your local work, on branch `master` to the new `origin` remote and set this remote as the new default: `git push -u origin master`.
4. Close the [shell](git09_shell.html), you will now be able to push and pull directly from RStudio.
5. Your package is now publicly (and freely, remember the License) available to the world.
6. It gets better: You can actually install your package from GitHub directly:

        
        library(devtools)
        install_github("BernhardKonrad/gameday")
        

### Tests

We all feel that we should be testing our code. In fact, most of us are, but not in an effective and efficient way:

> It's not that we don't test our code, it's that we don't store our tests so they can be re-run automatically. (Hadley Wickham)

We are used to inspecting our code interactively and smell-testing our data. Formal testing, however, is regarded as very advanced and *"not worth it"* for the daily work. Turns out, a simple test suit like [`testthat`](http://vita.had.co.nz/papers/testthat.html) doesn't only make testing very easy, but will also make you spend less time fixing bugs and more time writing code.

We will use `testthat` to add tests to our package. It's syntax is designed to be very close to english:

    # save as test_me.R
    test_that("case is ignored", {
    expect_equal(gday("canucks"), gday("CANUCKS"))
    })

+ Save the script above as `test_me.R`.
+ The first argument is a string that explains what we are testing for. It completes the sentence *"Test that..."*
+ The second argument is a (list of) test(s), that is, a check that has to be satisfied. Above we use `expect_equal()`, to check that `gday("canucks")` and `gday("CANUCKS")` return the same thing.
+ There are more test helper functions in `testthat`:
    * `expect_true(x)`
    * `expect_false(x)`
    * `expect_is(x, y)` Is `x` of class `y`?
    * `expect_equal(x, y)`
    * `expect_equivalent(x, y)`
    * `expect_identical(x, y)`
    * `expect_match(x, y)` Match character vector `x` against regular expression `y`.
    * `expect_output(x, y)` Match output of running `x` against regular expression `y`.
    * `expect_message(x, y)`
    * `expect_warning(x, y)` Match warning against regular expression `y`.
    * `expect_error(x, y)` Match error against regular expression `y`.
+ You can run this test interactively, source the R script, or use other functions from `testthat`, such as `test_file()`, `test_dir()`, `auto_test()`.

However, it makes sense to set our package up for comprehensive automated testing. Luckily, `devtools` also has a function for that:

+ `devtools::use_testthat()`

This sets up a handy test structure in the folder `tests` by adding the folder `tests/testthat/` (where our tests will go) as well as the *master file* `tests/testthat.R`:

    library(testthat)
    library(gameday)
    
    test_check("gameday")

It also adds `testthat` to the `Suggests` in our `DESCRIPTION`.

What is there to test about `gday()`? Since it relies on live data it is a little more challenging to write an informative test, but some useful tests are below. To begin with, we copy our test that checks the case to the new `tests/testthat/` folder. Other reasonable tests are:

    # save as tests/testthat/test_me.R
    test_that("case is ignored", {
      expect_equal(gday("canucks"), gday("CANUCKS"))
    })
    
    test_that("always returns logical", {
      expect_is(gday("canucks"), "logical")
    })
    
    test_that("asking for the city works just as well", {
      expect_equal(gday("canucks"), gday("Vancouver"))
    })
    
    test_that("Seattle does not have a NHL team", {
      expect_false(gday(team="Seattle"))
    }

Looks good, let's run the tests! What are our options:

+ *Build & Reload*  (`R CMD INSTALL ../gameday`) does **not** run the tests.
+ *Load All* (`devtools:load_all()`) does **not** run the tests.
+ *Test package* (`devtools::test()`) runs the tests.
+ *Check* (`devtools::check()`) runs the tests (also updates vignette, documentation, etc).
+ `devtools::auto_check('./R', './tests')` runs all the tests continuously.

Once these tests work and pass, I suggest it's time for a new version number `0.0.0.9001` and a commit & push to GitHub.

### Update the R code

There are a couple of things that could be improved in our current implementation.

#### Add a `date` argument to `gday()`

Since the url is so predictable, it is natural to allow the user to specify a second argument `date` (in the past or future, should default to today's date) and use `gday()` to check if her team has a game that day. This will also open the door for more test cases (the schedule in the past is not going to change).

**Your turn:** Which files do you need to modify to make these changes? What do you need to run next to make your package consistent? Your last step is to *Build & Reload* the consistent package.

As a bonus, add a check to `gday()` to make sure the date is entered correctly. Use `as.Date` (what does it return if an invalid date like "201-411-12" is entered?) and `stopifnot()`. The following tests should all pass.

    context("Check dates")
    
    test_that("Vancouver Canucks had a game against Nashville Predators on 2014-11-02", {
    expect_true(gday(team = "canucks", date = "2014-11-02"))
    expect_true(gday(team = "predators", date = "2014-11-02"))
    })
    
    test_that("Washington Capitals did not play on 2014-11-10", {
    expect_false(gday(team = "capitals", date = "2014-11-10"))
    expect_false(gday(team = "washington", date = "2014-11-10"))
    })
    
    test_that("Wrong date type throws error", {
    expect_error(gday("Bruins", date = "201-411-12"), "Error")
    })


### Finally...

...let's bump the version to our first minor release `0.1.0` and push everything to GitHub. You can be proud of yourself if you got this far!

back to [All the package things](packages00_index.html)
