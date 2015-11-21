# Write your own R package, Part Two



We assume you've come directly from [part one](packages04_foofactors-package-01.html), where we:

  * created the `foofactors` package
  * made it an RStudio Project
  * made it a Git repo
  * created the `fbind()` function
  * checked, built, installed, and test drove the package
  
We assume you'll be committing package source after each major step! No more reminders about that.

We assume you are checking your package often. Maybe after each major step? That's might be overkill, but why not? Use `devtools::check()` in the Console or RStudio *Build > Check*. And remember the true test is to "Build & Reload" and use your functions.

You can see the glorious result of all this by visiting the `foofactors` package on GitHub: <https://github.com/jennybc/foofactors>.

back to [All the package things](packages00_index.html)







### Load `devtools`


```r
library(devtools)
```

<!--
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

**Protip: This file should be named `.Rprofile`, not `.Rprofile.R`.**
-->

### Edit DESCRIPTION

DESCRIPTION provides metadata about your package:

  * read more from [R Packages](http://r-pkgs.had.co.nz/description.html)
  * read more from [Writing R Extensions](https://cran.r-project.org/doc/manuals/r-release/R-exts.html#The-DESCRIPTION-file)

Make these edits:

  * Put yourself in as the author.
  * Write some descriptive text in the `Title` and `Description` fields. Note that CRAN is **very picky** about these fields, so if you want to keep passing `check()`, read [this section](http://r-pkgs.had.co.nz/description.html#pkg-description) section of R Packages.
  * Specify a license. I've opted for MIT, which will require a bit more work below.




```
Package: foofactors
Title: Make Factors Less Annoying
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



### Add a LICENSE

> [Pick a License, Any License. -- Jeff Atwood](http://blog.codinghorror.com/pick-a-license-any-license/)

For more guidance, see relevant sections of

  * [R Packages](http://r-pkgs.had.co.nz/description.html#license)
  * [Writing R Extensions](https://cran.r-project.org/doc/manuals/r-release/R-exts.html#Licensing)
  * GitHub's guide at <http://choosealicense.com>

To finish specifying the MIT license I chose above, add this in a new file called `LICENSE`. Fill in the current year and substitute your name.




```
YEAR: 2015
COPYRIGHT HOLDER: Jennifer Bryan
```



### Document `fbind()`

Wouldn't it be nice to get help on `fbind()`, just like we do with other R functions? That requires that your package have a special R documentation file, `R/fbind.Rd`, written in an R-specific markup language. It's *almost* as fun to write as LaTeX! We will spare ourselves that and use a different approach.

Go to the `fbind.R` script and put the cursor somewhere in the `fbind()` function definition.

In RStudio, do *Code > Insert roxygen skeleton*. A very special comment should appear above your function. This comment will be processed by the [`roxygen2` package](https://cran.r-project.org/web/packages/roxygen2/index.html) to create the `man/fbind.Rd` file. To read more about `roxygen2` motivation and mechanics, read [the documentation chapter](http://r-pkgs.had.co.nz/man.html) of R Packages.

RStudio only inserts a barebones template, so you will need to edit it to look something like that below.




```
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
#'#' fbind(iris$Species[c(1, 51, 101)], PlantGrowth$group[c(1, 11, 21)])
```



But we're not done yet! We still need to trigger the conversion of the `roxygen` comment into `man/fbind.Rd`. You can do this from the RStudio IDE or in the Console.

In RStudio, do *Build > More > Document*.

In R, call `document()`, which is a wrapper function provided by `devtools`. Under the hood, it's calling the `roxygen2` package.


```r
document()
#> Updating foofactors documentation
#> Loading foofactors
#> First time using roxygen2. Upgrading automatically...
#> Updating roxygen version in  /Users/jenny/tmp/foofactors/DESCRIPTION 
#> Writing NAMESPACE
#> Writing fbind.Rd
```

You should now be able to preview your help file like so:


```r
?fbind
```

Does it show up in the usual help pane? Looking like real documentation? Isn't that exciting?

Your package's documentation won't be properly wired up until you do a full "Build & Reload". I'm referring to the links between help files, the link to the package index, etc.

The RStudio [Package Development with `devtools` Cheat Sheet](https://www.rstudio.com/wp-content/uploads/2015/03/devtools-cheatsheet.pdf) has really nice coverage of `roxygen` comment syntax.

#### `NAMESPACE` changes

In addition to the new `roxygen` comment and `man/fbind.R` file, you should see the addition of `export(fbind)` in your `NAMESPACE` file. If you're using Git, look at the current diff to verify all of this. The export directive in `NAMESPACE` is what people mean when they talk about "exporting a function" and it's what makes `fbind()` available to a user after loading `foofactors` via `library(foofactors)`. Just as it is entirely possible to author `.Rd` files "by hand", you can manage `NAMESPACE` explicitly yourself. But we are opting to do so via `devtools` (and `roxygen2`). Here's how it looks right now.


```
# Generated by roxygen2: do not edit by hand

export(fbind)
```

The package should pass `R CMD check` cleanly now and from this point on.





### Add unit tests

Remember when we wrote our first R function? In [lesson 3](block011_write-your-own-function-03.html#use-testthat-for-formal-unit-tests), we created some formal unit tests to check that our function produces expected output when given specific input. This seemed like crazy overkill then, but the payoff for writing unit tests is much more clear when you are writing a package.

Let's declare our intent to write unit tests. We'll use the `testthat` package to help us.


```r
use_testthat()
```

This will add `Suggests: testthat` to `DESCRIPTION` and create the directory `tests/testthat` and the script `test/testthat.R`. This prepares the unit testing machinery for your package. If you're using Git, now is a nice time to look at the current diff and verify the above. And commit.



However, it's still up to YOU to write the actual tests!

Create a new R script in `tests/testthat/test_fbind.R` consisting of this:




```
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



You should probably run this test interactively, as you will when you write your own. Note you'll have to load `testthat` via `library(testthat)` in your R session first.

Going forward, your tests will mostly run automatically and *en masse*. You can trigger this from the RStudio IDE or in the Console. Your tests will also run whenever you check the package in the future.

In RStudio, do *Build > Test package*.

In R, call `test()`, which is a wrapper function provided by `devtools`. Under the hood, it's calling the `testthat` package.


```r
test()
#> Loading foofactors
#> Loading required package: testthat
#> Testing foofactors
#> Binding factors : ..
#> 
#> DONE
```

If you're **really lucky**, `testthat` will praise you. That never seems to happen for me anymore. Did I use up my praise quota?!?

For much more guidance, read the [testing chapter](http://r-pkgs.had.co.nz/tests.html) in R Packages. 

### Use a function from another package

You will inevitably want to use a function from another package in your package. Just as we needed to **export** `fbind()`, we need to **import** functions from the namespace of other packages. If you plan to submit a package to CRAN, note that this even applies to packages that you think of as "always available", such as `stats` and `utils`.

There is more than one way to approach this. I am presenting the one I use, which is the one recommended in the [namespace chapter](http://r-pkgs.had.co.nz/namespace.html) of R Packages and in the [rOpenSci Packaging Guide](https://github.com/ropensci/packaging_guide#deps).

Declare your intent to use some functions from the `dplyr` namespace:


```r
use_package("dplyr")
#> Adding dplyr to Imports
#> Refer to functions with dplyr::fun()
```



This adds the `dplyr` package to the "Imports" section of `DESCRIPTION`. And that is all.

Now add a new function that does, indeed, use a function from `dplyr`. Imagine we want a frequency table for a factor, as a regular data frame with decent names, versus as an object of class `table` or with icky names. Preface your calls to `dplyr` functions with `dplyr::`. The general pattern is this: give the name of the external package, then two colons, then the function to call.

Create a new R script `R/freq_out.R` with this in it:




```
#' Make a frequency table for a factor
#'
#' @param x factor
#'
#' @return tbl_df
#' @export
#' @examples
#'#' freq_out(iris$Species)
freq_out <- function(x) {
  xdf <- dplyr::data_frame(x)
  dplyr::count(xdf, x)
}
```



Generate the associated help file: `document()` or *Build > Document*.


```r
document()
#> Updating foofactors documentation
#> Loading foofactors
#> Writing NAMESPACE
#> Writing freq_out.Rd
```



*I have some regrets about using `dplyr` as an example. It invites tricky questions about importing `%>%` and non-standard evalution as the students extend the package in homework. Seek an alternative external package?*

### Document the package as whole

Let's start adding package-level documentation. Your package as a whole can have its own `.Rd` file. You can see an example by entering `package?dplyr` in R Console. Read more about the uses of package-level documentation in [R Packages](http://r-pkgs.had.co.nz/man.html#man-packages).

Here is the `devtools` function to set this up:


```r
use_package_doc()
#> Creating R/foofactors-package.r
```

This creates a weird dummy file `R/foofactors-package.R` with a roxygen header, that is documenting just ... `NULL`. Whatever. The purpose of this artificial stuff is simply to create the package-level `.Rd` file.

Edit `R/foofactors-package.R` to look something like this. I just copied info from `DESCRIPTION` but you can go much farther here and probably should in real life.  This file isn't subject to the same CRAN checks as `DESCRIPTION`, so you have much more freedom.




```
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



Don't forget to run `document()`!


```r
document()
#> Updating foofactors documentation
#> Loading foofactors
#> Writing foofactors.Rd
```



### Add a vignette

A piece of package-level documentation that's probably familiar to you is the vignette. This is a great place to put a fully developed example that calls multiple functions from your package to do something useful and realistic. See the [vignettes chapter](http://r-pkgs.had.co.nz/vignettes.html) of R Packages for more.

Here is how to use `devtools` to set up a vignette.


```r
use_vignette("hello-foofactors")
#> Draft vignette created in /Users/jenny/tmp/foofactors/vignettes/hello-foofactors.Rmd
```

Here's what happens:

  * Adds `knitr` and `rmarkdown` to `Suggests` in `DESCRIPTION`
  * Creates a new file with boilerplate vignette content, `vignettes/hello-foofactors.Rmd`
  * Adds `inst/doc` to `.gitignore`

If you're using Git, now is a nice time to look at the current diff and verify the above. And commit.



Edit `vignettes/hello-foofactors.Rmd`. At the very least, do this:

  * Replace **both instances** of "Vignette Title" in the YAML with an actual title and the same title.
  * List yourself as author or remove that line.
  * Remove the boilerplate content and throw in some usage. Even early on, just mine your examples or tests for something to throw in here. It is better than nothing.
  
The vignette source can be seen here: [vignettes/hello-foofactors.Rmd](https://raw.githubusercontent.com/jennybc/foofactors/master/vignettes/hello-foofactors.Rmd)







How to see your compiled vignette? For a quick preview, just use RStudio's "Knit HTML" button. Problem is, the downstream products aren't saved anywhere in your package, so you'll need to redo this every time you want to look at the vignette.

If you want to hold on to a compiled vignette, for your own sake or to push to GitHub, it's a little fiddly. I'm not executing any of these for real, so don't expect to see the result in the `foofactors` repo on GitHub.

Option 1:


```r
build_vignettes()
## Build and reload !!!
browseVignettes("foofactors")
## look at your vignette
```

This puts your vignette (`.Rmd` and any downstream products, such as `.html`) in `inst/doc` but because we are gitignoring `inst/doc` this won't make a rendered vignette available on GitHub. You can however view it locally.

Option 2:

In RStudio, do *Tools > Project Options > Build Tools > Generate documentation with Roxygen > Configure > Use roxygen to generate vignettes*. Then when you `document()`, downstream products, such as vignette `.html` will be left behind in `vignettes/`. There is nothing stopping you from including something like this in vignette YAML:

``` yaml
output:
  rmarkdown::html_vignette:
    toc: true
    keep_md: true
```

Which means vignette `.md` would be left behind in `vignettes/` and therefore potentially available on GitHub.

*I'm really not sure what to advise here.*

<!--
Another option:

```r
build()
install_local("../foofactors_0.0.0.9000.tar.gz", build_vignettes = TRUE)
browseVignettes("foofactors")
```
-->

### Connect to GitHub

This will create a remote companion repository on GitHub and will get things hooked up so your Push and Pull buttons work in RStudio. If you prefer, you can always create the GitHub repo in the browser and use command line Git to add the GitHub remote and set an upstream tracking branch for `master`.

To connect to GitHub, under the hood `devtools` calls the GitHub API. This means you'll need to have a personal access token (PAT).

Get a PAT here <https://github.com/settings/tokens>. Make sure the "repo" scope is included (last I checked, the defaults WILL include it).

Store your PAT as an environment variable named `GITHUB_PAT` in `~/.Renviron`, which holds environment variables that should be available to R processes. `devtools` will look here for it, by default. Here "~/" means your home directory. If you're not sure where that is, execute `normalizePath("~/")` in R console. **This file should be named `.Renviron`, not `.Renviron.R` and look like this:**

``` sh
GITHUB_PAT=??40-RANDOM-LETTERS-AND-DIGITS-GO-HERE??
```

Restart R and check that the PAT is now available:


```r
Sys.getenv("GITHUB_PAT")
```

You should see your PAT print to screen.

Connect your package to a new, public GitHub repo using the https protocol like so:


```r
use_github(protocol = "https")
```


```
#> Using github PAT from envvar GITHUB_PAT
#> * Creating GitHub repository
#> * Adding GitHub remote
#> * Adding GitHub links to DESCRIPTION
#> * Pushing to GitHub and setting remote tracking branch
```

If you have a private repo to spare, feel free to add `private = TRUE`.

If you use SSH, remove `protocol = "https"` (SSH is the default).

Go look at your package's repo on GitHub! You should also be able to use the Pull and Push buttons from RStudio now.

### Use `README.Rmd`

Now that your package is on GitHub, the `README.md` file matters (unless it's just for personal use). It is the package's home page.

Provide code to install your package, explain what it's for, and show a bit of usage. Copy stuff liberally from `DESCRIPTION`, `R/foofactors-package.R`, examples, and your vignette. Anything is better than nothing. Otherwise ... do you expect people to install your package and comb through individual help files to figure out how to use it?

It is best to write your `README` in R markdown, so it can reflect actual usage. Do "Build & Reload" now, so your properly built and installed package is found when you render `README.Rmd`.

This `devtools` function will set things up for `README.Rmd`:


```r
use_readme_rmd()
#> Creating README.Rmd
#> Adding pre-commit hook
```

This inserts a boilerplate `README.Rmd` file, adds some lines to `.Rbuildignore`, and creates a Git pre-commit hook to help you keep `README.Rmd` and `README.md` in sync.



The `README.Rmd` we use can be seen here: [vignettes/README.Rmd](https://raw.githubusercontent.com/jennybc/foofactors/master/README.Rmd).





Don't forget to knit it to make `README.md`! The pre-commit hook should remind you if you try to commit `README.Rmd` but not `README.md` and also when `README.md` appears to be out-of-date.


```r
rmarkdown::render("README.Rmd") ## or use "Knit HTML"
```

You can see the rendered `README.md` simply by visiting the `foofactors` package on GitHub: <https://github.com/jennybc/foofactors>.

Finally, don't forget to do one last commit. And push!





### The End

Hopefully you've been running `check()` periodically all along. If not, do it now! The package should have no errors, warnings or notes. Now might be a good time to do "Build and reload" to celebrate.

Feel free to visit the [`foofactors` package](https://github.com/jennybc/foofactors) on GitHub, which is exactly as developed in this tutorial. The commit history reflects each individual step, so use the diffs to see the addition and modification of files, as the package evolved.

back to [All the package things](packages00_index.html)

[Suggest an edit to this page ...](https://github.com/STAT545-UBC/STAT545-UBC.github.io/edit/master/packages05_foofactors-package-02.Rmd)

