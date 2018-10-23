---
title: "When one tibble is not enough"
output:
  html_document:
    toc: true
    toc_depth: 4
---



We've covered many topics on how to manipulate and reshape a single data frame:

  * [Basic care and feeding of data in R](block006_care-feeding-data.html): data frames (and tibbles) are awesome.
  * [Introduction to dplyr](block009_dplyr-intro.html): filter, select, the pipe.
  * [dplyr functions for a single dataset](block010_dplyr-end-single-table.html): single table verbs.
  * [Tidy data using Lord of the Rings](https://github.com/jennybc/lotr-tidy#readme): tidy data, tidyr. *This actually kicks off with a row bind operation, discussed below.*

But what if your data arrives in many pieces? There are many good (and bad) reasons why this might happen. How do you get it into one big beautiful tibble? These tasks break down into 3 main classes:

  * Bind
  * Join
  * Lookup

### Typology of data combination tasks

**Bind** This is basically smashing ~~rocks~~ tibbles together. You can smash things together row-wise ("row binding") or column-wise ("column binding"). Why do I characterize this as rock-smashing? They're often fairly crude operations, with lots of responsibility falling on the analyst for making sure that the whole enterprise even makes sense.

When row binding, you need to consider the variables in the two tibbles. Do the same variables exist in each? Are they of the same type? Different approaches for row binding have different combinations of flexibility vs rigidity around these matters.

When column binding, the onus is entirely on the analyst to make sure that the rows are aligned. I would avoid column binding whenever possible. If you can introduce new variables through any other, safer means, do so! By safer, I mean: use a mechanism where the row alignment is correct **by definition**. A proper join is the gold standard. In addition to joins, functions like `dplyr::mutate()` and `tidyr::separate()` can be very useful for forcing yourself to work inside the constraint of a tibble.

**Join** Here you designate a variable (or a combination of variables) as a **key**. A row in one data frame gets matched with a row in another data frame because they have the same key. You can then bring information from variables in a secondary data frame into a primary data frame based on this key-based lookup. That description is incredibly oversimplified, but that's the basic idea.

A variety of row- and column-wise operations fit into this framework, which implies there are many different flavors of join. The concepts and vocabulary around joins come from the database world. The relevant functions in dplyr follow this convention and all mention `join`. The most relevant base R function is `merge()`.

**Lookup** Lookups are really just a special case of join. But it's a special case worth making for two reasons:

  * If you've ever used `LOOKUP()` and friends in Excel, you already have a mental model for this. Let's exploit that!
  * Joins are defined in terms of two tables or data frames. But sometimes this task has a "vector" vibe. You might be creating a vector or variable. Or maybe the secondary data source is a named vector. In any case, there's at least one vector in the mix. I call that a lookup.

Let's explore each type of operation with a few examples.

First, let's load the tidyverse (and expose version information).


```r
library(tidyverse)
#> ── Attaching packages ─────────────────────────────────────────────── tidyverse 1.2.1 ──
#> ✔ ggplot2 3.0.0           ✔ purrr   0.2.5      
#> ✔ tibble  1.4.99.9005     ✔ dplyr   0.7.7      
#> ✔ tidyr   0.8.1           ✔ stringr 1.3.1      
#> ✔ readr   1.1.1           ✔ forcats 0.3.0
#> ── Conflicts ────────────────────────────────────────────────── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()
```

### Bind

#### Row binding

We used word count data from the Lord of the Rings trilogy to explore the concept of tidy data. That kicked off with a quiet, successful row bind. Let's revisit that.

Here's what a perfect row bind of three (untidy!) data frames looks like.


```r
fship <- tribble(
                         ~Film,    ~Race, ~Female, ~Male,
  "The Fellowship Of The Ring",    "Elf",    1229,   971,
  "The Fellowship Of The Ring", "Hobbit",      14,  3644,
  "The Fellowship Of The Ring",    "Man",       0,  1995
)
rking <- tribble(
                         ~Film,    ~Race, ~Female, ~Male,
      "The Return Of The King",    "Elf",     183,   510,
      "The Return Of The King", "Hobbit",       2,  2673,
      "The Return Of The King",    "Man",     268,  2459
)
ttow <- tribble(
                         ~Film,    ~Race, ~Female, ~Male,
              "The Two Towers",    "Elf",     331,   513,
              "The Two Towers", "Hobbit",       0,  2463,
              "The Two Towers",    "Man",     401,  3589
)
(lotr_untidy <- bind_rows(fship, ttow, rking))
#> # A tibble: 9 x 4
#>   Film                       Race   Female  Male
#>   <chr>                      <chr>   <dbl> <dbl>
#> 1 The Fellowship Of The Ring Elf      1229   971
#> 2 The Fellowship Of The Ring Hobbit     14  3644
#> 3 The Fellowship Of The Ring Man         0  1995
#> 4 The Two Towers             Elf       331   513
#> 5 The Two Towers             Hobbit      0  2463
#> 6 The Two Towers             Man       401  3589
#> 7 The Return Of The King     Elf       183   510
#> 8 The Return Of The King     Hobbit      2  2673
#> 9 The Return Of The King     Man       268  2459
```

`dplyr::bind_rows()` works like a charm with these very row-bindable data frames! So does base `rbind()` (try it!).

But what if one of the data frames is somehow missing a variable? Let's mangle one and find out.


```r
ttow_no_Female <- ttow %>% mutate(Female = NULL)
bind_rows(fship, ttow_no_Female, rking)
#> # A tibble: 9 x 4
#>   Film                       Race   Female  Male
#>   <chr>                      <chr>   <dbl> <dbl>
#> 1 The Fellowship Of The Ring Elf      1229   971
#> 2 The Fellowship Of The Ring Hobbit     14  3644
#> 3 The Fellowship Of The Ring Man         0  1995
#> 4 The Two Towers             Elf        NA   513
#> 5 The Two Towers             Hobbit     NA  2463
#> 6 The Two Towers             Man        NA  3589
#> 7 The Return Of The King     Elf       183   510
#> 8 The Return Of The King     Hobbit      2  2673
#> 9 The Return Of The King     Man       268  2459
rbind(fship, ttow_no_Female, rking)
#> Error in rbind(deparse.level, ...): numbers of columns of arguments do not match
```

We see that `dplyr::bind_rows()` does the row bind and puts `NA` in for the missing values caused by the lack of `Female` data from The Two Towers. Base `rbind()` refuses to row bind in this situation.

I invite you to experiment with other realistic, challenging scenarios, e.g.:

  * Change the order of variables. Does row binding match variables by name or position?
  * Row bind data frames where the variable `x` is of one type in one data frame and another type in the other. Try combinations that you think should work and some that should not. What actually happens?
  * Row bind data frames in which the factor `x` has different levels in one data frame and different levels in the other. What happens?
  
In conclusion, row binding usually works when it should (especially with `dplyr::bind_rows()`) and usually doesn't when it shouldn't. The biggest risk is being aggravated.

#### Column binding

Column binding is much more dangerous because it often "works" when it should not. It's **your job** to the rows are aligned and it's all too easy to screw this up.

The data in `gapminder` was originally excavated from 3 messy Excel spreadsheets: one each for life expectancy, population, and GDP per capital. Let's relive some of the data wrangling joy and show a column bind gone wrong.

I create 3 separate data frames, do some evil row sorting, then column bind. There are no errors. The result `gapminder_garbage` sort of looks OK. Univariate summary statistics and exploratory plots will look OK. But I've created complete nonsense!


```r
library(gapminder)

life_exp <- gapminder %>%
  select(country, year, lifeExp)

pop <- gapminder %>%
  arrange(year) %>% 
  select(pop)
  
gdp_percap <- gapminder %>% 
  arrange(pop) %>% 
  select(gdpPercap)

(gapminder_garbage <- bind_cols(life_exp, pop, gdp_percap))
#> # A tibble: 1,704 x 5
#>    country      year lifeExp      pop gdpPercap
#>    <fct>       <int>   <dbl>    <int>     <dbl>
#>  1 Afghanistan  1952    28.8  8425333      880.
#>  2 Afghanistan  1957    30.3  1282697      861.
#>  3 Afghanistan  1962    32.0  9279525     2670.
#>  4 Afghanistan  1967    34.0  4232095     1072.
#>  5 Afghanistan  1972    36.1 17876956     1385.
#>  6 Afghanistan  1977    38.4  8691212     2865.
#>  7 Afghanistan  1982    39.9  6927772     1533.
#>  8 Afghanistan  1987    40.8   120447     1738.
#>  9 Afghanistan  1992    41.7 46886859     3021.
#> 10 Afghanistan  1997    41.8  8730405     1890.
#> # … with 1,694 more rows

summary(gapminder$lifeExp)
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#>   23.60   48.20   60.71   59.47   70.85   82.60
summary(gapminder_garbage$lifeExp)
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#>   23.60   48.20   60.71   59.47   70.85   82.60
range(gapminder$gdpPercap)
#> [1]    241.1659 113523.1329
range(gapminder_garbage$gdpPercap)
#> [1]    241.1659 113523.1329
```

One last cautionary tale about column binding. This one requires the use of `cbind()` and it's why the tidyverse is generally unwilling to recycle when combining things of different length.

I create a tibble with most of the `gapminder` columns. I create another with the remainder, but filtered down to just one country. I am able to `cbind()` these objects! Why? Because the 12 rows for Canada divide evenly into the 1704 rows of `gapminder`. Note that `dplyr::bind_cols()` refuses to column bind here.


```r
gapminder_mostly <- gapminder %>% select(-pop, -gdpPercap)
gapminder_leftovers_filtered <- gapminder %>% 
  filter(country == "Canada") %>% 
  select(pop, gdpPercap)

gapminder_nonsense <- cbind(gapminder_mostly, gapminder_leftovers_filtered)
head(gapminder_nonsense, 14)
#>        country continent year lifeExp      pop gdpPercap
#> 1  Afghanistan      Asia 1952  28.801 14785584  11367.16
#> 2  Afghanistan      Asia 1957  30.332 17010154  12489.95
#> 3  Afghanistan      Asia 1962  31.997 18985849  13462.49
#> 4  Afghanistan      Asia 1967  34.020 20819767  16076.59
#> 5  Afghanistan      Asia 1972  36.088 22284500  18970.57
#> 6  Afghanistan      Asia 1977  38.438 23796400  22090.88
#> 7  Afghanistan      Asia 1982  39.854 25201900  22898.79
#> 8  Afghanistan      Asia 1987  40.822 26549700  26626.52
#> 9  Afghanistan      Asia 1992  41.674 28523502  26342.88
#> 10 Afghanistan      Asia 1997  41.763 30305843  28954.93
#> 11 Afghanistan      Asia 2002  42.129 31902268  33328.97
#> 12 Afghanistan      Asia 2007  43.828 33390141  36319.24
#> 13     Albania    Europe 1952  55.230 14785584  11367.16
#> 14     Albania    Europe 1957  59.280 17010154  12489.95
```

This data frame isn't obviously wrong, but it is wrong. See how the Canada's population and GDP per capita repeat for each country?

Bottom line: Row bind when you need to, but inspect the results re: coercion. Column bind only if you must and be extremely paranoid.

### Join

Visit the [dplyr join cheatsheet](bit001_dplyr-cheatsheet.html) to see concrete examples of all the joins implemented in dplyr, based on comic characters and publishers.

The most recent release of gapminder includes a new data frame, `country_codes`, with country names and ISO codes. Therefore you can also use it to practice joins.


```r
gapminder %>% 
  select(country, continent) %>% 
  group_by(country) %>% 
  slice(1) %>% 
  left_join(country_codes)
#> Joining, by = "country"
#> Warning: Column `country` joining factor and character vector, coercing
#> into character vector
#> # A tibble: 142 x 4
#> # Groups:   country [?]
#>    country     continent iso_alpha iso_num
#>    <chr>       <fct>     <chr>       <int>
#>  1 Afghanistan Asia      AFG             4
#>  2 Albania     Europe    ALB             8
#>  3 Algeria     Africa    DZA            12
#>  4 Angola      Africa    AGO            24
#>  5 Argentina   Americas  ARG            32
#>  6 Australia   Oceania   AUS            36
#>  7 Austria     Europe    AUT            40
#>  8 Bahrain     Asia      BHR            48
#>  9 Bangladesh  Asia      BGD            50
#> 10 Belgium     Europe    BEL            56
#> # … with 132 more rows
```

### Lookup

See this resource for examples: [Table look up](bit008_lookup.html).
