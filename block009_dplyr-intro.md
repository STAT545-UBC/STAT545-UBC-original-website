# Introduction to dplyr



### Intro

`dplyr` is a new package for data manipulation. It is built to be fast, highly expressive, and open-minded about how your data is stored. It is developed by Hadley Wickham and Romain Francois.

`dplyr`'s roots are in an earlier, still-very-useful package called [`plyr`](http://plyr.had.co.nz), which implements the "split-apply-combine" strategy for data analysis. Where `plyr` covers a diverse set of inputs and outputs (e.g., arrays, data.frames, lists), `dplyr` has a laser-like focus on data.frames and related structures.

Have no idea what I'm talking about? Not sure if you care? If you use these base R functions: `subset()`, `apply()`, `[sl]apply()`, `tapply()`, `aggregate()`, `split()`, then you should keep reading.

#### Load `dplyr`


```r
## install if you do not already have

## from CRAN:
## install.packages('dplyr)

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
## 1 Afghanistan 1952  8425333      Asia   28.80     779.4
## 2 Afghanistan 1957  9240934      Asia   30.33     820.9
## 3 Afghanistan 1962 10267083      Asia   32.00     853.1
## 4 Afghanistan 1967 11537966      Asia   34.02     836.2
## 5 Afghanistan 1972 13079460      Asia   36.09     740.0
## 6 Afghanistan 1977 14880372      Asia   38.44     786.1
```

### Meet `tbl_df`, an upgrade to `data.frame`


```r
gtbl <- tbl_df(gdf)
gtbl
```

```
## Source: local data frame [1,704 x 6]
## 
##        country year      pop continent lifeExp gdpPercap
## 1  Afghanistan 1952  8425333      Asia   28.80     779.4
## 2  Afghanistan 1957  9240934      Asia   30.33     820.9
## 3  Afghanistan 1962 10267083      Asia   32.00     853.1
## 4  Afghanistan 1967 11537966      Asia   34.02     836.2
## 5  Afghanistan 1972 13079460      Asia   36.09     740.0
## 6  Afghanistan 1977 14880372      Asia   38.44     786.1
## 7  Afghanistan 1982 12881816      Asia   39.85     978.0
## 8  Afghanistan 1987 13867957      Asia   40.82     852.4
## 9  Afghanistan 1992 16317921      Asia   41.67     649.3
## 10 Afghanistan 1997 22227415      Asia   41.76     635.3
## ..         ...  ...      ...       ...     ...       ...
```

```r
glimpse(gtbl)
```

```
## Variables:
## $ country   (fctr) Afghanistan, Afghanistan, Afghanistan, Afghanistan,...
## $ year      (int) 1952, 1957, 1962, 1967, 1972, 1977, 1982, 1987, 1992...
## $ pop       (dbl) 8425333, 9240934, 10267083, 11537966, 13079460, 1488...
## $ continent (fctr) Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asi...
## $ lifeExp   (dbl) 28.80, 30.33, 32.00, 34.02, 36.09, 38.44, 39.85, 40....
## $ gdpPercap (dbl) 779.4, 820.9, 853.1, 836.2, 740.0, 786.1, 978.0, 852...
```

A `tbl_df` is basically an improved data.frame, where `plyr` includes some nice methods for high-level inspection. Specifically, these methods do something sensible for datasets with many observations and/or variables. You do __NOT__ need to turn your data.frames into `tbl_df`s to use `plyr`. I do so here for demonstration purposes only.

### Think before you create excerpts of your data ...

If you feel the urge to store a little snippet of your data:


```r
(snippet <- subset(gdf, country == "Canada"))
```

```
##     country year      pop continent lifeExp gdpPercap
## 241  Canada 1952 14785584  Americas   68.75     11367
## 242  Canada 1957 17010154  Americas   69.96     12490
## 243  Canada 1962 18985849  Americas   71.30     13462
## 244  Canada 1967 20819767  Americas   72.13     16077
## 245  Canada 1972 22284500  Americas   72.88     18971
## 246  Canada 1977 23796400  Americas   74.21     22091
## 247  Canada 1982 25201900  Americas   75.76     22899
## 248  Canada 1987 26549700  Americas   76.86     26627
## 249  Canada 1992 28523502  Americas   77.95     26343
## 250  Canada 1997 30305843  Americas   78.61     28955
## 251  Canada 2002 31902268  Americas   79.77     33329
## 252  Canada 2007 33390141  Americas   80.65     36319
```

Stop and ask yourself ...

> Do I want to create mini datasets for each level of some factor (or unique combination of several factors) ... in order to compute or graph something?  

If YES, __use proper data aggregation techniques__ or facetting in `ggplot2` plots or conditioning in `lattice` -- __don’t subset the data__. Or, more realistic, only subset the data as a temporary measure while you develop your elegant code for computing on or visualizing these data subsets.

If NO, then maybe you really do need to store a copy of a subset of the data. But seriously consider whether you can achieve your goals by simply using the `subset =` argument of, e.g., the `lm()` function, to limit computation to your excerpt of choice. Lots of functions offer a `subset =` argument! Copies and excerpts of your data clutter your workspace, invite mistakes, and sow general confusion. Avoid whenever possible.

Reality can also lie somewhere in between. You will find the workflows presented below can help you accomplish your goals with minimal creation of temporary, intermediate objects.

### Use `filter()` to subset data row-wise.

`filter()` takes logical expressions and returns the rows for which all are `TRUE`.


```r
filter(gtbl, lifeExp < 29)
```

```
## Source: local data frame [2 x 6]
## 
##       country year     pop continent lifeExp gdpPercap
## 1 Afghanistan 1952 8425333      Asia    28.8     779.4
## 2      Rwanda 1992 7290203    Africa    23.6     737.1
```

```r
filter(gtbl, country == "Rwanda")
```

```
## Source: local data frame [12 x 6]
## 
##    country year     pop continent lifeExp gdpPercap
## 1   Rwanda 1952 2534927    Africa   40.00     493.3
## 2   Rwanda 1957 2822082    Africa   41.50     540.3
## 3   Rwanda 1962 3051242    Africa   43.00     597.5
## 4   Rwanda 1967 3451079    Africa   44.10     511.0
## 5   Rwanda 1972 3992121    Africa   44.60     590.6
## 6   Rwanda 1977 4657072    Africa   45.00     670.1
## 7   Rwanda 1982 5507565    Africa   46.22     881.6
## 8   Rwanda 1987 6349365    Africa   44.02     848.0
## 9   Rwanda 1992 7290203    Africa   23.60     737.1
## 10  Rwanda 1997 7212583    Africa   36.09     589.9
## 11  Rwanda 2002 7852401    Africa   43.41     785.7
## 12  Rwanda 2007 8860588    Africa   46.24     863.1
```

```r
filter(gtbl, country %in% c("Rwanda", "Afghanistan"))
```

```
## Source: local data frame [24 x 6]
## 
##        country year      pop continent lifeExp gdpPercap
## 1  Afghanistan 1952  8425333      Asia   28.80     779.4
## 2  Afghanistan 1957  9240934      Asia   30.33     820.9
## 3  Afghanistan 1962 10267083      Asia   32.00     853.1
## 4  Afghanistan 1967 11537966      Asia   34.02     836.2
## 5  Afghanistan 1972 13079460      Asia   36.09     740.0
## 6  Afghanistan 1977 14880372      Asia   38.44     786.1
## 7  Afghanistan 1982 12881816      Asia   39.85     978.0
## 8  Afghanistan 1987 13867957      Asia   40.82     852.4
## 9  Afghanistan 1992 16317921      Asia   41.67     649.3
## 10 Afghanistan 1997 22227415      Asia   41.76     635.3
## 11 Afghanistan 2002 25268405      Asia   42.13     726.7
## 12 Afghanistan 2007 31889923      Asia   43.83     974.6
## 13      Rwanda 1952  2534927    Africa   40.00     493.3
## 14      Rwanda 1957  2822082    Africa   41.50     540.3
## 15      Rwanda 1962  3051242    Africa   43.00     597.5
## 16      Rwanda 1967  3451079    Africa   44.10     511.0
## 17      Rwanda 1972  3992121    Africa   44.60     590.6
## 18      Rwanda 1977  4657072    Africa   45.00     670.1
## 19      Rwanda 1982  5507565    Africa   46.22     881.6
## 20      Rwanda 1987  6349365    Africa   44.02     848.0
## 21      Rwanda 1992  7290203    Africa   23.60     737.1
## 22      Rwanda 1997  7212583    Africa   36.09     589.9
## 23      Rwanda 2002  7852401    Africa   43.41     785.7
## 24      Rwanda 2007  8860588    Africa   46.24     863.1
```

Compare with some base R code to accomplish the same things

```r
gdf[gdf$lifeExp < 29, ] ## repeat `gdf`, [i, j] indexing is distracting
subset(gdf, country == "Rwanda") ## almost same as filter ... but wait ...
```

### Meet the new pipe operator

Before we go any further, we should exploit the new pipe operator that `dplyr` imports from the [`magrittr`](https://github.com/smbache/magrittr) package. This is going to change your data analytical life. You no longer need to enact multi-operation commands by nesting them inside each other, like so many [Russian nesting dolls](http://blogue.us/wp-content/uploads/2009/07/Unknown-21.jpeg). This new syntax leads to code that is much easier to write and to read.

Here's what it looks like: `%>%`. The RStudio keyboard shortcut: alt-shift-. (Although [this tweet](https://twitter.com/rstudiotips/status/514094879316525058) makes me wonder if this is in flux?).

Let's demo then I'll explain:


```r
gdf %>% head
```

```
##       country year      pop continent lifeExp gdpPercap
## 1 Afghanistan 1952  8425333      Asia   28.80     779.4
## 2 Afghanistan 1957  9240934      Asia   30.33     820.9
## 3 Afghanistan 1962 10267083      Asia   32.00     853.1
## 4 Afghanistan 1967 11537966      Asia   34.02     836.2
## 5 Afghanistan 1972 13079460      Asia   36.09     740.0
## 6 Afghanistan 1977 14880372      Asia   38.44     786.1
```

The above is equivalent to `head(gdf)`. This pipe operator takes the thing on the left-hand-side and __pipes__ it into the function call on the right-hand-side -- literally, drops it in as the first argument.

Never fear, you can still specify other arguments to this function! To see the first 3 rows of Gapminder, we could say `head(gdf, 3)` or this:


```r
gdf %>% head(3)
```

```
##       country year      pop continent lifeExp gdpPercap
## 1 Afghanistan 1952  8425333      Asia   28.80     779.4
## 2 Afghanistan 1957  9240934      Asia   30.33     820.9
## 3 Afghanistan 1962 10267083      Asia   32.00     853.1
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
##    year lifeExp
## 1  1952   28.80
## 2  1957   30.33
## 3  1962   32.00
## 4  1967   34.02
## 5  1972   36.09
## 6  1977   38.44
## 7  1982   39.85
## 8  1987   40.82
## 9  1992   41.67
## 10 1997   41.76
## ..  ...     ...
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
##   year lifeExp
## 1 1952   28.80
## 2 1957   30.33
## 3 1962   32.00
## 4 1967   34.02
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
##    year lifeExp
## 1  1952   39.42
## 2  1957   41.37
## 3  1962   43.41
## 4  1967   45.41
## 5  1972   40.32
## 6  1977   31.22
## 7  1982   50.96
## 8  1987   53.91
## 9  1992   55.80
## 10 1997   56.53
## 11 2002   56.75
## 12 2007   59.72
```

and what a typical base R call would look like:


```r
gdf[gdf$country == "Cambodia", c("year", "lifeExp")]
```

```
##     year lifeExp
## 217 1952   39.42
## 218 1957   41.37
## 219 1962   43.41
## 220 1967   45.41
## 221 1972   40.32
## 222 1977   31.22
## 223 1982   50.96
## 224 1987   53.91
## 225 1992   55.80
## 226 1997   56.53
## 227 2002   56.75
## 228 2007   59.72
```

or, possibly?, a nicer look using base R's `subset()` function:


```r
subset(gdf, country == "Cambodia", select = c(year, lifeExp))
```

```
##     year lifeExp
## 217 1952   39.42
## 218 1957   41.37
## 219 1962   43.41
## 220 1967   45.41
## 221 1972   40.32
## 222 1977   31.22
## 223 1982   50.96
## 224 1987   53.91
## 225 1992   55.80
## 226 1997   56.53
## 227 2002   56.75
## 228 2007   59.72
```

### Pause to reflect

We've barely scratched the surface of `dplyr` but I want to point out key principles you may start to appreciate.

`dplyr`'s verbs, such as `filter()` and `select()`, are what's called [pure functions](http://en.wikipedia.org/wiki/Pure_function). To quote from Wickham's [Advanced R Programming book](http://adv-r.had.co.nz/Functions.html):

> The functions that are the easiest to understand and reason about are pure functions: functions that always map the same input to the same output and have no other impact on the workspace. In other words, pure functions have no side effects: they don’t affect the state of the world in any way apart from the value they return.

In fact, these verbs are a special case of pure functions: they take the same flavor of object as input and output. Namely, a data.frame or one of the other data receptacles `dplyr` supports. And finally, the data is __always__ the very first argument of the verb functions.

This set of deliberate design choices, together with the new pipe operator, produces a highly effective, low friction [domain-specific language](http://adv-r.had.co.nz/dsl.html) for data analysis.

Go to the next block, [`dplyr` functions for a single dataset](block010_dplyr-end-single-table.html), for more `dplyr`!

### Resources

`dplyr` official stuff

  * package home [on CRAN](http://cran.r-project.org/web/packages/dplyr/index.html)
    - note there are several vignettes, with the [introduction](http://cran.r-project.org/web/packages/dplyr/vignettes/introduction.html) being the most relevant right now
  * development home [on GitHub](https://github.com/hadley/dplyr)
  * [tutorial HW delivered](https://www.dropbox.com/sh/i8qnluwmuieicxc/AAAgt9tIKoIm7WZKIyK25lh6a) (note this links to a DropBox folder) at useR! 2014 conference

Blog post [Hands-on dplyr tutorial for faster data manipulation in R](http://www.dataschool.io/dplyr-tutorial-for-faster-data-manipulation-in-r/) by Data School, that includes a link to an R Markdown document and links to videos

[Cheatsheet](http://stat545-ubc.github.io/bit001_dplyr-cheatsheet.html) I made for `dplyr` join functions
