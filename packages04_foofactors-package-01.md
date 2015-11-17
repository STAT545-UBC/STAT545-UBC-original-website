# Write your own R package, Part One



### Prerequisites

We assume you have [configured your system for R package development](packages01_system-prep.html). This will ensure you have all the right software installed and that it's updated. Ignoring this prep will only lead to heartache. **Do it.**

### Why `devtools`?

We will use the `devtools` package to facilitate package development. It's on [CRAN](https://cran.r-project.org/web/packages/devtools/index.html) and developed on [GitHub](https://github.com/hadley/devtools). Why?

  * ensures your package source has the format of a valid R package
  * provides a fluid workflow for package development: tweak it, use it, ... lather, rinse, repeat

The source of R an package is a highly structured set of files that reside in a dedicated directory on your computer. It can be beneficial to also make this directory an RStudio Project and a Git repository and, eventually, associate it with a GitHub remote. `devtools` ensures that your initial set up is correct and helps you keep it that way as your package evolves.

As you develop the functions in your package, you need to take them out regularly for a test drive. How do you plan to get them into memory? Various workflows come to mind:

  * copy/paste or use IDE magic to send the function definition to R Console
  * use `source()` or IDE magic to evaluate the `.R` file with function definition
  * use `R CMD INSTALL` in the shell then, in R, load your package

These workflows may be tolerable at first, but they grow old very quickly. The first two are also suboptimal with respect to package namespace issues. An awkward workflow can lead to bad habits, such as not test driving your package very often, and can make the process totally unpleasant.

`devtools` helps you iterate quickly between developing your functions and checking if they work as intended.

### Create the package

Our demo package will provide functions for the care and feeding of factors, the variable type we all love to hate.

We'll call it `foofactors` here but you can call yours whatever you want.

**!! Modify the path below to create your new package where YOU want it on YOUR system!!** Use RStudio's auto-completion of paths to make sure the path exists. To avoid nesting a Git repo within a Git repo, we recommend you NOT put this inside your STAT 545 repository.



Create a new package in a new directory with `devtools::create()`:


```r
library(devtools)
create("~/tmp/foofactors")
#> Creating package foofactors in /Users/jenny/tmp
#> No DESCRIPTION found. Creating with values:
#> Package: foofactors
#> Title: What the Package Does (one line, title case)
#> Version: 0.0.0.9000
#> Authors@R: person("First", "Last", email = "first.last@example.com", role = c("aut", "cre"))
#> Description: What the package does (one paragraph).
#> Depends: R (>= 3.2.2)
#> License: What license is it under?
#> LazyData: true
#> Adding RStudio project file to foofactors
```





Navigate to this directory and double click on `foofactors.Rproj` to launch a new RStudio session in the Project that is your `foofactors` package.

What does it look like? Here's a file listing (you can consult the file browser):


```
#>      [,1]              
#> [1,] ".gitignore"      
#> [2,] ".Rbuildignore"   
#> [3,] "DESCRIPTION"     
#> [4,] "foofactors.Rproj"
#> [5,] "NAMESPACE"       
#> [6,] "R"
```

  * `DESCRIPTION` provides [metadata about your package](http://r-pkgs.had.co.nz/description.html).
  * The `R/` directory is the ["business end" of your package](http://r-pkgs.had.co.nz/r.html). It will contain `.R` files with function definitions.
  * [`NAMESPACE`](http://r-pkgs.had.co.nz/namespace.html) declares the functions your package will export for external use and the external functions your package will import from other packages.
  * `.gitignore` anticipates our usage of Git and ignores some standard R/RStudio stuff.
  * `foofactors.Rproj` is the file that makes this directory an RStudio Project. If you don't use RStudio, suppress its creation with `create(..., rstudio = FALSE)`.

### Put it under version control

Let's make this directory, which is already an RStudio Project and an R source package, into a Git repository, with `devtools::use_git()`.


```r
use_git()
#> * Initialising repo
#> * Adding .Rproj.user, .Rhistory, and .RData to .gitignore
#> * Adding files and committing
```

What's new? Only a `.git` directory, which will be hidden in most contexts, including the RStudio file browser. Its existence confirms we have indeed initialized a Git repo here.


```
#>      [,1]  
#> [1,] ".git"
```

Quit and relaunch RStudio in this Project, so that it is recognized as a Git repo and the Git tab becomes available in the Environment/History/Build pane. Click on History and you should see evidence of our initial commit:


```
#> [741cadb] 2015-11-17: Initial commit
```

FYI RStudio can also initialize a Git repository, in any Project, even if it's not an R package: *Tools > Version Control > Project Setup*. Then choose *Version control system: Git* and *initialize a new git repository for this project*. Then restart RStudio in the Project.

### Add your first function

Let's think of something annoying about factors ... hmmmm ... gee that's tough ... Let's catenate two factors.


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

There we go! Who expects that result? It's not my first rodeo, so I actually do.

Let's write `fbind()`, a function that creates a new factor from two factors:




```
fbind <- function(a, b) {
  factor(c(as.character(a), as.character(b)))
}
```

How do we check that it works? If this were a regular `.R` script or `.Rmd` file, we'd use our IDE to send this function definition to the R Console. Then we'd call `fbind(a, b)` to see what happens.

With `devtools`, the package development equivalent is to call `load_all()`:


```r
load_all()
#> Loading foofactors
```

Learn the keyboard and menu shortcuts for this:

  * Windows & Linux: Ctrl + Shift + L
  * Mac: Cmd + Shift + L
  * In Environment/History/Build/Git pane:
    - *Build > More > Load All*
  * From Build menu:
    - *Build > Load All*

This simulates the process of building and installing the `foofactors` package. Therefore it makes the `fbind()` function available to us, although not from the global workspace, where interactively defined objects live:


```r
exists("fbind", where = ".GlobalEnv", inherits = FALSE)
#> [1] FALSE
fbind(a, b)
#> [1] character hits      your      eyeballs  but       integer   where it 
#> [8] counts   
#> Levels: but character counts eyeballs hits integer where it your
```

We have written our first function, `fbind()`, to catenate two factors.

We have used `load_all()` to quickly make this function available, as if we'd built + installed `foofactors` and loaded via `library(foofactors)`.

We've tested it very informally.

We can all think of lots of ways to improve `fbind()`. Or maybe you can think of different functions that put out more urgent factor fires. That's why we have homework!

### Commit `fbind()`

Use you favorite method to commit the new `R/fbind.R` file.



Your most recent commit should look something like this:


```
#> [2c0e5c9] 2015-11-17: Add fbind()
```

### Build, Install, Check

OK `fbind()` works. How can we be even more sure that all the moving parts of the package still work? Sure, we've only added the one measly `fbind()`function. Humor me.

We could simply try to install and load the package and hope for the best. Recall this figure from [R Packages]():

![](https://raw.githubusercontent.com/hadley/r-pkgs/master/diagrams/installation.png)

We have to somehow move our source package through various stages to get it installed.

#### Base utilities

Even though we're going to use `devtools`, don't lean so heavily on it that you lose sight of how packages are actually built, checked, and installed. `devtools` is largely a convenience wrapper around base utilities.

The core utilities to know about:

  * [`R CMD build`](https://stat.ethz.ch/R-manual/R-patched/library/utils/html/PkgUtils.html) converts a source package to a bundle or tarball
  * [`R CMD INSTALL`](https://stat.ethz.ch/R-manual/R-patched/library/utils/html/INSTALL.html) installs a package bundle into a library
  * [`R CMD check`](https://stat.ethz.ch/R-manual/R-patched/library/utils/html/PkgUtils.html) runs all sorts of checks. Even if you don't plan to submit your package to CRAN, it's a very good idea to make this part of your own quality standard.
  
In a shell, with working directory set to the parent of `foofactors`, here's what usage might look like:

``` shell
R CMD build foofactors
R CMD check foofactors_0.0.0.9000.tar.gz
R CMD INSTALL foofactors_0.0.0.9000.tar.gz
```
#### `devtools` and RStudio

Luckily `devtools` and RStudio make these utilities very easy to get at.

At intermediate milestones, you should check your package:

  * From RStudio
    - *Build > Check*
  * In R Console
    - `check()`
    
**Read the output of the check!** Deal with problems early and often. It's just like incremental development of `.R` and `.Rmd`. The longer you go between full checks that everything works, the harder it is to pinpoint and solve your problems.

Just this once, run `check()` with `document = FALSE`, so we don't get ahead of ourselves. (Specifically, I don't want to mess with our `NAMESPACE` file yet.)

At this point, you should expect to get two warnings:

  * `Non-standard license specification`
  * `Undocumented code objects: ‘foo’`
  
We'll fix both soon.
    

```r
check(document = FALSE)
#> Setting env vars ----------------------------------------------------------
#> CFLAGS  : -Wall -pedantic
#> CXXFLAGS: -Wall -pedantic
#> Building foofactors -------------------------------------------------------
#> '/Library/Frameworks/R.framework/Resources/bin/R' --no-site-file  \
#>   --no-environ --no-save --no-restore CMD build  \
#>   '/Users/jenny/tmp/foofactors' --no-resave-data --no-manual 
#> 
#> Setting env vars ----------------------------------------------------------
#> _R_CHECK_CRAN_INCOMING_ : FALSE
#> _R_CHECK_FORCE_SUGGESTS_: FALSE
#> Checking foofactors -------------------------------------------------------
#> '/Library/Frameworks/R.framework/Resources/bin/R' --no-site-file  \
#>   --no-environ --no-save --no-restore CMD check  \
#>   '/var/folders/vt/4sdxy0rd1b3b65nqssx4sx_h0000gn/T//RtmpjE4dGo/foofactors_0.0.0.9000.tar.gz'  \
#>   --as-cran --timings
```

Once things look OK, you can install your very own `foofactors` package into your library:


```r
install()
#> Installing foofactors
#> '/Library/Frameworks/R.framework/Resources/bin/R' --no-site-file  \
#>   --no-environ --no-save --no-restore CMD INSTALL  \
#>   '/Users/jenny/tmp/foofactors'  \
#>   --library='/Users/jenny/resources/R/library' --install-tests 
#> 
#> Reloading installed foofactors
```

Now we can load `foofactors` just like a regular package and use it.

A shortcut for "build, install, and reload" is offered by RStudio:

  * *Build > Build & Reload*
  
#### Did it really work?

Now that we've installed `foofactors` properly, let's revisit our small example.


```r
library(foofactors)
a <- factor(c("character", "hits", "your", "eyeballs"))
b <- factor(c("but", "integer", "where it", "counts"))
fbind(a, b)
#> [1] character hits      your      eyeballs  but       integer   where it 
#> [8] counts   
#> Levels: but character counts eyeballs hits integer where it your
```

Success! That's enough for now.

In [part two](packages05_foofactors-package-02.html), we'll add more bells and whistles to the package.

back to [All the package things](packages00_index.html)





