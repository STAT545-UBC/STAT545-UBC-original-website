# Write your own R package, Part Two



*This is a skeleton account of what we did in class. Narrative? Not so much. It's getting better!*

We assume you've come directly from [part one](packages04_foofactors-package-01.html), where we:

  * created the `foofactors` package
  * made it an RStudio Project
  * made it a Git repo
  * created the `fbind()` function
  * checked, built, installed, and test drove the package
  
We assume you'll be commiting package source after each major step! No more reminders about that.

We assume you are checking your package often. Maybe after each major step? That's probably overkill but why not? Use `devtools::check()` in the Console or RStudio *Build > Check*. And remember the true test is to "Build & Reload" and use your functions.





### Load `devtools`


```r
library(devtools)
```

Or you might want to put something like this in your `.Rprofile` in your home directory:


```r
if (interactive()) {
  options(
    ## use https repos
    repos = c(CRAN = "https://cran.rstudio.org")
  )
  library(devtools)
}
```

**This file should be named `.Rprofile`, not `.Rprofile.R`.**

### Edit DESCRIPTION

DESCRIPTION provides [metadata about your package](http://r-pkgs.had.co.nz/description.html).

Make (at least) the following edits:

  * Put yourself in as the author.
  * Write some descriptive text in the `Title` and `Description` fields. Note that CRAN is **very picky** about these fields, so if you want to keep passing `check()`, read [this section](http://r-pkgs.had.co.nz/description.html#pkg-description) section of R Packages.
  * I've opted to specify the MIT license (will require a bit more work below).

``` sh
Package: foofactors
Title: Make factors less annoying
Version: 0.0.0.9000
Authors@R: person("Jennifer", "Bryan", role=c("aut", "cre"),
  email = "jenny@stat.ubc.ca")
Description: Factors have driven people to extreme measures, like ordering
    custom conference ribbons and laptop stickers to express how HELLNO we
    feel about stringsAsFactors. And yet, sometimes you need them. Can they
    be made less maddening? Let's find out.
Depends:
    R (>= 3.2.2)
License: MIT + file LICENSE
LazyData: true
```

### LICENSE

Relevant section from R Packages: <http://r-pkgs.had.co.nz/description.html#license>

<http://choosealicense.com>

To finish specifying the MIT license, add this in a new file called LICENSE. Fill in the year and your name.

``` sh
YEAR: 2015
COPYRIGHT HOLDER: <Name of the copyright holder>
```

### Document `fbind()`

Go to the `fbind.R` script and put the cursor somewhere in the `fbind()` function definition.

RStudio *Code > Insert roxygen skeleton*. You will see a very special comment appear above your function. This comment will be processed by the `roxygen2` package to create an official R help file for your `fbind()` function. RStudio only inserts a barebones template, so you will need to edit it to look something like that below.

You can learn much more about what's possible in the [documentation chapter](http://r-pkgs.had.co.nz/man.html) of R Packages.

``` sh
#' Bind two factors
#'
#' Create a new factor from two existing factors, where the new factor's levels
#' are the union of the levels of the input factors.
#'
#' @param a factor
#' @param b factor
#'
#' @return factor
#' @export
#' @examples
#' fbind(iris$Species[c(1, 51, 101)], PlantGrowth$group[c(1, 11, 21)])
```

We still need to trigger the conversion process. You can do from the RStudio IDE or in the Console.

RStudio *Build > More > Document* or ...


```r
library(devtools)
document()
```

You should now be able to preview your help file like so:


```r
?fbind
```

Your package's documentation won't be fully wired up until you do a full "Build & Reload".

Note the addition of `export(fbind)` to your `NAMESPACE` file. This is very important! This is called exporting the `fbind()` function and it's what will make `fbind()` available to a user after loading `foofactors` with `library(foofactors)`.

### Unit test

Declare your intent to write unit tests. We're going to use the `testthat` package to help us.


```r
use_testthat()
```

This will add `Suggests: testthat` to `DESCRIPTION` and create the directory `tests/testthat` and the script `test/testthat.R`. This prepares the unit testing machinery for your package.

However, it's still up to YOU to write the actual tests!

Create a new script `tests/testthat/test_fbind.R` and put this in it:


```r
context("Binding factors")

test_that("fbind binds factor (or character)", {
  x <- c('a', 'b')
  x_fact <- factor(x)
  y <- c('c', 'd')
  z <- factor(c('a', 'b', 'c', 'd'))

  expect_identical(fbind(x, y), z)
  expect_identical(fbind(x_fact, y), z)
})
```

Now we run the tests. Again you can use the RStudio IDE or the Console.

RStudio *Build > Test package* or ...


```r
test()
```

If all goes well, you'll see something like this:

```
==> devtools::test()

Loading foofactors
Loading required package: testthat
Testing foofactors
Binding factors : ..

DONE 
```

Relevant section from R Packages: <http://r-pkgs.had.co.nz/tests.html>

### Use a function from another package

Before long, you will want to use a function from another. Just as we needed to **export** `fbind()`, we need to **import** functions from the namespace of other packages.

There is more than one way to approach this. I am presenting the one I use, which is the one recommended in the [namespace chapter](http://r-pkgs.had.co.nz/namespace.html) of R Packages and in the [rOpenSci Packaging Guide](https://github.com/ropensci/packaging_guide#deps).

Declare your intent to use some functions from the `dplyr` namespace:


```r
use_package("dplyr")
```

This will cause the `dplyr` package to be added to the "Imports" section of your DESCRIPTION file. And that is all.

Add a new function that does, indeed, use a function from `dplyr`. Imagine we want a frequency table for a factor, as a regular data frame, versus as an object of class `table`, as returned by `table()`. Preface your calls to `dplyr` functions with `dplyr::`. In general, this means you'll specify the external package's name, followed by two colons, then the function to call.

Create a new script `R/freq_out.R` with this in it:

``` r
#' Make a frequency table for a factor
#'
#' @param x factor
#'
#' @return tbl_df
#' @export
#' @examples
#' freq_out(iris$Species)
freq_out <- function(x) {
  xdf <- dplyr::data_frame(x)
  dplyr::count(xdf, x)
}
```

Generate the associated help file: `document()` or *Build > Document*.

An alternative to this `dplyr::select()` business is to import individual functions. One function you may wish to do this for is the `%>%` operator itself. Put this line in the roxygen header of some function in your package:

``` r
#' @importFrom dplyr %>%
```

It doesn't matter which function -- it will still make `%>%` available broadly within your package. Now run `document()`. That should cause `importFrom(dplyr,"%>%")` to appear in your `NAMESPACE` file. Once you document your package itself (see below), that provides a nice to park package-wide imports like this. At that point, you may wish to move the above line into the roxygen header that underpins the package documentation.

### Connect to GitHub

This will create a remote companion repository on GitHub and will get things hooked up so your Push and Pull buttons work in RStudio.

This requires talking to the GitHub API, which therefore requires that you get a personal access token (PAT).

Get a PAT here <https://github.com/settings/tokens>. Make sure the "repo" scope is included (last I checked, the defaults WILL include it).

Stow this in  `~/.Renviron`, which holds environment variables that should be available to R processes. `devtools` will look here for the PAT. Here "~/" means your home directory. If you're not sure where that is, execute `normalizePath("~/")` in R console. **This file should be named `.Renviron`, not `.Renviron.R`.** In RStudio, that means you should use *File > New file > Text file*.

``` sh
GITHUB_PAT=???????????????????
```

Restart R.

In R, check the PAT is in env var:


```r
Sys.getenv("GITHUB_PAT")
```

Connect your package = Git repo to a new, public GitHub repo. If you want private **and you have a private repo to spare**, add `private = TRUE`. If you use SSH, remove `protocol = "https"` (SSH is the default).


```r
use_github(protocol = "https")
```

Go look at your package's repo on GitHub! You should also be able to use the Pull and Push buttons from RStudio now.

### Use README

You will want to "Build & Reload" at this point, so your properly built and installed package is found when you knit `README.Rmd`


```r
use_readme_rmd()
```

Put something in the README. Such as ... explanation that this is a practice package for STAT 545 and the purpose of the package. Put an R chunk in that demonstates `fbind()`. Just copy the example, at the very least!

Knit it to make `README.md`.

### Add a vignette


```r
use_vignette("hello-foofactors")
```

Edit `vignettes/hello-foofactors.Rmd`. It could start out the same as README.

Then workflow gets a little fiddly.

RStudio option:

*Tools > Project Options > Build Tools > Generate documentation with Roxygen > Configure > Use roxygen to generate vignettes*

Console option 1:


```r
build_vignettes()
## Build and reload
browseVignettes("foofactors")
```

Console option 2:


```r
build()
install_local("../foofactors_0.0.0.9000.tar.gz", build_vignettes = TRUE)
browseVignettes("foofactors")
```

### Document the package as whole

This topic is addressed here in R Packages: <http://r-pkgs.had.co.nz/man.html#man-packages>

This creates a kind of weird dummy file `foofactors-package.R` and roxygen header, which appears to be document just ... `NULL`?


```r
use_package_doc()
```

The purpose of this artificial stuff is just to create a help file for your package as a whole.

If you imported the `%>%` operator from `dplyr` or `magrittr` above, it would be logical to move the associated `@importFrom` statement to this roxygen header.

Don't forget to run `document()`!

I just copied info from the DESCRIPTION file but you can go much farther here and should in real life. This file won't be under the same CRAN checks as DESCRIPTION, so you have much more freedom.


```r
#' foofactors: Make factors less annoying
#'
#' Factors have driven people to extreme measures, like ordering custom
#' conference ribbons and laptop stickers to express how HELLNO we feel about
#' stringsAsFactors. And yet, sometimes you need them. Can they be made less
#' maddening? Let's find out.
#'
#' @name foofactors
#' @docType package
NULL
```

back to [All the package things](packages00_index.html)






