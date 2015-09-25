# Introduction to dplyr



### Intro

`dplyr` is a new package for data manipulation. It is built to be fast, highly expressive, and open-minded about how your data is stored. It is developed by Hadley Wickham and Romain Francois.

`dplyr`'s roots are in an earlier, still-very-useful package called [`plyr`](http://plyr.had.co.nz), which implements the "split-apply-combine" strategy for data analysis. Where `plyr` covers a diverse set of inputs and outputs (e.g., arrays, data.frames, lists), `dplyr` has a laser-like focus on data.frames and related structures.

Have no idea what I'm talking about? Not sure if you care? If you use these base R functions: `subset()`, `apply()`, `[sl]apply()`, `tapply()`, `aggregate()`, `split()`, `do.call()`, then you should keep reading.

#### Load `dplyr`


```r
## install if you do not already have

## from CRAN:
## install.packages('dplyr')

## from GitHub using devtools (which you also might need to install!):
## devtools::install_github("hadley/lazyeval")
## devtools::install_github("hadley/dplyr")
suppressPackageStartupMessages(library(dplyr))
```

#### Load the Gapminder data

An excerpt of the Gapminder data which we work with alot.


```r
gd_url <- "http://tiny.cc/gapminder"
gdf <- read.delim(file = gd_url)
str(gdf)
```

```
## 'data.frame':	1704 obs. of  6 variables:
##  $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
##  $ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
##  $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
##  $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
##  $ gdpPercap: num  779 821 853 836 740 ...
```

```r
head(gdf)
```

```
##       country year      pop continent lifeExp gdpPercap
## 1 Afghanistan 1952  8425333      Asia  28.801  779.4453
## 2 Afghanistan 1957  9240934      Asia  30.332  820.8530
## 3 Afghanistan 1962 10267083      Asia  31.997  853.1007
## 4 Afghanistan 1967 11537966      Asia  34.020  836.1971
## 5 Afghanistan 1972 13079460      Asia  36.088  739.9811
## 6 Afghanistan 1977 14880372      Asia  38.438  786.1134
```

### Meet `tbl_df`, an upgrade to `data.frame`


```r
gtbl <- tbl_df(gdf)
gtbl
```

```
## Source: local data frame [1,704 x 6]
## 
##        country  year      pop continent lifeExp gdpPercap
##         (fctr) (int)    (dbl)    (fctr)   (dbl)     (dbl)
## 1  Afghanistan  1952  8425333      Asia  28.801  779.4453
## 2  Afghanistan  1957  9240934      Asia  30.332  820.8530
## 3  Afghanistan  1962 10267083      Asia  31.997  853.1007
## 4  Afghanistan  1967 11537966      Asia  34.020  836.1971
## 5  Afghanistan  1972 13079460      Asia  36.088  739.9811
## 6  Afghanistan  1977 14880372      Asia  38.438  786.1134
## 7  Afghanistan  1982 12881816      Asia  39.854  978.0114
## 8  Afghanistan  1987 13867957      Asia  40.822  852.3959
## 9  Afghanistan  1992 16317921      Asia  41.674  649.3414
## 10 Afghanistan  1997 22227415      Asia  41.763  635.3414
## ..         ...   ...      ...       ...     ...       ...
```

```r
glimpse(gtbl)
```

```
## Observations: 1,704
## Variables: 6
## $ country   (fctr) Afghanistan, Afghanistan, Afghanistan, Afghanistan,...
## $ year      (int) 1952, 1957, 1962, 1967, 1972, 1977, 1982, 1987, 1992...
## $ pop       (dbl) 8425333, 9240934, 10267083, 11537966, 13079460, 1488...
## $ continent (fctr) Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asi...
## $ lifeExp   (dbl) 28.801, 30.332, 31.997, 34.020, 36.088, 38.438, 39.8...
## $ gdpPercap (dbl) 779.4453, 820.8530, 853.1007, 836.1971, 739.9811, 78...
```

A `tbl_df` is basically an improved data.frame, for which `dplyr` provides nice methods for high-level inspection. Specifically, these methods do something sensible for datasets with many observations and/or variables. You do __NOT__ need to turn your data.frames into `tbl_df`s to use `plyr`. I do so here for demonstration purposes only.

### Think before you create excerpts of your data ...

If you feel the urge to store a little snippet of your data:


```r
(snippet <- subset(gdf, country == "Canada"))
```

```
##     country year      pop continent lifeExp gdpPercap
## 241  Canada 1952 14785584  Americas  68.750  11367.16
## 242  Canada 1957 17010154  Americas  69.960  12489.95
## 243  Canada 1962 18985849  Americas  71.300  13462.49
## 244  Canada 1967 20819767  Americas  72.130  16076.59
## 245  Canada 1972 22284500  Americas  72.880  18970.57
## 246  Canada 1977 23796400  Americas  74.210  22090.88
## 247  Canada 1982 25201900  Americas  75.760  22898.79
## 248  Canada 1987 26549700  Americas  76.860  26626.52
## 249  Canada 1992 28523502  Americas  77.950  26342.88
## 250  Canada 1997 30305843  Americas  78.610  28954.93
## 251  Canada 2002 31902268  Americas  79.770  33328.97
## 252  Canada 2007 33390141  Americas  80.653  36319.24
```

Stop and ask yourself ...

> Do I want to create mini datasets for each level of some factor (or unique combination of several factors) ... in order to compute or graph something?  

If YES, __use proper data aggregation techniques__ or facetting in `ggplot2` plots or conditioning in `lattice` -- __don’t subset the data__. Or, more realistic, only subset the data as a temporary measure while you develop your elegant code for computing on or visualizing these data subsets.

If NO, then maybe you really do need to store a copy of a subset of the data. But seriously consider whether you can achieve your goals by simply using the `subset =` argument of, e.g., the `lm()` function, to limit computation to your excerpt of choice. Lots of functions offer a `subset =` argument!

Copies and excerpts of your data clutter your workspace, invite mistakes, and sow general confusion. Avoid whenever possible.

Reality can also lie somewhere in between. You will find the workflows presented below can help you accomplish your goals with minimal creation of temporary, intermediate objects.

### Use `filter()` to subset data row-wise.

`filter()` takes logical expressions and returns the rows for which all are `TRUE`.


```r
filter(gtbl, lifeExp < 29)
```

```
## Source: local data frame [2 x 6]
## 
##       country  year     pop continent lifeExp gdpPercap
##        (fctr) (int)   (dbl)    (fctr)   (dbl)     (dbl)
## 1 Afghanistan  1952 8425333      Asia  28.801  779.4453
## 2      Rwanda  1992 7290203    Africa  23.599  737.0686
```

```r
filter(gtbl, country == "Rwanda")
```

```
## Source: local data frame [12 x 6]
## 
##    country  year     pop continent lifeExp gdpPercap
##     (fctr) (int)   (dbl)    (fctr)   (dbl)     (dbl)
## 1   Rwanda  1952 2534927    Africa  40.000  493.3239
## 2   Rwanda  1957 2822082    Africa  41.500  540.2894
## 3   Rwanda  1962 3051242    Africa  43.000  597.4731
## 4   Rwanda  1967 3451079    Africa  44.100  510.9637
## 5   Rwanda  1972 3992121    Africa  44.600  590.5807
## 6   Rwanda  1977 4657072    Africa  45.000  670.0806
## 7   Rwanda  1982 5507565    Africa  46.218  881.5706
## 8   Rwanda  1987 6349365    Africa  44.020  847.9912
## 9   Rwanda  1992 7290203    Africa  23.599  737.0686
## 10  Rwanda  1997 7212583    Africa  36.087  589.9445
## 11  Rwanda  2002 7852401    Africa  43.413  785.6538
## 12  Rwanda  2007 8860588    Africa  46.242  863.0885
```

```r
filter(gtbl, country %in% c("Rwanda", "Afghanistan"))
```

```
## Source: local data frame [24 x 6]
## 
##        country  year      pop continent lifeExp gdpPercap
##         (fctr) (int)    (dbl)    (fctr)   (dbl)     (dbl)
## 1  Afghanistan  1952  8425333      Asia  28.801  779.4453
## 2  Afghanistan  1957  9240934      Asia  30.332  820.8530
## 3  Afghanistan  1962 10267083      Asia  31.997  853.1007
## 4  Afghanistan  1967 11537966      Asia  34.020  836.1971
## 5  Afghanistan  1972 13079460      Asia  36.088  739.9811
## 6  Afghanistan  1977 14880372      Asia  38.438  786.1134
## 7  Afghanistan  1982 12881816      Asia  39.854  978.0114
## 8  Afghanistan  1987 13867957      Asia  40.822  852.3959
## 9  Afghanistan  1992 16317921      Asia  41.674  649.3414
## 10 Afghanistan  1997 22227415      Asia  41.763  635.3414
## ..         ...   ...      ...       ...     ...       ...
```

Compare with some base R code to accomplish the same things

```r
gdf[gdf$lifeExp < 29, ] ## repeat `gdf`, [i, j] indexing is distracting
subset(gdf, country == "Rwanda") ## almost same as filter ... but wait ...
```

### Meet the new pipe operator

Before we go any further, we should exploit the new pipe operator that `dplyr` imports from the [`magrittr`](https://github.com/smbache/magrittr) package. This is going to change your data analytical life. You no longer need to enact multi-operation commands by nesting them inside each other, like so many [Russian nesting dolls](http://blogue.us/wp-content/uploads/2009/07/Unknown-21.jpeg). This new syntax leads to code that is much easier to write and to read.

Here's what it looks like: `%>%`. The RStudio keyboard shortcut: Ctrl + Shift + M (Windows), Cmd + Shift + M (Mac), according to [this tweet](https://twitter.com/rstudiotips/status/514094879316525058).

<!-- alt-shift-. works for me but I'm not running bleeding edge RStudio -->

Let's demo then I'll explain:


```r
gdf %>% head
```

```
##       country year      pop continent lifeExp gdpPercap
## 1 Afghanistan 1952  8425333      Asia  28.801  779.4453
## 2 Afghanistan 1957  9240934      Asia  30.332  820.8530
## 3 Afghanistan 1962 10267083      Asia  31.997  853.1007
## 4 Afghanistan 1967 11537966      Asia  34.020  836.1971
## 5 Afghanistan 1972 13079460      Asia  36.088  739.9811
## 6 Afghanistan 1977 14880372      Asia  38.438  786.1134
```

This is equivalent to `head(gdf)`. This pipe operator takes the thing on the left-hand-side and __pipes__ it into the function call on the right-hand-side -- literally, drops it in as the first argument.

Never fear, you can still specify other arguments to this function! To see the first 3 rows of Gapminder, we could say `head(gdf, 3)` or this:


```r
gdf %>% head(3)
```

```
##       country year      pop continent lifeExp gdpPercap
## 1 Afghanistan 1952  8425333      Asia  28.801  779.4453
## 2 Afghanistan 1957  9240934      Asia  30.332  820.8530
## 3 Afghanistan 1962 10267083      Asia  31.997  853.1007
```

I've advised you to think "gets" whenever you see the assignment operator, `<-`. Similary, you should think "then" whenever you see the pipe operator, `%>%`.

You are probably not impressed yet, but the magic will soon happen.

### Use `select()` to subset the data on variables or columns.

Back to `dplyr` ...

Use `select()` to subset the data on variables or columns. Here's a conventional call:


```r
select(gtbl, year, lifeExp) ## tbl_df prevents TMI from printing
```

```
## Source: local data frame [1,704 x 2]
## 
##     year lifeExp
##    (int)   (dbl)
## 1   1952  28.801
## 2   1957  30.332
## 3   1962  31.997
## 4   1967  34.020
## 5   1972  36.088
## 6   1977  38.438
## 7   1982  39.854
## 8   1987  40.822
## 9   1992  41.674
## 10  1997  41.763
## ..   ...     ...
```

And here's similar operation, but written with the pipe operator and piped through `head`:

```r
gtbl %>%
  select(year, lifeExp) %>%
  head(4)
```

```
## Source: local data frame [4 x 2]
## 
##    year lifeExp
##   (int)   (dbl)
## 1  1952  28.801
## 2  1957  30.332
## 3  1962  31.997
## 4  1967  34.020
```

Think: "Take `gtbl`, then select the variables year and lifeExp, then show the first 4 rows."

### Revel in the convenience

Here's the data for Cambodia, but only certain variables:


```r
gtbl %>%
  filter(country == "Cambodia") %>%
  select(year, lifeExp)
```

```
## Source: local data frame [12 x 2]
## 
##     year lifeExp
##    (int)   (dbl)
## 1   1952  39.417
## 2   1957  41.366
## 3   1962  43.415
## 4   1967  45.415
## 5   1972  40.317
## 6   1977  31.220
## 7   1982  50.957
## 8   1987  53.914
## 9   1992  55.803
## 10  1997  56.534
## 11  2002  56.752
## 12  2007  59.723
```

and what a typical base R call would look like:


```r
gdf[gdf$country == "Cambodia", c("year", "lifeExp")]
```

```
##     year lifeExp
## 217 1952  39.417
## 218 1957  41.366
## 219 1962  43.415
## 220 1967  45.415
## 221 1972  40.317
## 222 1977  31.220
## 223 1982  50.957
## 224 1987  53.914
## 225 1992  55.803
## 226 1997  56.534
## 227 2002  56.752
## 228 2007  59.723
```

or, possibly?, a nicer look using base R's `subset()` function:


```r
subset(gdf, country == "Cambodia", select = c(year, lifeExp))
```

```
##     year lifeExp
## 217 1952  39.417
## 218 1957  41.366
## 219 1962  43.415
## 220 1967  45.415
## 221 1972  40.317
## 222 1977  31.220
## 223 1982  50.957
## 224 1987  53.914
## 225 1992  55.803
## 226 1997  56.534
## 227 2002  56.752
## 228 2007  59.723
```

### Pause to reflect

We've barely scratched the surface of `dplyr` but I want to point out key principles you may start to appreciate. If you're new to R or "programing with data", feel free skip this section and [move on](block010_dplyr-end-single-table.html).

`dplyr`'s verbs, such as `filter()` and `select()`, are what's called [pure functions](http://en.wikipedia.org/wiki/Pure_function). To quote from Wickham's [Advanced R Programming book](http://adv-r.had.co.nz/Functions.html):

> The functions that are the easiest to understand and reason about are pure functions: functions that always map the same input to the same output and have no other impact on the workspace. In other words, pure functions have no side effects: they don’t affect the state of the world in any way apart from the value they return.

In fact, these verbs are a special case of pure functions: they take the same flavor of object as input and output. Namely, a data.frame or one of the other data receptacles `dplyr` supports. And finally, the data is __always__ the very first argument of the verb functions.

This set of deliberate design choices, together with the new pipe operator, produces a highly effective, low friction [domain-specific language](http://adv-r.had.co.nz/dsl.html) for data analysis.

Go to the next block, [`dplyr` functions for a single dataset](block010_dplyr-end-single-table.html), for more `dplyr`!

### Resources

`dplyr` official stuff

  * package home [on CRAN](http://cran.r-project.org/web/packages/dplyr/index.html)
    - note there are several vignettes, with the [introduction](http://cran.r-project.org/web/packages/dplyr/vignettes/introduction.html) being the most relevant right now
    - the [one on window functions](http://cran.rstudio.com/web/packages/dplyr/vignettes/window-functions.html) will also be interesting to you now
  * development home [on GitHub](https://github.com/hadley/dplyr)
  * [tutorial HW delivered](https://www.dropbox.com/sh/i8qnluwmuieicxc/AAAgt9tIKoIm7WZKIyK25lh6a) (note this links to a DropBox folder) at useR! 2014 conference

Blog post [Hands-on dplyr tutorial for faster data manipulation in R](http://www.dataschool.io/dplyr-tutorial-for-faster-data-manipulation-in-r/) by Data School, that includes a link to an R Markdown document and links to videos

[Cheatsheet](bit001_dplyr-cheatsheet.html) I made for `dplyr` join functions (not relevant yet but soon)
