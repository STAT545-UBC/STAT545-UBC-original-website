---
title: "Write your own R package, part 2"
author: "Bernhard Konrad"
date: ""
output:
  html_document:
    toc: true
    pandoc_args: "--preserve-tabs"
---

Write your own R package, part 2
================================================================================

Where we left off on Monday:

+ Created `gameday` package layout with `devtools::create()`
+ Modified `DESCRIPTION`
+ Added `gday.R` function to the `gameday` package. It checks if your NHL team plays today
+ Added `roxygen2`-style documentation to `gday()`
+ Built package in *RStudio* with *Build & Reload* from the *Build* tab
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


================================================================================


### Documentation for the package itself

We now have a documentation for the `gday` function. Next, let's add a minimal documentation of the `gameday` package itself (what you would see with `?gameday`). For that, open a *New R script* and save it as *R/gameday.r*. The content should be something like

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

+ `\@docType package` specifies that we document the package itself (instead of a function)
+ We don't have any *R* code to document here, but `roxygen2` needs some *R* code here. Hence the convention is to put the dummy code `NULL`.

### Vignette

Vignettes allow you to give a broader overview of your package, and show new users what it can be used for and how to use it. Vignettes tell the story of your package. The good news is that, as of *R 3.0.0* you can use *Rmarkdown* to write your vignettes (previously *LaTeX* was required). It gets better: `devtools` provides a template for your vignette, to make the process of writing this user-friendly guide as easy as possible:

+ In your package, call `library(devtools)` and then `use_vignette("overview")`. This creates `vignettes/overview.Rmd` and adds

        Suggests: knitr
        VignetteBuilder: knitr
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
    * Please change the *title* and *author*, as well as the *Vignette Title*. Don't be confused about *vignette: >*, this just means that the following LaTeX lines are read as-is instead of being interpreted as YAML. After your changes, `vignettes/overview.Rmd` YAML should look similar to this:
    
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
* Now we can add the actual *Rmarkdown* of our vignette. This should show realistic usage -- usually something beyond the scope of the examples typically found in a help file. In packages that are more sophisticated than `gameday`, it's fair to say that a vignette is where you show how to combine several functions from your package to accomplish something interesting to your audience. 
* Once you have your vignette in an acceptable state it is time to turn the *Rmarkdown* source into the vignette as the R package expects it. Since vignettes may take a long time to complile, this is **not** automatically done by *Build & Reload*. Instead, use `devtools:build_vignettes()`. This puts all required files in the folder `inst/doc`.
* You can now *Build & Reload* your package, it will also make the vignette available. To view it, simply use `browseVignettes(package="gameday")`.

### Publish on GitHub

#### Commit locally

First we have to commit all our files to our local git repository. If you don't have a *Git* tab in *RStudio*, go to *Tools -> Version Control -> Project Setup* and choose *Git*. This will restart *RStudio*. Then, go to the *Git* tab, check all files and folders, click *commit*, add a *commit message* (eg "my first version of my first R package") and *commit*.

#### Create new, empty GitHub repository

We will now make our package publically available on GitHub. If we want others to see and use our work we have to make this repository public.

1. Go to `github.com` and click on your username (should be on the top right).
2. Choose *Repositories -> New*
3. The repository name is *gameday*. You can leave *Description* empty. Choose **Public** and **do NOT initialize with a README**.
4. Copy the address of the repository. For me this is `https://github.com/BernhardKonrad/gameday`.

#### Connect RStudio and GitHub

We have to tell *RStudio* where to put the files of our new package. For this, we have to briefly default back to the *Shell*:

1. *Tools -> Shell...*.
2. In the shell we have to add the GitHub repository as a remote, and we abbreviate it as *origin*: `git remote add origin https://github.com/BernhardKonrad/gameday`.
3. Push your changes to the new remote (branch *master*), and set this remote as the new default: `git push -u origin master`.
4. Close the shell, you will now be able to push and pull directly from *RStudio*.
5. Your package is now publically (and freely, remember the License) available to the world.
6. It gets better: You can actually install your package from GitHub directly:

        install_github("BernhardKonrad/gameday")




### Tests

We all feel that we should be testing our code. In fact, we all do, but not in an effective and efficient way.

> It's not that we don't test our code, it's that we don't store our tests so they can be re-run automatically. (Hadley Wickham)

Usually we inspect our code interactively and smell test our data. Formal testing, however, is regarded as very advanced and *"not worth it"* for the daily work. Turns out, a simple test suit like [`testthat`](http://vita.had.co.nz/papers/testthat.html) doesn't only make testing very easy, but will also make you spend less time fixing bugs and more time writing code.

We will use `testthat` to add tests to our package. The syntax is about as close to english as it gets:

    # save as test_me.R
    test_that("case is ignored", {
    expect_equal(gday("canucks"), gday("Canucks"))
    })

+ The first argument is a string that explains what we are testing for. It completes the sentence *"Test that..."*
+ The second argument is (list of) test(s), that is, checks that have to be satisfied. Above we use `expect_equal`, but there are many more:
    * `expect_true(x)`
    * `expect_false(x)`
    * `expect_is(x, y)`
    * `expect_equal(x, y)`
    * `expect_equivalent(x, y)`
    * `expect_identical(x, y)`
    * `expect_matches(x, y)`
    * `expect_output(x, y)`
    * `expect_message(x, y)`
    * `expect_warning(x, y)`
    * `expect_error(x, y)`
+ To run the test you can
    * `source` the corresponding *R* file,
    * run `test_file("testMe.R")`
    * run `test_dir(".")`
    * run `auto_test(".", "./R")`
    * run `devtools:check()`
    
When you add tests to your package it makes sense to think about a folder structure for where to put the tests. Luckily, `devtools` also has a function for that:

+ `devtools::use_testthat()`

This sets up a handy test structure TODO

    test_that("Vancouver Canucks had a game against Nashville Predators on 2014-11-02", {
    expect_true(gday(team.name="canucks", date="2014-11-02"))
    expect_true(gday(team.name="predators", date="2014-11-02"))
    })
    
    test_that("Washington Capitals did not play on 2014-11-10", {
    expect_false(gday(team.name="capitals", date="2014-11-10"))
    expect_false(gday(team.name="washington", date="2014-11-10"))
    })
    
    test_that("Case is ignored", {
    expect_equal(gday("canucks"), gday("Canucks"))
    })
    
    test_that("Wrong date type throws error", {
    expect_error(gday("Bruins", date="201-111-10"), "Error")
    })



### Update the R code

    #' Is it Gameday?
    #'
    #' This function returns TRUE if your NHL team plays today
    #' and FALSE otherwise
    #'
    #' You know then problem: You're in your office writing R code and
    #' suddenly have the urge to check whether your NHL team has a game today.
    #' Before you know it you just wasted 15 minutes browsing the lastest
    #' news on your favorite hockey webpage.
    #' Suffer no more! You can now ask R directly, without tempting yourself
    #' by firing up your web browser.
    #'
    #' @param team.name The name of your team
    #' @param date The date you want to check. Defaults to today (\code{Sys.Date()})
    #' @return Logical \code{TRUE} if \code{team.name} has a NHL game today,
    #' \code{FALSE} otherwise
    #' @note case in \code{team.name} is ignored
    #' @export
    #' @examples
    #' gday("canucks")
    #' gday("Bruins")
    #' gday("ottawa", date="2014-11-09")
    gday <- function(team.name, date=Sys.Date()){
      stopifnot(!is.nan(as.Date(date)))
      url  <- paste0('http://live.nhle.com/GameData/GCScoreboard/',
                    date, '.jsonp')
      grepl(team.name, getURL(url), ignore.case=TRUE)
    }


### Let devtools, roxygen2 compile the documenation for you


    library("devtools")
    document()

Observe the new file `man/gameday.Rd`.





------------------------------------------------------------
