# Vectors versus tibbles



In STAT 545 and the Master of Data Science program, we teach data analysis starting with a clean data frame (or tibble), an excerpt of the [Gapminder](http://www.gapminder.org) data, from the [gapminder package](https://github.com/jennybc/gapminder). We study the tibble's extent and variable types. We practice filtering, selecting, arranging, summarizing, mutating, and visualizing.

Then we gradually start to reveal the more complicated operations needed to produce such clean data, which requires working with various types of atomic vectors in R, such as character or factor, and even with other data structures altogether, such as matrices or lists.

Two questions keep coming up:

  * Why are you showing me how to do things to vectors two different ways: as naked vectors and as vectors inside a data frame?
  * What's the general workflow for working on naked vectors vs vectors inside a data frame?

### Load packages

In our examples, we'll use various core tidyverse packages and stringr.


```r
library(tidyverse)
#> Loading tidyverse: ggplot2
#> Loading tidyverse: tibble
#> Loading tidyverse: tidyr
#> Loading tidyverse: readr
#> Loading tidyverse: purrr
#> Loading tidyverse: dplyr
#> Conflicts with tidy packages ----------------------------------------------
#> filter(): dplyr, stats
#> lag():    dplyr, stats
library(stringr)
```

### Vector operation example

Consider example `table3` from the `tidyr` package.


```r
table3
#> # A tibble: 6 × 3
#>       country  year              rate
#> *       <chr> <int>             <chr>
#> 1 Afghanistan  1999      745/19987071
#> 2 Afghanistan  2000     2666/20595360
#> 3      Brazil  1999   37737/172006362
#> 4      Brazil  2000   80488/174504898
#> 5       China  1999 212258/1272915272
#> 6       China  2000 213766/1280428583
```

It gives the rate of new tuberculosis cases for 3 countries in two years. But the `rate` variable needs to be split into the numerator and denominator and converted to numeric if we really want to work with this data, rather than just gaze upon it.

Here's one way to do that if you pull the `rate` variable out of the table via `$`.


```r
table3$rate %>%
  str_split_fixed(pattern = "/", n = 2)
#>      [,1]     [,2]        
#> [1,] "745"    "19987071"  
#> [2,] "2666"   "20595360"  
#> [3,] "37737"  "172006362" 
#> [4,] "80488"  "174504898" 
#> [5,] "212258" "1272915272"
#> [6,] "213766" "1280428583"
```

But now what? You've got a character matrix that is disassociated with `table3`. You've got more work to do before you can move on.

When a variable needs lots of remedial work, this workflow is justified and unavoidable. But in many cases, you can fix variables "in place" and work inside the original tibble.

### Tibble operation example

If we want to stay in the world of data frames or tibbles, we can get a much nicer result with `tidyr::separate()`.


```r
table3 %>% 
  separate(rate, into = c("cases", "population"), convert = TRUE)
#> # A tibble: 6 × 4
#>       country  year  cases population
#> *       <chr> <int>  <int>      <int>
#> 1 Afghanistan  1999    745   19987071
#> 2 Afghanistan  2000   2666   20595360
#> 3      Brazil  1999  37737  172006362
#> 4      Brazil  2000  80488  174504898
#> 5       China  1999 212258 1272915272
#> 6       China  2000 213766 1280428583
```

This gives us a modified version of `table3` but with `rate` removed and replaced by proper integer variables with the numerator (`cases`) and the denominator (`population`).

We are immediately ready to move on to further analysis or visualiation. When feasible, it is generally advisable to manipulate vectors inside the data frame where they live.

### Workarounds and failure

The above was a carefully chosen example, where the splitting functions existed in both settings. In general, you have more flexibility with operations for naked vectors than with vectors inside a tibble. Luckily there are many situations in which you can still manipulate a vector inside a tibble. Use `mutate()`!

Let's convert `country` from character to factor in `table1`, the tidy version of this example dataset:


```r
table1 %>% 
  mutate(country = factor(country))
#> # A tibble: 6 × 4
#>       country  year  cases population
#>        <fctr> <int>  <int>      <int>
#> 1 Afghanistan  1999    745   19987071
#> 2 Afghanistan  2000   2666   20595360
#> 3      Brazil  1999  37737  172006362
#> 4      Brazil  2000  80488  174504898
#> 5       China  1999 212258 1272915272
#> 6       China  2000 213766 1280428583
```

The `mutate()` strategy even works when multiple vectors form the necessary input to create a single new vector. Going backwards, we could re-create the vexing `rate` variable "by hand" from `cases` and `population`:


```r
table1 %>% 
  mutate(rate = paste(as.character(cases), as.character(population), sep = "/")) %>% 
  select(-cases, -population)
#> # A tibble: 6 × 3
#>       country  year              rate
#>         <chr> <int>             <chr>
#> 1 Afghanistan  1999      745/19987071
#> 2 Afghanistan  2000     2666/20595360
#> 3      Brazil  1999   37737/172006362
#> 4      Brazil  2000   80488/174504898
#> 5       China  1999 212258/1272915272
#> 6       China  2000 213766/1280428583
```

Finally, if it's easier for your development process, you can always pull a variable out, work on it, then put it back in. What if we were crazy and preferred to have the year given in Roman numerals?


```r
## make a copy so I don't mess with table1
tmp_df <- table1
## create working copy of the variable of interest
(tmp_var <- tmp_df$year)
#> [1] 1999 2000 1999 2000 1999 2000
## do my thing ...please just pretend it's way more complicated ;)
(tmp_var <- as.roman(tmp_var))
#> [1] MCMXCIX MM      MCMXCIX MM      MCMXCIX MM
## put it back into the tibble
tmp_df$year <- tmp_var
## admire our work
tmp_df
#> # A tibble: 6 × 4
#>       country        year  cases population
#>         <chr> <S3: roman>  <int>      <int>
#> 1 Afghanistan     MCMXCIX    745   19987071
#> 2 Afghanistan          MM   2666   20595360
#> 3      Brazil     MCMXCIX  37737  172006362
#> 4      Brazil          MM  80488  174504898
#> 5       China     MCMXCIX 212258 1272915272
#> 6       China          MM 213766 1280428583
```

Let's confront one genuinely fiddly scenario: what if you want to convert one (or more) existing variables into two (or more) new variables? And you aren't lucky enough to have the perfect function, like `tidyr::separate()`, available?

Unfortunately, `mutate()` doesn't do exactly what you'd want.


```r
table3 %>% 
  mutate(rate = str_split(rate, pattern = "/"))
#> # A tibble: 6 × 3
#>       country  year      rate
#>         <chr> <int>    <list>
#> 1 Afghanistan  1999 <chr [2]>
#> 2 Afghanistan  2000 <chr [2]>
#> 3      Brazil  1999 <chr [2]>
#> 4      Brazil  2000 <chr [2]>
#> 5       China  1999 <chr [2]>
#> 6       China  2000 <chr [2]>
```

Here the character strings with `cases`, and `population` are being stored as character vectors of length two inside a list-column, which is awkward to unpack.

You would be better off to apply `str_split()` outside the tibble, make that into a tibble, then column bind it back in.


```r
new_vars <- table3$rate %>%
  str_split_fixed(pattern = "/", n = 2) %>% 
  as_tibble()
colnames(new_vars) <- c("cases", "population")
new_vars
#> # A tibble: 6 × 2
#>    cases population
#>    <chr>      <chr>
#> 1    745   19987071
#> 2   2666   20595360
#> 3  37737  172006362
#> 4  80488  174504898
#> 5 212258 1272915272
#> 6 213766 1280428583
table3 %>% 
  select(-rate) %>% 
  bind_cols(new_vars)
#> # A tibble: 6 × 4
#>       country  year  cases population
#>         <chr> <int>  <chr>      <chr>
#> 1 Afghanistan  1999    745   19987071
#> 2 Afghanistan  2000   2666   20595360
#> 3      Brazil  1999  37737  172006362
#> 4      Brazil  2000  80488  174504898
#> 5       China  1999 212258 1272915272
#> 6       China  2000 213766 1280428583
```

One day, it's likely this will be easier (multi-mutate?) But we're not there yet.
