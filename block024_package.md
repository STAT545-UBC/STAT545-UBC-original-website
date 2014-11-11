---
title: "Write your own R package"
author: "Bernhard Konrad"
date: "2014-11-10"
output:
  html_document:
    toc: true
    toc_depth: 2
    pandoc_args: "--preserve-tabs"
---

Write your own R package
================================================================================

This is a step-by-step instruction on how to create your first R package. *This will be much easier than you think.*


Getting Started
================================================================================

In this tutorial we will develop a package *gameday* that provides the function `gday`. This function takes one argument `team.name`, the name of your favorite [NHL](http://www.nhl.com/) team, and returns `TRUE` if this team has a game today, and `FALSE` otherwise. The function will actually be a one-liner because we can read this information from the web.

### What you will need

I'm running *RStudio 0.98.1056* as well as

1. R version 3.1.2
2. devtools 1.6.1
3. roxygen2 4.0.2
4. testthat 0.9.1
5. knitr 1.7

Run `packageVersion("devtools")` to check your version of the above packages. Use `install.packages("devtools", dependencies=TRUE)` to install missing packages (check for non-zero exit status), or run `update.packages(ask=FALSE)` to get the latest version.


### Some Background and pointers

You can skip this section on your first read if you want to dive right into the hands-on exercise.

@jennybc: TODO for me. Might link to slides.

### Setting up the folder structure

R expects a certain folder structure for your package. Luckily, the package `devtools` does this work for us.

    library("devtools")
    create("/home/bernhard/Desktop/gameday")

**!! Replace this path above with a path that exists on your computer !!**

This creates a folder *gameday* on my Desktop, and populates it with a couple of files. Navigate to this folder and open `gameday.Rproj` with *RStudio*.

Before we talk about the files and folders that were created, let's add *Git Version Control*: *Tools -> Version Control -> Project Setup*. Then choose *Version control system: Git* and *initialize a new git repository for this project* (this will require restarting RStudio).


Now, let's talk about the galore of files and folders in our folder *gameday*.


### Files that make a packages

* Helper files that we don't have to worry about:
    + `.gitignore` The usual ignore file for Git. We don't have to change it.
    + `.Rbuildignore` An ignore file for the R package building process. We can talk about this later.
    + `.Rhistory` The usual history file of your R session. We don't have to change it.
    + `gameday.Rproj` The usual file for an RStudio project. We don't have to change it.
    + `NAMESPACE` A very important file, but we will never edit this by hand. `roxygen2` will maintain this for us.

* `R/` finally, this is where the actual R code will go.
* `DESCRIPTION` holds meta information about your package. We will modify this first. (Technically, the presence of this very file defines the `gameday` folder as a package.)


### The DESCRIPTION File

Here is where we add information about the package (gameday) and its authors (us). Some fields are pre-filled, but many more fields can be added as necessary. The initial raw version may depepend on your version of `devtools` but should look similar to this:

    Package: gameday
    Title: What the package does (one line)
    Version: 0.1
    Authors@R: "First last <first.last@example.com> [aut, cre]"
    Description: What the package does (one paragraph)
    Depends: R (>= 3.1.2)
    License: What license is it under?
    LazyData: true

Let's look at those in detail. **Bold** fiels are mandatory:

+ **Package**. The name of the package. We will leave this as *gameday*.
+ **Title**. A one-line description of what the package does. Capitalize principal words, stick to a single line, don't use markup and do not end in a period.
+ **Version**. Convention has it that this should be in the format `<major>.<minor>.<patch>`. Since we are only in development we start a fourth digit, which, also by convention, starts with `9000`. Hence `0.0.0.9000` is a good starting point, and `0.0.0.9001` would be the next (development) version while `0.1.0` or `1.0.0` would be the first release version.
+ **Authors\@R**. Machine-readable description of the authors (`aut`), maintainer (`cre`), contributors (`ctb`) and others (see `?person`).
+ **Description**. One paragraph of what the packages does.
+ **License**. Who can use this package and for what? I suggest [*CC0*](http://creativecommons.org/publicdomain/zero/1.0/), which means that we dedicate our package to the public domain and waive all of our rights. Anyone can freely use/adapt/modify/sell this work without our permission. We also don't provide any warranties about liability or correctness. You can check out [other licenses](http://choosealicense.com/).
+ *LazyData*. Is a little technical, but seeting this to `true` makes loading data that your package provides easier.
+ There are [many more fields available](http://cran.r-project.org/doc/manuals/r-release/R-exts.html#The-DESCRIPTION-file).


Hence, a reasonable version of `DESCRIPTION` after editing would be

    Package: gameday
    Title: Let R tell you if your NHL team plays today
    Version: 0.0.0.9000
    Authors@R: as.person(c(
        "Bernhard Konrad <bernhard.konrad@gmail.com> [aut, cre]", 
        "Jennifer Bryan <jenny@stat.ubc.ca> [aut]"
        ))
    Description: Query live.nhle.com to check if your NHL team is listed on
        the teams that play today
    Depends: R (>= 3.1.2)
    License: CC0
    LazyData: true


### The actual R code

The R code that our package provides is in the *R* folder. So let's **create a new R script** and save it in the *R* folder with the name `gday.R`.

The content is the following:

    gday <- function(team.name="canucks") {
      url <- paste0("http://live.nhle.com/GameData/GCScoreboard/", Sys.Date(), ".jsonp")
      grepl(team.name, getURL(url), ignore.case=TRUE)
    }

We first construct the url where the data for today's matches is stored, and then `grepl` to check if `team.name` is among them. [See how the data file looks like](http://live.nhle.com/GameData/GCScoreboard/2014-11-09.jsonp) and compare with [today's matches on NHL.com](http://www.nhl.com/). Notice that we use `RCurl::getURL`, which we have to add to our list of *dependencies* in `DESCRIPTION`, i.e.

    Depends: R (>= 3.1.2)

becomes

    Depends:
        R (>= 3.1.2),
        RCurl

So far so good. But what about [documentation](http://asset-1.soup.io/asset/1524/9224_10db.jpeg) (what you would see with `?gday`)? Luckily, `roxygen2` helps us with that and allows us to add the documentation as comments directly in the *R* script. All we have to do is start the line with `#' ` and use the `\@` notation like so:

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
    #' @param team.name Defaults to "canucks"
    #' @return \code{TRUE} if \code{team.name} has an NHL game on \code{date},
    #' \code{FALSE} otherwise
    #' @keywords misc
    #' @note case in \code{team.name} is ignored
    #' @export
    #' @examples
    #' gday()
    #' gday("canadiens")
    #' gday("Bruins")

A few of those tags need explanation

+ `\@keywords` must be taken from the [list of R keywords](https://svn.r-project.org/R/trunk/doc/KEYWORDS)
+ `\@export` makes the function `gday` available when the package is loaded, in contrast to a helper function that is only designed for internal use within the package.
+ There are [many more tags and explanations](http://r-pkgs.had.co.nz/man.html) if you want to learn more.


### Documentation for the package itself

We now have a documentation for the `gday` function. Next, let's add a minimal documentation of the `gameday` package itself (what you would see with `?gameday`). For that, open a *New R script* and save it as *R/gameday.r*. The content should be something like

    #' My first R package: gameday
    #' 
    #' This is so much fun
    #' 
    #' I look forward to writing really neat packages
    #' so that I can have all my helper functions in one place
    #' and maybe even share them.
    #' 
    #' @docType package
    #' @name gameday
    NULL

+ We don't have any *R* code to document here, hence we put `NULL`. 
+ `\@docType package` specifies that we document the package itself


### Let devtools, roxygen2 compile the documenation for you

Phew, that was a lot of work, but now we can hand the rest over back to *R*. In particular, `devtools` and `roxygen2` will compile the documentation

    library("devtools")
    document()

When we run this the first time, the new folder `man` is created with the files `gameday.Rd` and `gday.Rd`. Go ahead an open those, this is what we would have had to write if it was not for `roxygen2` (the syntax resembles the markup language [LaTeX](http://en.wikipedia.org/wiki/LaTeX)).

Also observe that we now have a file `NAMESPACE` which, as expected, says that the package `gameday` provides the function `gday`.

### Build the package

As a final step, let's build the package. In *RStudio* use the *Build* tab and choose *Build & Reload*. That's it. Your package is now checked, installed and loaded. Your *R* session is also restarted. You are now able to run

    gday("canucks")
    gday("flames")

and will notice that (on 2014-11-10) the Vancouver Canucks are not playing, but the Calgary Flames do have a game. To see the rendered version of our documentation, use

    ?gameday
    ?gday


As you update the package, frequently run `document()` and then *Build & Reload* to test your latest version.


### Publish on GitHub


#### Commit locally

First we have to commit all our files. In *RStudio*, go to the *Git* tab, check all files and folders, click *commit*, add a *commit message* (eg "my first version of my first R package") and *commit*.


#### Create new, empty GitHub repository

As a final step we will now make our package available on GitHub. If we want others to see and use our work we have to make this repository public.

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

The End (for now)

------------------------------------------------------------
