# Write your own R package, Part Two



*This is a skeleton account of what we did in class. Narrative? Not so much. It's coming!*

We assume you've come directly from [part one](packages04_foofactors-package-01.html), where we:

  * created the `foofactors` package
  * made it an RStudio Project
  * made it a Git repo
  * created the `fbind()` function
  * checked, built, and installed the package
  
We assume you'll be commiting package source after each major step! No more reminders about that.

We assume you are checking your package often. Maybe after each major step? That's probably overkill but why not? Use `devtools::check()` in the Console or RStudio *Build > Check*.





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

### Edit DESCRIPTION

DESCRIPTION provides [metadata about your package](http://r-pkgs.had.co.nz/description.html).

Add your name. Edit title and description as you see fit.

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

<http://r-pkgs.had.co.nz/description.html#license>

Add this in a new file called LICENSE. Fill in the year and your name.

``` sh
YEAR: <Year or years when changes have been made>
COPYRIGHT HOLDER: <Name of the copyright holder>
```

### Document `fbind()`

RStudio *Code > Insert roxygen skeleton*

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

RStudio *Build > More > Document* or ...


```r
library(devtools)
document()
?fbind
```

### Unit test

Declare your intent to write unit tests. We're going to use the `testthat` package to help us.


```r
use_testthat()
```

In `tests/testthat/test_fbind.R`:


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

RStudio *Build > Test package* or ...


```r
test()
```

### Connect to GitHub

Get a PAT here <https://github.com/settings/tokens>. Make sure the "repo" scope is included (last I checked, the defaults WILL include it).

In `~/.Renviron`:

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

### Use README


```r
use_readme_rmd()
```

Put something in the README. Such as ... a practice package for STAT 545 and the purpose of the package. Put an R chunk in that demonstates `fbind()`. Just copy the example, at the very least!

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

### Use a function from another package

Declare your intent to use some functions from the `dplyr` namespace:


```r
use_package("dplyr")
```

Add a new function that does, indeed, use a function from `dplyr`.

In `R/freq_out.R`:

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

back to [All the package things](packages00_index.html)






