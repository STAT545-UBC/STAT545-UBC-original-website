# Write your own R package

back to [All the package things](packages00_index.html)

[Suggest an edit to this page ...](https://github.com/STAT545-UBC/STAT545-UBC.github.io/edit/master/packages06_foofactors-package.Rmd)



### Why `devtools`?

We use the `devtools` package to facilitate package development. It's on [CRAN](https://cran.r-project.org/web/packages/devtools/index.html) and developed on [GitHub](https://github.com/hadley/devtools). Why devtools?

  * ensures your package source has the format of a valid R package
  * provides a fluid workflow for package development: tweak it, use it, ... lather, rinse, repeat

The source of R an package is a highly structured set of files that reside in a dedicated directory on your computer. It can be beneficial to also make this directory an RStudio Project and a Git repository and, eventually, associate it with a GitHub remote. `devtools` ensures that your initial set up is correct and helps you keep it that way as your package evolves.

As you develop the functions in your package, you need to take them out regularly for a test drive. How do you plan to get them into memory? Various workflows come to mind:

  * copy/paste or use IDE magic to send the function definition to R Console
  * use `source()` or IDE magic to evaluate the `.R` file with function definition
  * use `R CMD INSTALL` in the shell then, in R, load your package

These workflows may be tolerable at first, but they grow old very quickly. The first two are also suboptimal with respect to package namespace issues. An awkward workflow can lead to bad habits, such as not test driving your package very often, and can make the process totally unpleasant.

`devtools` helps you iterate quickly between developing your functions and checking if they work as intended.

## System prep

We assume you have [configured your system for R package development](packages01_system-prep.html). This will ensure you have all the right software installed and that it's updated. Ignoring this prep will only lead to heartache. **Do it.**

## Load devtools

Load the devtools package.


```r
library(devtools)
```

Since devtools is a workflow package, you may consider loading it automatically in all of your interactive R sessions. In general, it's not a great idea to load packages this way, as it invites you to create R scripts that don't reflect all of their dependencies via explicit calls to `library(foo)`. But devtools is meant to smooth the process of package development and is, therefore, unlikely to get baked into any analysis scripts. The pros may outweigh the cons in this case.

You can do this by adding these lines to your `.Rprofile`:


```r
if (interactive()) {
  suppressMessages(require(devtools))
}
```

## Toy package: foofactors

We use multiple functions from devtools to build a small toy package from scratch, with features commonly seen in released packages:

  * Developed under version control (Git, in this case) and in the open (GitHub, in this case). *optional, but shown*
  * Documentation for individual functions, using convenience functions in devtools that call [roxygen2](https://CRAN.R-project.org/package=roxygen2).
  * Unit testing, using convenience functions in devtools to exploit [testthat](https://CRAN.R-project.org/package=testthat).
  * Documentation for the package as a whole, via a package-level help file, a vignette, and an executable `README.Rmd`.

We call the package **foofactors** and it will consist of a couple functions for handling factors. Please note that these functions are super simple and definitely not the point! For a proper package for factor handling, please see [forcats](https://cran.r-project.org/package=forcats).

The foofactors package itself is not the only purpose of this vignette. It is also meant to demonstrate a typical workflow for package development with devtools.

## Peek at the finished product

The foofactors package is tracked during its development with the Git version control system. This is purely optional and you can certainly follow along without implementing this. A nice side benefit is that we eventually connect it to a remote repository on GitHub, which means you can see the glorious result we are working towards by visiting foofactors on GitHub: <https://github.com/jennybc/foofactors>. By inspecting the [commit history](https://github.com/jennybc/foofactors/commits/master) and especially the diffs, you can see exactly what changes at each step of the process laid out below.

## `create()` the package

The `create()` function initializes a new package in a new directory on your computer. The new package will comply with all devtools conventions and will immediately pass `R CMD check`. Ideally, your package will always be in this happy state and it is something you should verify often.

Make a deliberate choice about where to create this package on your computer. It should probably be in your home directory, alongside your other R projects. It should not be in, for example, an R package library, which holds packages that have already been built and installed. The conversion of the source package we are creating here into an installed package is part of what devtools facilitates. Don't try to do devtools' job for it.



Create a new package in a new directory with `create()`:


```r
create("~/tmp/foofactors")
#> Creating package 'foofactors' in '/Users/jenny/tmp'
#> No DESCRIPTION found. Creating with values:
#> Package: foofactors
#> Title: What the Package Does (one line, title case)
#> Version: 0.0.0.9000
#> Authors@R: person("First", "Last", email = "first.last@example.com", role = c("aut", "cre"))
#> Description: What the package does (one paragraph).
#> Depends: R (>= 3.3.1)
#> License: What license is it under?
#> Encoding: UTF-8
#> LazyData: true
#> * Creating `foofactors.Rproj` from template.
#> * Adding `.Rproj.user`, `.Rhistory`, `.RData` to ./.gitignore
```





If you use RStudio, navigate to this directory and double click on `foofactors.Rproj` to launch a new instance of RStudio in the Project that is also your foofactors package. RStudio has special handling for packages and you should now see a *Build* tab in the same pane as *Environment* and *History*.

What files are in this new directory? Here's a listing (locally, you can consult your file browser):


```r
cbind(listing_1 <- list.files(all.files = TRUE, no.. = TRUE))
#>      [,1]              
#> [1,] ".gitignore"      
#> [2,] ".Rbuildignore"   
#> [3,] "DESCRIPTION"     
#> [4,] "foofactors.Rproj"
#> [5,] "NAMESPACE"       
#> [6,] "R"
```

  * `.gitignore` anticipates Git usage and ignores some standard, behind-the-scenes files created by R and RStudio. Even if you do not plan to use Git, this is harmless.
  * `.Rbuildignore` lists files that we need to have around but that should not be included when building the R package from this source.
  * `DESCRIPTION` provides [metadata about your package](http://r-pkgs.had.co.nz/description.html). We edit this shortly.
  * `foofactors.Rproj` is the file that makes this directory an RStudio Project. Even if you don't use RStudio, this file is harmless. Or you can suppress its creation with `create(..., rstudio = FALSE)`.
  * [`NAMESPACE`](http://r-pkgs.had.co.nz/namespace.html) declares the functions your package exports for external use and the external functions your package imports from other packages. At the moment, it holds temporary-yet-functional placeholder content.
  * The `R/` directory is the ["business end" of your package](http://r-pkgs.had.co.nz/r.html). It will soon contain `.R` files with function definitions.

## `use_git()` for version control

*This is optional, but a recommended practice in the long-term. If you don't use Git, simply ignore this and subsequent instructions related to version control.*

The foofactors directory is an R source package and an RStudio Project. Now we make it also a Git repository, with `devtools::use_git()`.


```r
use_git()
#> * Initialising repo
#> * Adding `.Rproj.user`, `.Rhistory`, `.RData` to ./.gitignore
#> * Adding files and committing
```



What's new? Only the creation of a `.git` directory, which is hidden in most contexts, including the RStudio file browser. Its existence is evidence that we have indeed initialized a Git repo here.


```r
listing_2 <- dir(all.files = TRUE, no.. = TRUE)
cbind(setdiff(listing_2, listing_1))
#>      [,1]  
#> [1,] ".git"
```

If you use RStudio, quit and relaunch this Project, by double clicking on `foofactors.Rproj`. Now, in addition to package development support, you have access to a basic Git client in the *Git* tab of the *Environment/History/Build* pane. Click on History (the clock icon) and you should see the initial commit made by `use_git()`:


```
#> [6c1b5e3] 2016-11-28: Initial commit
```

FYI RStudio can initialize a Git repository, in any Project, even if it's not an R package: *Tools > Version Control > Project Setup*. Then choose *Version control system: Git* and *initialize a new git repository for this project*.

## Define the first function

It is not too hard to find a puzzling operation involving factors. Let's see what happens when we catenate two factors.


```r
(a <- factor(c("character", "hits", "your", "eyeballs")))
#> [1] character hits      your      eyeballs 
#> Levels: character eyeballs hits your
(b <- factor(c("but", "integer", "where it", "counts")))
#> [1] but      integer  where it counts  
#> Levels: but counts integer where it
c(a, b)
#> [1] 1 3 4 2 1 3 4 2
```

Huh? Many people do not expect the result of catenating two factors to be an integer vector consisting of the numbers 1, 2, 3, and 4.

Here's `fbind()`, a function that creates a new factor from two factors, a potentially less surprising result:


```
fbind <- function(a, b) {
  factor(c(as.character(a), as.character(b)))
}
```

Where do you put this function definition? Save it in a `.R` file, in the `R/` subdirectory of your package. A reasonable default is to make a new `.R` file for each function in your package and name the file after the function. So we save the above definition of `fbind()` in the file `R/fbind.R`. The file should consist solely of this function definition, i.e. it should NOT contain other top-level code we have recently executed, such as `library(devtools)` or `use_git()`. Package code should *never* contain a call to `library()`.

How do we test drive `fbind()`? If this were a regular R script, we might use Rstudio or Emacs/ESS to send the function definition to the R Console, thereby defining `fbind()` in the global workspace. Or we might do so via `source("R/fbind.R")`. For package development, however, devtools offers a more robust approach.

## `load_all()` to test drive

Call `devtools::load_all()`:


```r
load_all()
#> Loading foofactors
```

This simulates the process of building, installing, and loading the foofactors package. In the long run, as your package accumulates more functions, some exported, some not, some of which call each other, `load_all()` gives you the most accurate sense of how the package is developing.

Call `fbind(a, b)` to see how it works.


```r
fbind(a, b)
#> [1] character hits      your      eyeballs  but       integer   where it 
#> [8] counts   
#> Levels: but character counts eyeballs hits integer where it your
```

Note that `load_all()` has made the `fbind()` function available, although it does not exist in the global workspace:


```r
exists("fbind", where = ".GlobalEnv", inherits = FALSE)
#> [1] FALSE
```

Review so far:

  * We wrote our first function, `fbind()`, to catenate two factors.
  * We used `load_all()` to quickly make this function available for interactive use, as if we'd built and installed foofactors and loaded it via `library(foofactors)`.

You may want to learn the RStudio keyboard and menu shortcuts for `load_all()`:

  * Windows & Linux: Ctrl + Shift + L
  * Mac: Cmd + Shift + L
  * In *Environment/History/Build/Git* pane:
    - *Build > More > Load All*
  * From Build menu:
    - *Build > Load All*

## Commit `fbind()`

If you're using Git, use your preferred method to commit the new `R/fbind.R` file.


```
[9d9fc63] 2016-11-28: Add fbind()
```

<!--
The diff associated with this commit should look something like this, though you may have a nicer way of inspecting it:
-->



From this point on, we make commits after each step, indicated by a brief message like that above. Remember [these commits](https://github.com/jennybc/foofactors/commits/master) are available in the public repository.

## `check()` and `install()`

We have solid evidence that `fbind()` works. But how can we be sure that all the moving parts of the package still work? This may seem silly to check, after such a small addition, but it's good to establish the habit of checking this often.

How do we move our local source package through the necessary stages to get it properly installed? (Figure from [R Packages](http://r-pkgs.had.co.nz/package.html#package).)

<img src="https://raw.githubusercontent.com/hadley/r-pkgs/master/diagrams/installation.png" width="100%" />

### Base utilities

devtools wraps the base utilities for package management, but in a way favorable for very quick iteration. Under the hood, here are the important commands:

  * [`R CMD build`](https://stat.ethz.ch/R-manual/R-patched/library/utils/html/PkgUtils.html) converts a source package to a bundle or tarball
  * [`R CMD INSTALL`](https://stat.ethz.ch/R-manual/R-patched/library/utils/html/INSTALL.html) installs a package bundle into a library
  * [`R CMD check`](https://stat.ethz.ch/R-manual/R-patched/library/utils/html/PkgUtils.html) runs all sorts of checks. Even if you don't plan to submit your package to CRAN, it's a very good idea to make this part of your own quality standard.

In a shell, with working directory set to the parent of `foofactors`, here's what usage might look like:

``` shell
R CMD build foofactors
R CMD check foofactors_0.0.0.9000.tar.gz
R CMD INSTALL foofactors_0.0.0.9000.tar.gz
```

### devtools and RStudio

Luckily devtools and RStudio make these utilities very easy to access without going to the shell.

At intermediate milestones, you should check your package:

  * In R Console
    - `devtools::check()`
  * From RStudio
    - *Build > Check*

**Just this once, run `check()` with `document = FALSE`**, so we don't get ahead of ourselves. Specifically, I don't want to mess with our `NAMESPACE` file yet.


```r
check(document = FALSE)
#> Setting env vars ---------------------------------------------------------
#> CFLAGS  : -Wall -pedantic
#> CXXFLAGS: -Wall -pedantic
#> Building foofactors ------------------------------------------------------
#> '/Library/Frameworks/R.framework/Resources/bin/R' CMD build '/Users/jenny/tmp/foofactors' --no-resave-data --no-manual
#> * checking for file ‘/Users/jenny/tmp/foofactors/DESCRIPTION’ ... OK
#> * preparing ‘foofactors’:
#> * checking DESCRIPTION meta-information ... OK
#> * checking for LF line-endings in source and make files
#> * checking for empty or unneeded directories
#> * building ‘foofactors_0.0.0.9000.tar.gz’
#> Setting env vars ---------------------------------------------------------
#> _R_CHECK_CRAN_INCOMING_ : FALSE
#> _R_CHECK_FORCE_SUGGESTS_: FALSE
#> Checking foofactors ------------------------------------------------------
#> '/Library/Frameworks/R.framework/Resources/bin/R' CMD check '/var/folders/vt/4sdxy0rd1b3b65nqssx4sx_h0000gn/T//RtmpwRHjRW/foofactors_0.0.0.9000.tar.gz' --as-cran --timings --no-manual
#> * using log directory ‘/private/var/folders/vt/4sdxy0rd1b3b65nqssx4sx_h0000gn/T/RtmpwRHjRW/foofactors.Rcheck’
#> * using R version 3.3.1 (2016-06-21)
#> * using platform: x86_64-apple-darwin13.4.0 (64-bit)
#> * using session charset: UTF-8
#> * using options ‘--no-manual --as-cran’
#> * checking for file ‘foofactors/DESCRIPTION’ ... OK
#> * this is package ‘foofactors’ version ‘0.0.0.9000’
#> * package encoding: UTF-8
#> * checking package namespace information ... OK
#> * checking package dependencies ... OK
#> * checking if this is a source package ... OK
#> * checking if there is a namespace ... OK
#> * checking for executable files ... OK
#> * checking for hidden files and directories ... OK
#> * checking for portable file names ... OK
#> * checking for sufficient/correct file permissions ... OK
#> * checking whether package ‘foofactors’ can be installed ... OK
#> * checking installed package size ... OK
#> * checking package directory ... OK
#> * checking DESCRIPTION meta-information ... WARNING
#> Non-standard license specification:
#>   What license is it under?
#> Standardizable: FALSE
#> * checking top-level files ... OK
#> * checking for left-over files ... OK
#> * checking index information ... OK
#> * checking package subdirectories ... OK
#> * checking R files for non-ASCII characters ... OK
#> * checking R files for syntax errors ... OK
#> * checking whether the package can be loaded ... OK
#> * checking whether the package can be loaded with stated dependencies ... OK
#> * checking whether the package can be unloaded cleanly ... OK
#> * checking whether the namespace can be loaded with stated dependencies ... OK
#> * checking whether the namespace can be unloaded cleanly ... OK
#> * checking loading without being on the library search path ... OK
#> * checking dependencies in R code ... OK
#> * checking S3 generic/method consistency ... OK
#> * checking replacement functions ... OK
#> * checking foreign function calls ... OK
#> * checking R code for possible problems ... OK
#> * checking for missing documentation entries ... WARNING
#> Undocumented code objects:
#>   ‘fbind’
#> All user-level objects in a package should have documentation entries.
#> See chapter ‘Writing R documentation files’ in the ‘Writing R
#> Extensions’ manual.
#> * checking examples ... NONE
#> * DONE
#> Status: 2 WARNINGs
#> R CMD check results
#> 0 errors | 2 warnings | 0 notes
#> checking DESCRIPTION meta-information ... WARNING
#> Non-standard license specification:
#>   What license is it under?
#> Standardizable: FALSE
#> 
#> checking for missing documentation entries ... WARNING
#> Undocumented code objects:
#>   ‘fbind’
#> All user-level objects in a package should have documentation entries.
#> See chapter ‘Writing R documentation files’ in the ‘Writing R
#> Extensions’ manual.
```

**Read the output of the check!** Deal with problems early and often. It's just like incremental development of `.R` and `.Rmd`. The longer you go between full checks that everything works, the harder it is to pinpoint and solve your problems.

At this point, we expect 2 warnings (and 0 errors, 0 notes):

  * `Invalid license file pointers: LICENSE`
  * `Undocumented code objects: 'fbind'`

We'll address both soon.

Since we've already made respectable interim progress, let's install the foofactors package into your library and load it via `devtools::install()`:


```r
install()
#> Installing foofactors
#> '/Library/Frameworks/R.framework/Resources/bin/R' CMD INSTALL '/Users/jenny/tmp/foofactors' 
#> No man pages found in package  ‘foofactors’
#> Reloading installed foofactors
```

Now we can load and use foofactors like any other package.

A shortcut for "build, install, and reload" is offered in the RStudio Build pane:

  * *Build > Build & Reload*

## Installation test

Now that we've installed foofactors properly, let's revisit our small example from the top. This is a good time to restart your R session and ensure you have a clean workspace.

Is foofactors indeed available for loading?


```r
grep("foofactors", installed.packages()[ , "Package"], value = TRUE)
#>   foofactors 
#> "foofactors"
```

Yes! Load and use it.


```r
library(foofactors)
a <- factor(c("character", "hits", "your", "eyeballs"))
b <- factor(c("but", "integer", "where it", "counts"))
fbind(a, b)
#> [1] character hits      your      eyeballs  but       integer   where it 
#> [8] counts   
#> Levels: but character counts eyeballs hits integer where it your
```

Success!

## Edit `DESCRIPTION`

Before we tackle the warnings about the license and documentation, we replace some of the boilerplate content in `DESCRIPTION`. The `DESCRIPTION` file provides metadata about your package:

  * read more from [R Packages](http://r-pkgs.had.co.nz/description.html)
  * read more from [Writing R Extensions](https://cran.r-project.org/doc/manuals/r-release/R-exts.html#The-DESCRIPTION-file)

Make these edits:

  * Make yourself the author.
  * Write some descriptive text in the `Title` and `Description` fields. Note that CRAN is very particular about these fields, so if you want to keep passing `check()`, read [this section](http://r-pkgs.had.co.nz/description.html#pkg-description) of R Packages.
  * Specify a license. We opted for MIT here, which requires a bit more work to complete (see next section).

When you're done, `DESCRIPTION` should look similar to this:


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


```
[419de8c] 2016-11-28: Edit DESCRIPTION
```

## `use_mit_license()`

> [Pick a License, Any License. -- Jeff Atwood](http://blog.codinghorror.com/pick-a-license-any-license/)

For foofactors, we use the MIT license. This requires specification in `DESCRIPTION`, done above, and a file called `LICENSE`. We create that now via the helper function `devtools::use_mit_license()`.


```r
use_mit_license()
#> * Updating license field in DESCRIPTION.
#> * Creating `LICENSE` from template.
```

Open the newly created `LICENSE` file and, if necessary, edit it to make sure it has the current year and your name:


```
YEAR: 2016
COPYRIGHT HOLDER: Jennifer Bryan
```


```
[4e04244] 2016-11-28: Add LICENSE
```

For future projects, there is more guidance on licenses in these sources:

  * [R Packages](http://r-pkgs.had.co.nz/description.html#license)
  * [Writing R Extensions](https://cran.r-project.org/doc/manuals/r-release/R-exts.html#Licensing)
  * GitHub's guide at <http://choosealicense.com>

## `document()`

Wouldn't it be nice to get help on `fbind()`, just like we do with other R functions? This requires that your package have a special R documentation file, `man/fbind.Rd`, written in an R-specific markup language that is sort of like LaTeX. Luckily we don't necessarily have to author that directly.

We write a specially formatted comment right above `fbind()`, in its source file, and then let a package called [roxygen2](https://CRAN.R-project.org/package=roxygen2) handle the creation of `man/fbind.Rd`.  To read more about the motivation and mechanics of roxygen2, read [the documentation chapter](http://r-pkgs.had.co.nz/man.html) of R Packages.

If you use RStudio, open `R/fbind.R` in the source editor and put the cursor somewhere in the `fbind()` function definition. Now do *Code > Insert roxygen skeleton*. A very special comment should appear above your function, in which each line begins with `#'`. RStudio only inserts a barebones template, so you will need to edit it to look something like that below.

If you don't use RStudio, create the comment yourself along these lines:


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
#' fbind(iris$Species[c(1, 51, 101)], PlantGrowth$group[c(1, 11, 21)])
```


```
[90d273d] 2016-11-28: Add roxygen header to document fbind()
```

But we're not done yet! We still need to trigger the conversion of the roxygen comment into `man/fbind.Rd`. You can do this from the RStudio IDE or from R:

  * From RStudio:
    - *Build > More > Document*
  * From R:
    - `document()`, which is a wrapper function provided by devtools.
    Under the hood, it's calling the roxygen2 package.


```r
document()
#> Updating foofactors documentation
#> Loading foofactors
#> Updating roxygen version in /Users/jenny/tmp/foofactors/DESCRIPTION
#> Writing NAMESPACE
#> Writing fbind.Rd
```

You should now be able to preview your help file like so:


```r
?fbind
```

Does it show up in the usual help pane? Looking like real documentation? Isn't that exciting?

Your package's documentation won't be properly wired up until you do a full "Build & Reload". I'm referring to the links between help files, the link to the package index, etc.

The RStudio [Package Development with devtools Cheat Sheet](https://www.rstudio.com/wp-content/uploads/2015/03/devtools-cheatsheet.pdf) has really nice coverage of roxygen comment syntax. You can also get information from *Help > Roxygen Quick Reference*.

### `NAMESPACE` changes

In addition to converting `fbind()`'s special comment into `man/fbind.Rd`, by default, `devtools::document()` updates the `NAMESPACE` file, based on `@export` directives found in roxygen comments. Open `NAMESPACE` for inspection. It should look like so:


```
# Generated by roxygen2: do not edit by hand

export(fbind)
```

It no longer has the placeholder content saying "export everything". Instead, there is now an explicit directive to export the `fbind()` function.

The export directive in `NAMESPACE` is what's required to "export a function" and it's what makes `fbind()` available to a user after loading foofactors via `library(foofactors)`. Just as it is entirely possible to author `.Rd` files "by hand", you can manage `NAMESPACE` explicitly yourself. But we are opting to delegate this to devtools and roxygen2.


```
[9acaa6c] 2016-11-28: Run document()
```

## `check()`

foofactors should pass `R CMD check` cleanly now and forever more: 0 errors, 0 warnings, 0 notes.


```r
check()
#> Updating foofactors documentation
#> Loading foofactors
#> Setting env vars ---------------------------------------------------------
#> CFLAGS  : -Wall -pedantic
#> CXXFLAGS: -Wall -pedantic
#> Building foofactors ------------------------------------------------------
#> '/Library/Frameworks/R.framework/Resources/bin/R' CMD build '/Users/jenny/tmp/foofactors' --no-resave-data --no-manual
#> * checking for file ‘/Users/jenny/tmp/foofactors/DESCRIPTION’ ... OK
#> * preparing ‘foofactors’:
#> * checking DESCRIPTION meta-information ... OK
#> * checking for LF line-endings in source and make files
#> * checking for empty or unneeded directories
#> * building ‘foofactors_0.0.0.9000.tar.gz’
#> Setting env vars ---------------------------------------------------------
#> _R_CHECK_CRAN_INCOMING_ : FALSE
#> _R_CHECK_FORCE_SUGGESTS_: FALSE
#> Checking foofactors ------------------------------------------------------
#> '/Library/Frameworks/R.framework/Resources/bin/R' CMD check '/var/folders/vt/4sdxy0rd1b3b65nqssx4sx_h0000gn/T//RtmpwRHjRW/foofactors_0.0.0.9000.tar.gz' --as-cran --timings --no-manual
#> * using log directory ‘/private/var/folders/vt/4sdxy0rd1b3b65nqssx4sx_h0000gn/T/RtmpwRHjRW/foofactors.Rcheck’
#> * using R version 3.3.1 (2016-06-21)
#> * using platform: x86_64-apple-darwin13.4.0 (64-bit)
#> * using session charset: UTF-8
#> * using options ‘--no-manual --as-cran’
#> * checking for file ‘foofactors/DESCRIPTION’ ... OK
#> * this is package ‘foofactors’ version ‘0.0.0.9000’
#> * checking package namespace information ... OK
#> * checking package dependencies ... OK
#> * checking if this is a source package ... OK
#> * checking if there is a namespace ... OK
#> * checking for executable files ... OK
#> * checking for hidden files and directories ... OK
#> * checking for portable file names ... OK
#> * checking for sufficient/correct file permissions ... OK
#> * checking whether package ‘foofactors’ can be installed ... OK
#> * checking installed package size ... OK
#> * checking package directory ... OK
#> * checking DESCRIPTION meta-information ... OK
#> * checking top-level files ... OK
#> * checking for left-over files ... OK
#> * checking index information ... OK
#> * checking package subdirectories ... OK
#> * checking R files for non-ASCII characters ... OK
#> * checking R files for syntax errors ... OK
#> * checking whether the package can be loaded ... OK
#> * checking whether the package can be loaded with stated dependencies ... OK
#> * checking whether the package can be unloaded cleanly ... OK
#> * checking whether the namespace can be loaded with stated dependencies ... OK
#> * checking whether the namespace can be unloaded cleanly ... OK
#> * checking loading without being on the library search path ... OK
#> * checking dependencies in R code ... OK
#> * checking S3 generic/method consistency ... OK
#> * checking replacement functions ... OK
#> * checking foreign function calls ... OK
#> * checking R code for possible problems ... OK
#> * checking Rd files ... OK
#> * checking Rd metadata ... OK
#> * checking Rd line widths ... OK
#> * checking Rd cross-references ... OK
#> * checking for missing documentation entries ... OK
#> * checking for code/documentation mismatches ... OK
#> * checking Rd \usage sections ... OK
#> * checking Rd contents ... OK
#> * checking for unstated dependencies in examples ... OK
#> * checking examples ... OK
#> * DONE
#> Status: OK
#> R CMD check results
#> 0 errors | 0 warnings | 0 notes
```

## `use_testthat()`

We've tested `fbind()` informally, in a single example. We can formalize and expand this with some unit tests. This means we express a few concrete expectations about the correct `fbind()` result for various inputs.

First, we declare our intent to write unit tests and to use the testthat package for this, via `devtools::use_testthat()`:


```r
use_testthat()
#> * Adding testthat to Suggests
#> * Creating `tests/testthat`.
#> * Creating `tests/testthat.R` from template.
```

This initializes the unit testing machinery for your package. It adds `Suggests: testthat` to `DESCRIPTION`, creates the directory `tests/testthat`, and adds the script `test/testthat.R`.


```
[3a43268] 2016-11-28: Add testing infrastructure
```

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

This tests that `fbind()` gives an expected result when combining two factors and a character vector and a factor.


```
[f8e4030] 2016-11-28: Test fbind()
```

Run this test interactively, as you will when you write your own. Note you'll have to load testthat via `library(testthat)` in your R session first and you'll probably want to `load_all()`.

Going forward, your tests will mostly run *en masse* and at arms's length:

  * In RStudio:
    - *Build > Test package*
  * In R:
    - `test()`, which is a convenience wrapper in devtools that calls the testthat package.


```r
test()
#> Loading foofactors
#> Loading required package: testthat
#> Testing foofactors
#> Binding factors: ..
#> 
#> DONE ======================================================================
```

Your tests are also run whenever you `check()` the package. In this way, you basically augment the standard checks with some of your own, that are specific to your package.

For much more guidance, read the [testing chapter](http://r-pkgs.had.co.nz/tests.html) in R Packages.

## `use_package()`

*I have some regrets about using `dplyr` as an example. It invites tricky questions about importing `%>%` and non-standard evalution as the students extend the package in homework. Seek an alternative external package? Maybe I should use forcats::fct::count()?*

You will inevitably want to use a function from another package in your own package. Just as we needed to **export** `fbind()`, we need to **import** functions from the namespace of other packages. If you plan to submit a package to CRAN, note that this even applies to functions in packages that you think of as "always available", such as `stats::median()` or `utils::head()`.

There is more than one way to go about this. We use the approach recommended in the [namespace chapter](http://r-pkgs.had.co.nz/namespace.html) of R Packages and in the [rOpenSci Packaging Guide](https://github.com/ropensci/packaging_guide#deps).  The general usage pattern is this: give the name of the external package, then two colons, then the function to call.

First, declare your general intent to use some functions from the dplyr namespace with `devtools::use_package()`:


```r
use_package("dplyr")
#> * Adding dplyr to Imports
#> Next:
#> Refer to functions with dplyr::fun()
```


```
[aa933c7] 2016-11-28: Declare we will use dplyr
```

This adds the dplyr package to the "Imports" section of `DESCRIPTION`. And that is all.

Now we add a new function to foofactors that does, indeed, use a function from dplyr. Imagine we want a frequency table for a factor, as a regular data frame with nice variable names, versus as an object of class `table` or something with odd names. Preface your calls to dplyr functions with `dplyr::`.

Create a new file `R/freq_out.R` with this function definition:


```
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


```
[1e5fa00] 2016-11-28: Add freq_out()
```

Try out the new function.


```r
load_all()
#> Loading foofactors
freq_out(iris$Species)
#> # A tibble: 3 × 2
#>            x     n
#>       <fctr> <int>
#> 1     setosa    50
#> 2 versicolor    50
#> 3  virginica    50
```

Generate the associated help file via `document()` or *Build > Document*.


```r
document()
#> Updating foofactors documentation
#> Loading foofactors
#> Writing NAMESPACE
#> Writing freq_out.Rd
```


```
[d5adb0d] 2016-11-28: Document freq_out()
```

## `use_package_doc()`

*Update to use the new sentinel and describe it accurately? Maybe devtools should be updated to do that too?*

Let's start adding package-level documentation. Your package as a whole can have its own `.Rd` file. You can see an example by entering `package?dplyr` in R Console. Read more about the uses of package-level documentation in [R Packages](http://r-pkgs.had.co.nz/man.html#man-packages).

Set this up with `devtools::use_package_doc()`:


```r
use_package_doc()
#> * Creating `R/foofactors-package.r` from template.
#> * Modify `R/foofactors-package.r`.
```

This creates a peculiar dummy file `R/foofactors-package.R` with a roxygen header, that is documenting just ... `NULL`. The purpose of this is simply to trigger the generation of a package-level `.Rd` file.

Edit `R/foofactors-package.R` to look something like this. I just copied info from `DESCRIPTION` but you can add more info here and possibly should in real life.  This file isn't subject to the same CRAN checks as `DESCRIPTION`, so you have much more freedom.


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


```
[9b508be] 2016-11-28: Add package-level doc
```

Don't forget to run `document()`!


```r
document()
#> Updating foofactors documentation
#> Loading foofactors
#> Writing foofactors.Rd
```


```
[d87d987] 2016-11-28: Run document()
```

Have a look at your new package-level docs:


```r
?foofactors
```

## `use_vignette()`

A piece of package-level documentation that's probably familiar to you is the vignette. This is a great place to put a fully developed example that calls multiple functions from your package to do something useful and realistic. See the [vignettes chapter](http://r-pkgs.had.co.nz/vignettes.html) of R Packages for more.

Use `devtools::use_vignette()` to initialize a new vignette:


```r
use_vignette("hello-foofactors")
#> * Creating `vignettes`.
#> * Adding `inst/doc` to ./.gitignore
#> NULL
```

Here's what happens:

  * Adds knitr and rmarkdown to `Suggests` in `DESCRIPTION`.
  * Creates a new file with boilerplate vignette content, `vignettes/hello-foofactors.Rmd`.
  * Adds `inst/doc` to `.gitignore`.
  * If using RStudio, open `vignettes/hello-foofactors.Rmd` for editing.


```
[767de7a] 2016-11-28: Init vignette
```

Now you need to edit `vignettes/hello-foofactors.Rmd`. At the very least, do this:

  * Replace **both instances** of "Vignette Title" in the YAML with an actual title and with the same title.
  * List yourself as author or remove that line.
  * Remove the boilerplate content and throw in some usage. Even early on, just mine your examples or tests for something to throw in here. It is better than nothing.

The vignette source can be seen here: [vignettes/hello-foofactors.Rmd](https://raw.githubusercontent.com/jennybc/foofactors/master/vignettes/hello-foofactors.Rmd)




```
[371596a] 2016-11-28: Write vignette
```

How to see your compiled vignette? For a quick preview, just use RStudio's "Knit HTML" button. Problem is, the downstream products aren't saved anywhere in your package, so you'll need to redo this every time you want to look at the vignette.

If you want to hold on to a compiled vignette, for your own sake or to push to GitHub, it's a little fiddly. I'm not executing any of these for real, so don't expect to see the result in the foofactors repo on GitHub.

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

*I'm really not sure what to advise here?*

## `use_github()`

This creates a remote companion repository on GitHub, sets an upstream tracking branch for `master`, and makes an initial push. If you use RStudio, this means your Push and Pull buttons will work. If you prefer, you can always create the GitHub repo in the browser and use command line Git to add the GitHub remote and set an upstream tracking branch for `master`.

To connect to GitHub, under the hood devtools calls the GitHub API. This means you'll need to use your GitHub account to get a personal access token (PAT).

Get a PAT here <https://github.com/settings/tokens>. Make sure the "repo" scope is included.

Store your PAT as an environment variable named `GITHUB_PAT` in `~/.Renviron`, which holds environment variables that should be available to all R processes. devtools will look here for it, by default. Here "~/" means your home directory. If you're not sure where that is, execute `normalizePath("~/")` in R console. **This file should be named `.Renviron`, not `.Renviron.R`, look like this, and end in a newline:**

``` sh
GITHUB_PAT=??40-RANDOM-LETTERS-AND-DIGITS-GO-HERE??
```

Restart R and check that the PAT is now available:


```r
Sys.getenv("GITHUB_PAT")
```

You should see your PAT print to screen.

Submit the appropriate line below to use `devtools::use_github()` to connect the local foofactors Git repo to a new GitHub repo:


```r
## public repo using https
use_github(protocol = "https")

## private repo using https
use_github(protocol = "https", private = TRUE)

## public repo using ssh
use_github()

## private repo using ssh
use_github(private = TRUE)

```




```r
#> Using GitHub PAT from envvar GITHUB_PAT
#> * Git is already initialized
#> * Checking title and description
#>   Title: Make Factors Less Annoying
#>   Description: Factors have driven people to extreme measures, like ordering
#> custom conference ribbons and laptop stickers to express how HELLNO we
#> feel about stringsAsFactors. And yet, sometimes you need them. Can they
#> be made less maddening? Let's find out.
#> * Creating GitHub repository
#> * Adding GitHub remote
#> * Adding GitHub links to DESCRIPTION
#> * Pushing to GitHub and setting remote tracking branch
#> * View repo at https://github.com/jennybc/foofactors
```


Go look at your package's repo on GitHub! It should look very similar to the package created by this vignette <https://github.com/jennybc/foofactors>. If you use RStudio, your Pull and Push buttons should now work.

## `use_readme_rmd()`

Now that your package is on GitHub, the `README.md` file matters. It is the package's home page and welcome mat.

The `devtools::use_readme_rmd()` function initializes a basic, executable `README.Rmd` ready for you to edit:


```r
use_readme_rmd()
#> * Creating `README.Rmd` from template.
#> * Adding `README.Rmd` to `.Rbuildignore`.
#> * Modify `README.Rmd`.
```

In addition to creating `README.Rmd`, this adds some lines to `.Rbuildignore`, and creates a Git pre-commit hook to help you keep `README.Rmd` and `README.md` in sync.

`README.Rmd` already has sections that:

  * Prompt you to describe the purpose of the package.
  * Provide code to install your package.
  * Prompt you to show a bit of usage.

How to populate this skeleton? Copy stuff liberally from `DESCRIPTION`, `R/foofactors-package.R`, examples, and the vignette. Anything is better than nothing. Otherwise ... do you expect people to install your package and comb through individual help files to figure out how to use it?

We write the `README` in R markdown, so it can feature actual usage. It will load the currently installed version of your package, so this is a good time to do "Build & Reload" in RStudio. Or do this in R Console:


```r
install()
#> Installing foofactors
#> '/Library/Frameworks/R.framework/Resources/bin/R' CMD INSTALL '/Users/jenny/tmp/foofactors'
#> Reloading installed foofactors
```

If RStudio has not already done so, open `README.Rmd` for editing. Make sure it shows some usage of `fbind()` and/or `freq_out()`, for example.


```
[9b1f758] 2016-11-28: Set up README.Rmd
```

The `README.Rmd` we use can be seen here: [README.Rmd](https://raw.githubusercontent.com/jennybc/foofactors/master/README.Rmd).





Don't forget to render it to make `README.md`! The pre-commit hook should remind you if you try to commit `README.Rmd` but not `README.md` and also when `README.md` appears to be out-of-date.


```r
rmarkdown::render("README.Rmd") ## or use "Knit HTML"
```



You can see the rendered `README.md` simply by [visiting foofactors on GitHub](https://github.com/jennybc/foofactors#readme).

Finally, don't forget to do one last commit. And push!


```
[f80ec01] 2016-11-28: Write README.Rmd and render
```



## The End

Let's run `check()` again to make sure all is still well.


```r
check()
#> Updating foofactors documentation
#> Loading foofactors
#> Setting env vars ---------------------------------------------------------
#> CFLAGS  : -Wall -pedantic
#> CXXFLAGS: -Wall -pedantic
#> Building foofactors ------------------------------------------------------
#> '/Library/Frameworks/R.framework/Resources/bin/R' CMD build '/Users/jenny/tmp/foofactors' --no-resave-data --no-manual
#> * checking for file ‘/Users/jenny/tmp/foofactors/DESCRIPTION’ ... OK
#> * preparing ‘foofactors’:
#> * checking DESCRIPTION meta-information ... OK
#> * installing the package to build vignettes
#> * creating vignettes ... OK
#> * checking for LF line-endings in source and make files
#> * checking for empty or unneeded directories
#> * building ‘foofactors_0.0.0.9000.tar.gz’
#> Setting env vars ---------------------------------------------------------
#> _R_CHECK_CRAN_INCOMING_ : FALSE
#> _R_CHECK_FORCE_SUGGESTS_: FALSE
#> Checking foofactors ------------------------------------------------------
#> '/Library/Frameworks/R.framework/Resources/bin/R' CMD check '/var/folders/vt/4sdxy0rd1b3b65nqssx4sx_h0000gn/T//RtmpwRHjRW/foofactors_0.0.0.9000.tar.gz' --as-cran --timings --no-manual
#> * using log directory ‘/private/var/folders/vt/4sdxy0rd1b3b65nqssx4sx_h0000gn/T/RtmpwRHjRW/foofactors.Rcheck’
#> * using R version 3.3.1 (2016-06-21)
#> * using platform: x86_64-apple-darwin13.4.0 (64-bit)
#> * using session charset: UTF-8
#> * using options ‘--no-manual --as-cran’
#> * checking for file ‘foofactors/DESCRIPTION’ ... OK
#> * this is package ‘foofactors’ version ‘0.0.0.9000’
#> * checking package namespace information ... OK
#> * checking package dependencies ... OK
#> * checking if this is a source package ... OK
#> * checking if there is a namespace ... OK
#> * checking for executable files ... OK
#> * checking for hidden files and directories ... OK
#> * checking for portable file names ... OK
#> * checking for sufficient/correct file permissions ... OK
#> * checking whether package ‘foofactors’ can be installed ... OK
#> * checking installed package size ... OK
#> * checking package directory ... OK
#> * checking ‘build’ directory ... OK
#> * checking DESCRIPTION meta-information ... OK
#> * checking top-level files ... OK
#> * checking for left-over files ... OK
#> * checking index information ... OK
#> * checking package subdirectories ... OK
#> * checking R files for non-ASCII characters ... OK
#> * checking R files for syntax errors ... OK
#> * checking whether the package can be loaded ... OK
#> * checking whether the package can be loaded with stated dependencies ... OK
#> * checking whether the package can be unloaded cleanly ... OK
#> * checking whether the namespace can be loaded with stated dependencies ... OK
#> * checking whether the namespace can be unloaded cleanly ... OK
#> * checking loading without being on the library search path ... OK
#> * checking dependencies in R code ... OK
#> * checking S3 generic/method consistency ... OK
#> * checking replacement functions ... OK
#> * checking foreign function calls ... OK
#> * checking R code for possible problems ... OK
#> * checking Rd files ... OK
#> * checking Rd metadata ... OK
#> * checking Rd line widths ... OK
#> * checking Rd cross-references ... OK
#> * checking for missing documentation entries ... OK
#> * checking for code/documentation mismatches ... OK
#> * checking Rd \usage sections ... OK
#> * checking Rd contents ... OK
#> * checking for unstated dependencies in examples ... OK
#> * checking installed files from ‘inst/doc’ ... OK
#> * checking files in ‘vignettes’ ... OK
#> * checking examples ... OK
#> * checking for unstated dependencies in ‘tests’ ... OK
#> * checking tests ...
#>  OK
#> * checking for unstated dependencies in vignettes ... OK
#> * checking package vignettes in ‘inst/doc’ ... OK
#> * checking re-building of vignette outputs ... OK
#> * DONE
#> Status: OK
#> R CMD check results
#> 0 errors | 0 warnings | 0 notes
```

foofactors should have no errors, warnings or notes. This would be a good time to do "Build and reload" to celebrate.


```r
install()
#> Installing foofactors
#> '/Library/Frameworks/R.framework/Resources/bin/R' CMD INSTALL '/Users/jenny/tmp/foofactors'
#> Reloading installed foofactors
```

Feel free to visit the [foofactors package](https://github.com/jennybc/foofactors) on GitHub, which is exactly as developed in this vignette. The commit history reflects each individual step, so use the diffs to see the addition and modification of files, as the package evolved.





[Suggest an edit to this page ...](https://github.com/STAT545-UBC/STAT545-UBC.github.io/edit/master/packages05_foofactors-package-02.Rmd)

back to [All the package things](packages00_index.html)
