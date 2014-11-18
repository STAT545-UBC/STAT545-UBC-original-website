---
title: "Write your own R package"
author: "Bernhard Konrad, Jennifer Bryan"
output:
  html_document:
    toc: true
---

### Your mission

This is a step-by-step instruction on how to create your first R package. *This will be much easier than you think.*

In this tutorial we will develop a package *gameday* that provides the function `gday()`. This function takes one argument `team.name`, the name of your favorite [NHL](http://www.nhl.com/) team, and returns `TRUE` if this team has a game today, and `FALSE` otherwise. The function will actually be a one-liner because we can read this information from the web.

### Prerequisites

We assume you have [configured your system for R package development](packages01_system-prep.html). This will ensure you have all the right software installed and that it's updated. Ignoring this prep will only lead to heartache. Do it.

### Set up the directory = RStudio project = R package = Git repo

R expects a certain folder structure for your package. Luckily, the package `devtools` does this work for us.

```r
library("devtools")
create("/path/to/your/package/gameday")
```

**!! Replace `/path/to/your/package/` with a path that exists on your computer !!** Use RStudio's auto-completion of paths to make this true by definition. To avoid nesting a Git repo within a Git repo, we recommend you NOT put this inside your STAT 545 repository.

This creates a folder `gameday` and populates it with a couple of files. Navigate to this folder and open `gameday.Rproj` with RStudio.

Before we talk about the files and folders that were created, let's put this under version control: *Tools > Version Control > Project Setup*. Then choose *Version control system: Git* and *initialize a new git repository for this project*. Then restart RStudio in this Project.

Now, let's talk about the contents of our `gameday` directory.

### Files that R expects in a package

* Helper files that we don't have to worry about now:
    + `.gitignore` The usual ignore file for Git. We don't have to change it.
    + `.Rbuildignore` An ignore file for the R package building process. We can talk about this later.
    + `.Rhistory` The usual history file of your R session. We don't have to change it.
    + `gameday.Rproj` The usual file for an RStudio project. We don't have to change it.
    + `NAMESPACE` A very important file, but we will never edit this by hand. `roxygen2` will maintain this for us.

* `R/` finally, this is where the actual R code will go.
* `DESCRIPTION` holds meta information about your package. We will modify this first. (Technically, the presence of this very file signals to RStudio that the `gameday` Project is a package.)


### The DESCRIPTION File

Here is where we add information about the package (`gameday`) and its authors (us). Some fields are pre-filled, but many more fields can be added as necessary. The initial raw version may depend on your version of `devtools` but should look similar to this:

```sh
Package: gameday
Title: What the package does (one line)
Version: 0.1
Authors@R: "First last <first.last@example.com> [aut, cre]"
Description: What the package does (one paragraph)
Depends: R (>= 3.1.2)
License: What license is it under?
LazyData: true
```

Let's look at those in detail. **Bold** fields are mandatory:

+ **Package**. The name of the package. We will leave this as `gameday`.
+ **Title**. A one-line description of what the package does. Capitalize principal words, stick to a single line, don't use markup and do not end in a period.
+ **Version**. Convention has it that this should be in the format `<major>.<minor>.<patch>`. Since we are only in development we start a fourth digit, which, also by convention, starts with `9000`. Hence `0.0.0.9000` is a good starting point, and `0.0.0.9001` would be the next (development) version while `0.1.0` or `1.0.0` would be the first release version.
+ **Authors\@R**. Machine-readable description of the authors (`aut`), maintainer (`cre`), contributors (`ctb`) and others (see `?person`).
+ **Description**. One paragraph of what the packages does. Lines of 80 characters or less. Indent subsequent lines with 4 spaces (if you're lucky some of this formatting will be done automatically for you later, but don't count on this).
+ **Depends**. Lists the dependencies that are absolutely necessary to load the package. These will be installed when the package is installed with `install.package("gameday", dependencies = TRUE)`. Packages listed here will also be attached whenever `gameday` is loaded with `library("gameday")`. You should probably only list some version of R here.
+ *Imports*. Similar to **Depends** a package in *Imports* will also be installed when `gameday` is, but it won't be attached. This means that your package can use the functions from the package, but you will need to call them via, e.g., `package::function()`. This should be your default way to depend on external packages.
+ **License**. Who can use this package and for what? I suggest [*CC0*](http://creativecommons.org/publicdomain/zero/1.0/), which means that we dedicate our package to the public domain and waive all of our rights. Anyone can freely use/adapt/modify/sell this work without our permission. We also don't provide any warranties about liability or correctness. You can check out [other licenses](http://choosealicense.com/).
+ *LazyData*. Is a little technical, but setting this to `true` makes your package a better citizen with respect to memory.
+ There are [many more fields available](http://cran.r-project.org/doc/manuals/r-release/R-exts.html#The-DESCRIPTION-file).

Hence, a reasonable version of `DESCRIPTION` after editing would be

```sh
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
```

### The actual R code

The R code that our package provides is in the `R` folder. So let's **create a new R script** and save it in the `R` folder with the name `gday.R`.

The content is the following:

```
gday <- function(team = "canucks") {
    url <- paste0("http://live.nhle.com/GameData/GCScoreboard/",
                  Sys.Date(), ".jsonp")
    grepl(team, RCurl::getURL(url), ignore.case = TRUE)
}
```

We first construct the url where the data for today's matches is stored and retrieve info from the web. We use `grepl()` on the result to check if `team` is among them. [See what the data file looks like](http://live.nhle.com/GameData/GCScoreboard/2014-11-09.jsonp) and compare with [today's matches on NHL.com](http://www.nhl.com/). Notice that we use `RCurl::getURL()`, which means we need to add `RCurl` to *Imports* in `DESCRIPTION`, i.e. we add the line

```
Imports: RCurl
```

We don't have to specify a version number for other packages, but we could if we wanted to. So far so good.

### Documenting the function

But what about [documentation](http://asset-1.soup.io/asset/1524/9224_10db.jpeg) (what you would see with `?gday`)? Luckily, `roxygen2` helps us with that and allows us to add the documentation as comments directly in the *R* script. All we have to do is start the line with `#' ` and use the `\@` notation like so:

```
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
#' @param team
#' @return Logical. \code{TRUE} if \code{team} has a NHL game today,
#' \code{FALSE} otherwise
#' @keywords misc
#' @note case in \code{team} is ignored
#' @export
#' @examples
#' gday()
#' gday("Bruins")
gday <- function(team="canucks") {
  url <- paste0("http://live.nhle.com/GameData/GCScoreboard/", Sys.Date(), ".jsonp")
  grepl(team, RCurl::getURL(url), ignore.case=TRUE)
}
```


A few of those tags need explanation

+ `\@keywords` must be taken from the [list of R keywords](https://svn.r-project.org/R/trunk/doc/KEYWORDS)
+ `\@export` makes the function `gday()` available when the package is loaded, in contrast to a helper function that is only designed for internal use within the package.
+ There are [many more tags and explanations](http://r-pkgs.had.co.nz/man.html) if you want to learn more.

### Let devtools, roxygen2 compile the documenation for you

Phew, that was a lot of work, but now we can hand the rest over back to R. In particular, `devtools` and `roxygen2` will compile the documentation

```
library("devtools")
document()
```

When we run this the first time, the new folder `man` is created with the file `gday.Rd`. Go ahead an open it, this is what we would have had to write if it was not for `roxygen2` (the syntax resembles the markup language [LaTeX](http://en.wikipedia.org/wiki/LaTeX)).

Also observe that we now have a file `NAMESPACE` which, as expected, says that the package `gameday` provides the function `gday()`.

You can also generate documentation with RStudio via the Build menu or the Build tab or the keyboard shortcut given there.

### Build the package

As a final step, let's build the package. In RStudio use the *Build* tab and choose *Build & Reload*. That's it. Your package is now installed, your R session is restarted, and your package is loaded. You are now able to run

```
gday("canucks")
gday("flames")
```

and will notice that (on 2014-11-10) the Vancouver Canucks are not playing, but the Calgary Flames do have a game. To see the rendered version of our function documentation, use

```
?gday
```

As you update the package, frequently run `document()` and then *Build & Reload* to try out your latest version. As your package gets bigger, you will want to explore `devtools::load_all()` as a lighter weight way to see how things are going.

### What's next

Congratulations, you just wrote your first *R* package! This is the end of part 1. In the [second part](packages03_activity_part2.html) we explore the following:

+ Create help file for the `gameday` package, which is displayed by `?gameday`.
+ Add a vignette.
+ Publish `gameday` on GitHub.
+ Add tests with `testthat`.
+ Modify `gday()` to accept a second input `date` that defaults to `Sys.Date()`.
+ Show interactive *fix & test* workflow.

------------------------------------------------------------

back to [All the package things](packages00_index.html)
