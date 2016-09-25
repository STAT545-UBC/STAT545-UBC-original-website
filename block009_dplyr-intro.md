# Introduction to dplyr



### Intro

`dplyr` is a package for data manipulation, developed by Hadley Wickham and Romain Francois. It is built to be fast, highly expressive, and open-minded about how your data is stored. It is installed as part of the the [`tidyverse`](https://github.com/hadley/tidyverse) meta-package and, as a core package, it is among those loaded via `library(tidyverse)`.

`dplyr`'s roots are in an earlier package called [`plyr`](http://plyr.had.co.nz), which implements the ["split-apply-combine" strategy for data analysis](https://www.jstatsoft.org/article/view/v040i01) (PDF). Where `plyr` covers a diverse set of inputs and outputs (e.g., arrays, data frames, lists), `dplyr` has a laser-like focus on data frames or, in the `tidyverse`, "tibbles". `dplyr` is a package-level treament of the `ddply()` function from `plyr`, because "data frame in, data frame out" proved to be so incredibly important.

Have no idea what I'm talking about? Not sure if you care? If you use these base R functions: `subset()`, `apply()`, `[sl]apply()`, `tapply()`, `aggregate()`, `split()`, `do.call()`, `with()`, `within()`, then you should keep reading. Also, if you use `for()` loops alot, you might enjoy learning other ways to iterate over rows or groups of rows or variables in a data frame.

#### Load `dplyr` and `gapminder`

I choose to load the `tidyverse`, which will load `dplyr`, among other packages we use incidentally below. Also load `gapminder`.


```r
library(gapminder)
library(tidyverse)
```

```
## Loading tidyverse: ggplot2
## Loading tidyverse: tibble
## Loading tidyverse: tidyr
## Loading tidyverse: readr
## Loading tidyverse: purrr
## Loading tidyverse: dplyr
```

```
## Conflicts with tidy packages ----------------------------------------------
```

```
## filter(): dplyr, stats
## lag():    dplyr, stats
```

#### Say hello to the Gapminder tibble

The `gapminder` data frame is a special kind of data frame: a tibble.


```r
gapminder
```

```
## # A tibble: 1,704 × 6
##        country continent  year lifeExp      pop gdpPercap
##         <fctr>    <fctr> <int>   <dbl>    <int>     <dbl>
## 1  Afghanistan      Asia  1952  28.801  8425333  779.4453
## 2  Afghanistan      Asia  1957  30.332  9240934  820.8530
## 3  Afghanistan      Asia  1962  31.997 10267083  853.1007
## 4  Afghanistan      Asia  1967  34.020 11537966  836.1971
## 5  Afghanistan      Asia  1972  36.088 13079460  739.9811
## 6  Afghanistan      Asia  1977  38.438 14880372  786.1134
## 7  Afghanistan      Asia  1982  39.854 12881816  978.0114
## 8  Afghanistan      Asia  1987  40.822 13867957  852.3959
## 9  Afghanistan      Asia  1992  41.674 16317921  649.3414
## 10 Afghanistan      Asia  1997  41.763 22227415  635.3414
## # ... with 1,694 more rows
```

It's tibble-ness is why we get nice compact printing. For a reminder of the problems with base data frame printing, go type `iris` in the R Console or, better yet, print a data frame to screen that has lots of columns.

Note how gapminder's `class()` includes `tbl_df`; the "tibble" terminology is a nod to this.


```r
class(gapminder)
```

```
## [1] "tbl_df"     "tbl"        "data.frame"
```

There will be some functions, like `print()`, that know about tibbles and do something special. There will others that do not, like `summary()`. In which case the regular data frame treatment will happen, because every tibble is also a regular data frame.

To turn any data frame into a tibble use `as_tibble()`:


```r
as_tibble(iris)
```

```
## # A tibble: 150 × 5
##    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
##           <dbl>       <dbl>        <dbl>       <dbl>  <fctr>
## 1           5.1         3.5          1.4         0.2  setosa
## 2           4.9         3.0          1.4         0.2  setosa
## 3           4.7         3.2          1.3         0.2  setosa
## 4           4.6         3.1          1.5         0.2  setosa
## 5           5.0         3.6          1.4         0.2  setosa
## 6           5.4         3.9          1.7         0.4  setosa
## 7           4.6         3.4          1.4         0.3  setosa
## 8           5.0         3.4          1.5         0.2  setosa
## 9           4.4         2.9          1.4         0.2  setosa
## 10          4.9         3.1          1.5         0.1  setosa
## # ... with 140 more rows
```

### Think before you create excerpts of your data ...

If you feel the urge to store a little snippet of your data:


```r
(canada <- gapminder[241:252, ])
```

```
## # A tibble: 12 × 6
##    country continent  year lifeExp      pop gdpPercap
##     <fctr>    <fctr> <int>   <dbl>    <int>     <dbl>
## 1   Canada  Americas  1952  68.750 14785584  11367.16
## 2   Canada  Americas  1957  69.960 17010154  12489.95
## 3   Canada  Americas  1962  71.300 18985849  13462.49
## 4   Canada  Americas  1967  72.130 20819767  16076.59
## 5   Canada  Americas  1972  72.880 22284500  18970.57
## 6   Canada  Americas  1977  74.210 23796400  22090.88
## 7   Canada  Americas  1982  75.760 25201900  22898.79
## 8   Canada  Americas  1987  76.860 26549700  26626.52
## 9   Canada  Americas  1992  77.950 28523502  26342.88
## 10  Canada  Americas  1997  78.610 30305843  28954.93
## 11  Canada  Americas  2002  79.770 31902268  33328.97
## 12  Canada  Americas  2007  80.653 33390141  36319.24
```

Stop and ask yourself ...

> Do I want to create mini datasets for each level of some factor (or unique combination of several factors) ... in order to compute or graph something?  

If YES, __use proper data aggregation techniques__ or facetting in `ggplot2` -- __don’t subset the data__. Or, more realistic, only subset the data as a temporary measure while you develop your elegant code for computing on or visualizing these data subsets.

If NO, then maybe you really do need to store a copy of a subset of the data. But seriously consider whether you can achieve your goals by simply using the `subset =` argument of, e.g., the `lm()` function, to limit computation to your excerpt of choice. Lots of functions offer a `subset =` argument!

Copies and excerpts of your data clutter your workspace, invite mistakes, and sow general confusion. Avoid whenever possible.

Reality can also lie somewhere in between. You will find the workflows presented below can help you accomplish your goals with minimal creation of temporary, intermediate objects.

### Use `filter()` to subset data row-wise.

`filter()` takes logical expressions and returns the rows for which all are `TRUE`.


```r
filter(gapminder, lifeExp < 29)
```

```
## # A tibble: 2 × 6
##       country continent  year lifeExp     pop gdpPercap
##        <fctr>    <fctr> <int>   <dbl>   <int>     <dbl>
## 1 Afghanistan      Asia  1952  28.801 8425333  779.4453
## 2      Rwanda    Africa  1992  23.599 7290203  737.0686
```

```r
filter(gapminder, country == "Rwanda", year > 1979)
```

```
## # A tibble: 6 × 6
##   country continent  year lifeExp     pop gdpPercap
##    <fctr>    <fctr> <int>   <dbl>   <int>     <dbl>
## 1  Rwanda    Africa  1982  46.218 5507565  881.5706
## 2  Rwanda    Africa  1987  44.020 6349365  847.9912
## 3  Rwanda    Africa  1992  23.599 7290203  737.0686
## 4  Rwanda    Africa  1997  36.087 7212583  589.9445
## 5  Rwanda    Africa  2002  43.413 7852401  785.6538
## 6  Rwanda    Africa  2007  46.242 8860588  863.0885
```

```r
filter(gapminder, country %in% c("Rwanda", "Afghanistan"))
```

```
## # A tibble: 24 × 6
##        country continent  year lifeExp      pop gdpPercap
##         <fctr>    <fctr> <int>   <dbl>    <int>     <dbl>
## 1  Afghanistan      Asia  1952  28.801  8425333  779.4453
## 2  Afghanistan      Asia  1957  30.332  9240934  820.8530
## 3  Afghanistan      Asia  1962  31.997 10267083  853.1007
## 4  Afghanistan      Asia  1967  34.020 11537966  836.1971
## 5  Afghanistan      Asia  1972  36.088 13079460  739.9811
## 6  Afghanistan      Asia  1977  38.438 14880372  786.1134
## 7  Afghanistan      Asia  1982  39.854 12881816  978.0114
## 8  Afghanistan      Asia  1987  40.822 13867957  852.3959
## 9  Afghanistan      Asia  1992  41.674 16317921  649.3414
## 10 Afghanistan      Asia  1997  41.763 22227415  635.3414
## # ... with 14 more rows
```

Compare with some base R code to accomplish the same things

```r
gapminder[gapminder$lifeExp < 29, ] ## repeat `gapminder`, [i, j] indexing is distracting
subset(gapminder, country == "Rwanda") ## almost same as filter; quite nice actually
```

Under no circumstances should you subset your data the way I did at first:


```r
excerpt <- gapminder[241:252, ]
```

Why is this a terrible idea?

  * It is not self-documenting. What is so special about rows 241 through 252?
  * It is fragile. This line of code will produce different results if someone changes the row order of `gapminder`, e.g. sorts the data earlier in the script.
  

```r
filter(gapminder, country == "Canada")
```

This call explains itself and is fairly robust.

### Meet the new pipe operator

Before we go any further, we should exploit the new pipe operator that the tidyverse imports from the [`magrittr`](https://github.com/smbache/magrittr) package by Stefan Bache. This is going to change your data analytical life. You no longer need to enact multi-operation commands by nesting them inside each other, like so many [Russian nesting dolls](http://blogue.us/wp-content/uploads/2009/07/Unknown-21.jpeg). This new syntax leads to code that is much easier to write and to read.

Here's what it looks like: `%>%`. The RStudio keyboard shortcut: Ctrl + Shift + M (Windows), Cmd + Shift + M (Mac).

Let's demo then I'll explain:


```r
gapminder %>% head()
```

```
## # A tibble: 6 × 6
##       country continent  year lifeExp      pop gdpPercap
##        <fctr>    <fctr> <int>   <dbl>    <int>     <dbl>
## 1 Afghanistan      Asia  1952  28.801  8425333  779.4453
## 2 Afghanistan      Asia  1957  30.332  9240934  820.8530
## 3 Afghanistan      Asia  1962  31.997 10267083  853.1007
## 4 Afghanistan      Asia  1967  34.020 11537966  836.1971
## 5 Afghanistan      Asia  1972  36.088 13079460  739.9811
## 6 Afghanistan      Asia  1977  38.438 14880372  786.1134
```

This is equivalent to `head(gapminder)`. The pipe operator takes the thing on the left-hand-side and __pipes__ it into the function call on the right-hand-side -- literally, drops it in as the first argument.

Never fear, you can still specify other arguments to this function! To see the first 3 rows of Gapminder, we could say `head(gapminder, 3)` or this:


```r
gapminder %>% head(3)
```

```
## # A tibble: 3 × 6
##       country continent  year lifeExp      pop gdpPercap
##        <fctr>    <fctr> <int>   <dbl>    <int>     <dbl>
## 1 Afghanistan      Asia  1952  28.801  8425333  779.4453
## 2 Afghanistan      Asia  1957  30.332  9240934  820.8530
## 3 Afghanistan      Asia  1962  31.997 10267083  853.1007
```

I've advised you to think "gets" whenever you see the assignment operator, `<-`. Similary, you should think "then" whenever you see the pipe operator, `%>%`.

You are probably not impressed yet, but the magic will soon happen.

### Use `select()` to subset the data on variables or columns.

Back to `dplyr` ...

Use `select()` to subset the data on variables or columns. Here's a conventional call:


```r
select(gapminder, year, lifeExp)
```

```
## # A tibble: 1,704 × 2
##     year lifeExp
##    <int>   <dbl>
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
## # ... with 1,694 more rows
```

And here's the same operation, but written with the pipe operator and piped through `head()`:

```r
gapminder %>%
  select(year, lifeExp) %>%
  head(4)
```

```
## # A tibble: 4 × 2
##    year lifeExp
##   <int>   <dbl>
## 1  1952  28.801
## 2  1957  30.332
## 3  1962  31.997
## 4  1967  34.020
```

Think: "Take `gapminder`, then select the variables year and lifeExp, then show the first 4 rows."

### Revel in the convenience

Here's the data for Cambodia, but only certain variables:


```r
gapminder %>%
  filter(country == "Cambodia") %>%
  select(year, lifeExp)
```

```
## # A tibble: 12 × 2
##     year lifeExp
##    <int>   <dbl>
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
gapminder[gapminder$country == "Cambodia", c("year", "lifeExp")]
```

```
## # A tibble: 12 × 2
##     year lifeExp
##    <int>   <dbl>
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

### Pure, predictable, pipeable

We've barely scratched the surface of `dplyr` but I want to point out key principles you may start to appreciate. If you're new to R or "programming with data", feel free skip this section and [move on](block010_dplyr-end-single-table.html).

`dplyr`'s verbs, such as `filter()` and `select()`, are what's called [pure functions](http://en.wikipedia.org/wiki/Pure_function). To quote from Wickham's [Advanced R Programming book](http://adv-r.had.co.nz/Functions.html):

> The functions that are the easiest to understand and reason about are pure functions: functions that always map the same input to the same output and have no other impact on the workspace. In other words, pure functions have no side effects: they don’t affect the state of the world in any way apart from the value they return.

In fact, these verbs are a special case of pure functions: they take the same flavor of object as input and output. Namely, a data frame or one of the other data receptacles `dplyr` supports.

And finally, the data is __always__ the very first argument of the verb functions.

This set of deliberate design choices, together with the new pipe operator, produces a highly effective, low friction [domain-specific language](http://adv-r.had.co.nz/dsl.html) for data analysis.

Go to the next block, [`dplyr` functions for a single dataset](block010_dplyr-end-single-table.html), for more `dplyr`!

### Resources

`dplyr` official stuff

  * package home [on CRAN](http://cran.r-project.org/web/packages/dplyr/index.html)
    - note there are several vignettes, with the [introduction](http://cran.r-project.org/web/packages/dplyr/vignettes/introduction.html) being the most relevant right now
    - the [one on window functions](http://cran.rstudio.com/web/packages/dplyr/vignettes/window-functions.html) will also be interesting to you now
  * development home [on GitHub](https://github.com/hadley/dplyr)
  * [tutorial HW delivered](https://www.dropbox.com/sh/i8qnluwmuieicxc/AAAgt9tIKoIm7WZKIyK25lh6a) (note this links to a DropBox folder) at useR! 2014 conference

[RStudio Data Wrangling cheatsheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf), covering `dplyr` and `tidyr`. Remember you can get to these via *Help > Cheatsheets.* 

[Excellent slides](https://github.com/tjmahr/MadR_Pipelines) on pipelines and `dplyr` by TJ Mahr, talk given to the Madison R Users Group.

Blog post [Hands-on dplyr tutorial for faster data manipulation in R](http://www.dataschool.io/dplyr-tutorial-for-faster-data-manipulation-in-r/) by Data School, that includes a link to an R Markdown document and links to videos

[Cheatsheet](bit001_dplyr-cheatsheet.html) I made for `dplyr` join functions (not relevant yet but soon)
