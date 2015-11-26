# dplyr functions for a single dataset



### Where were we?

In the [introduction to `plyr`](block009_dplyr-intro.html), we used two very important verbs and an operator:

  * `filter()` for subsetting data row-wise
  * `select()` for subsetting data variable- or column-wise
  * the pipe operator `%>%`, which feeds the LHS as the first argument to the expression on the RHS
  
Here we explore other `dplyr` functions, especially more verbs, for working with a single dataset.

#### Load `dplyr` and the Gapminder data

We use an excerpt of the Gapminder data and store it as a `tbl_df` object, basically an enhanced data.frame


```r
suppressPackageStartupMessages(library(dplyr))
library(gapminder)
gtbl <- gapminder %>%
  tbl_df
gtbl %>%
  glimpse
```

```
## Observations: 1,704
## Variables: 6
## $ country   (fctr) Afghanistan, Afghanistan, Afghanistan, Afghanistan,...
## $ continent (fctr) Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asi...
## $ year      (dbl) 1952, 1957, 1962, 1967, 1972, 1977, 1982, 1987, 1992...
## $ lifeExp   (dbl) 28.801, 30.332, 31.997, 34.020, 36.088, 38.438, 39.8...
## $ pop       (dbl) 8425333, 9240934, 10267083, 11537966, 13079460, 1488...
## $ gdpPercap (dbl) 779.4453, 820.8530, 853.1007, 836.1971, 739.9811, 78...
```

### Use `mutate()` to add new variables

Imagine we wanted to recover each country's GDP. After all, the Gapminder data has a variable for population and GDP per capita. Let's multiply them together.


```r
gtbl <- gtbl %>%
  mutate(gdp = pop * gdpPercap)
gtbl %>%
  glimpse
```

```
## Observations: 1,704
## Variables: 7
## $ country   (fctr) Afghanistan, Afghanistan, Afghanistan, Afghanistan,...
## $ continent (fctr) Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asi...
## $ year      (dbl) 1952, 1957, 1962, 1967, 1972, 1977, 1982, 1987, 1992...
## $ lifeExp   (dbl) 28.801, 30.332, 31.997, 34.020, 36.088, 38.438, 39.8...
## $ pop       (dbl) 8425333, 9240934, 10267083, 11537966, 13079460, 1488...
## $ gdpPercap (dbl) 779.4453, 820.8530, 853.1007, 836.1971, 739.9811, 78...
## $ gdp       (dbl) 6567086330, 7585448670, 8758855797, 9648014150, 9678...
```

Hmmmm ... those GDP numbers are almost uselessly large and abstract. Consider the [advice of Randall Munroe of xkcd](http://fivethirtyeight.com/datalab/xkcd-randall-munroe-qanda-what-if/): "One thing that bothers me is large numbers presented without context... 'If I added a zero to this number, would the sentence containing it mean something different to me?' If the answer is 'no,' maybe the number has no business being in the sentence in the first place." Maybe it would be more meaningful to consumers of my tables and figures if I reported GDP per capita, *relative to some benchmark country*. Since Canada is my adopted home, I'll go with that.


```r
just_canada <- gtbl %>%
  filter(country == "Canada")
## this is a dangerous way to add this variable
## doing it this way so we don't get too fancy yet
gtbl <- gtbl %>%
  mutate(canada = rep(just_canada$gdpPercap, nlevels(country)),
         gdpPercapRel = gdpPercap / canada)
gtbl %>%
  select(country, year, gdpPercap, canada, gdpPercapRel)
```

```
## Source: local data frame [1,704 x 5]
## 
##        country  year gdpPercap   canada gdpPercapRel
##         (fctr) (dbl)     (dbl)    (dbl)        (dbl)
## 1  Afghanistan  1952  779.4453 11367.16   0.06856992
## 2  Afghanistan  1957  820.8530 12489.95   0.06572108
## 3  Afghanistan  1962  853.1007 13462.49   0.06336874
## 4  Afghanistan  1967  836.1971 16076.59   0.05201335
## 5  Afghanistan  1972  739.9811 18970.57   0.03900679
## 6  Afghanistan  1977  786.1134 22090.88   0.03558542
## 7  Afghanistan  1982  978.0114 22898.79   0.04271018
## 8  Afghanistan  1987  852.3959 26626.52   0.03201305
## 9  Afghanistan  1992  649.3414 26342.88   0.02464959
## 10 Afghanistan  1997  635.3414 28954.93   0.02194243
## ..         ...   ...       ...      ...          ...
```

```r
gtbl %>%
  select(gdpPercapRel) %>%
  summary
```

```
##   gdpPercapRel     
##  Min.   :0.007236  
##  1st Qu.:0.061648  
##  Median :0.171521  
##  Mean   :0.326659  
##  3rd Qu.:0.446564  
##  Max.   :9.534690
```

Note that, `mutate()` builds new variables sequentially so you can reference earlier ones (like `canada`) when defining later ones (like `gdpPercapRel`).

The relative GDP per capita numbers are, in general, well below 1. We see that most of the countries covered by this dataset have substantially lower GDP per capita, relative to Canada, across the entire time period.

### Use `arrange()` to row-order data in a principled way

Imagine you wanted this data ordered by year then country, as opposed to by country then year.


```r
gtbl %>%
  arrange(year, country)
```

```
## Source: local data frame [1,704 x 9]
## 
##        country continent  year lifeExp      pop  gdpPercap          gdp
##         (fctr)    (fctr) (dbl)   (dbl)    (dbl)      (dbl)        (dbl)
## 1  Afghanistan      Asia  1952  28.801  8425333   779.4453   6567086330
## 2      Albania    Europe  1952  55.230  1282697  1601.0561   2053669902
## 3      Algeria    Africa  1952  43.077  9279525  2449.0082  22725632678
## 4       Angola    Africa  1952  30.015  4232095  3520.6103  14899557133
## 5    Argentina  Americas  1952  62.485 17876956  5911.3151 105676319105
## 6    Australia   Oceania  1952  69.120  8691212 10039.5956  87256254102
## 7      Austria    Europe  1952  66.800  6927772  6137.0765  42516266683
## 8      Bahrain      Asia  1952  50.939   120447  9867.0848   1188460759
## 9   Bangladesh      Asia  1952  37.484 46886859   684.2442  32082059995
## 10     Belgium    Europe  1952  68.000  8730405  8343.1051  72838686716
## ..         ...       ...   ...     ...      ...        ...          ...
## Variables not shown: canada (dbl), gdpPercapRel (dbl)
```

Or maybe you want just the data from 2007, sorted on life expectancy?


```r
gtbl %>%
  filter(year == 2007) %>%
  arrange(lifeExp)
```

```
## Source: local data frame [142 x 9]
## 
##                     country continent  year lifeExp      pop gdpPercap
##                      (fctr)    (fctr) (dbl)   (dbl)    (dbl)     (dbl)
## 1                 Swaziland    Africa  2007  39.613  1133066 4513.4806
## 2                Mozambique    Africa  2007  42.082 19951656  823.6856
## 3                    Zambia    Africa  2007  42.384 11746035 1271.2116
## 4              Sierra Leone    Africa  2007  42.568  6144562  862.5408
## 5                   Lesotho    Africa  2007  42.592  2012649 1569.3314
## 6                    Angola    Africa  2007  42.731 12420476 4797.2313
## 7                  Zimbabwe    Africa  2007  43.487 12311143  469.7093
## 8               Afghanistan      Asia  2007  43.828 31889923  974.5803
## 9  Central African Republic    Africa  2007  44.741  4369038  706.0165
## 10                  Liberia    Africa  2007  45.678  3193942  414.5073
## ..                      ...       ...   ...     ...      ...       ...
## Variables not shown: gdp (dbl), canada (dbl), gdpPercapRel (dbl)
```

Oh, you'd like to sort on life expectancy in __desc__ending order? Then use `desc()`.


```r
gtbl %>%
  filter(year == 2007) %>%
  arrange(desc(lifeExp))
```

```
## Source: local data frame [142 x 9]
## 
##             country continent  year lifeExp       pop gdpPercap
##              (fctr)    (fctr) (dbl)   (dbl)     (dbl)     (dbl)
## 1             Japan      Asia  2007  82.603 127467972  31656.07
## 2  Hong Kong, China      Asia  2007  82.208   6980412  39724.98
## 3           Iceland    Europe  2007  81.757    301931  36180.79
## 4       Switzerland    Europe  2007  81.701   7554661  37506.42
## 5         Australia   Oceania  2007  81.235  20434176  34435.37
## 6             Spain    Europe  2007  80.941  40448191  28821.06
## 7            Sweden    Europe  2007  80.884   9031088  33859.75
## 8            Israel      Asia  2007  80.745   6426679  25523.28
## 9            France    Europe  2007  80.657  61083916  30470.02
## 10           Canada  Americas  2007  80.653  33390141  36319.24
## ..              ...       ...   ...     ...       ...       ...
## Variables not shown: gdp (dbl), canada (dbl), gdpPercapRel (dbl)
```

I advise that your analyses NEVER rely on rows or variables being in a specific order. But it's still true that human beings write the code and the interactive development process can be much nicer if you reorder the rows of your data as you go along. Also, once you are preparing tables for human eyeballs, it is imperative that you step up and take control of row order.

### Use `rename()` to rename variables

When I first cleaned this Gapminder excerpt, I was a [`camelCase`](http://en.wikipedia.org/wiki/CamelCase) person, but now I'm all about [`snake_case`](http://en.wikipedia.org/wiki/Snake_case). So I am vexed by the variable names I chose when I cleaned this data years ago. Let's rename some variables!


```r
gtbl %>%
  rename(life_exp = lifeExp,
         gdp_percap = gdpPercap,
         gdp_percap_rel = gdpPercapRel)
```

```
## Source: local data frame [1,704 x 9]
## 
##        country continent  year life_exp      pop gdp_percap         gdp
##         (fctr)    (fctr) (dbl)    (dbl)    (dbl)      (dbl)       (dbl)
## 1  Afghanistan      Asia  1952   28.801  8425333   779.4453  6567086330
## 2  Afghanistan      Asia  1957   30.332  9240934   820.8530  7585448670
## 3  Afghanistan      Asia  1962   31.997 10267083   853.1007  8758855797
## 4  Afghanistan      Asia  1967   34.020 11537966   836.1971  9648014150
## 5  Afghanistan      Asia  1972   36.088 13079460   739.9811  9678553274
## 6  Afghanistan      Asia  1977   38.438 14880372   786.1134 11697659231
## 7  Afghanistan      Asia  1982   39.854 12881816   978.0114 12598563401
## 8  Afghanistan      Asia  1987   40.822 13867957   852.3959 11820990309
## 9  Afghanistan      Asia  1992   41.674 16317921   649.3414 10595901589
## 10 Afghanistan      Asia  1997   41.763 22227415   635.3414 14121995875
## ..         ...       ...   ...      ...      ...        ...         ...
## Variables not shown: canada (dbl), gdp_percap_rel (dbl)
```

I did NOT assign the post-rename object back to `gtbl` because that would make the chunks in this tutorial harder to copy/paste and run out of order. In real life, I would probably assign this back to `gtbl`, in a data preparation script, and proceed with the new variable names.

### `group_by()` is a mighty weapon

I have found ~~friends and family~~ collaborators love to ask seemingly innocuous questions like, "which country experienced the sharpest 5-year drop in life expectancy?". In fact, that is a totally natural question to ask. But if you are using a language that doesn't know about data, it's an incredibly annoying question to answer.

`dplyr` offers powerful tools to solve this class of problem.

  * `group_by()` adds extra structure to your dataset -- grouping information -- which lays the groundwork for computations within the groups.
  * `summarize()` takes a dataset with $n$ observations, computes requested summaries, and returns a dataset with 1 observation.
  * window functions take a dataset with $n$ observations and return a dataset with $n$ observations.
  * `do()` is the most general function you will use in a grouped data situation.
  
Combined with the verbs you already know, these new tools allow you to solve an extremely diverse set of problems with relative ease.

#### Counting things up

Let's start with simple counting.  How many observations do we have per continent?


```r
gtbl %>%
  group_by(continent) %>%
  summarize(n_obs = n())
```

```
## Source: local data frame [5 x 2]
## 
##   continent n_obs
##      (fctr) (int)
## 1    Africa   624
## 2  Americas   300
## 3      Asia   396
## 4    Europe   360
## 5   Oceania    24
```

The `tally()` function is a convenience function for this sort of thing.


```r
gtbl %>%
  group_by(continent) %>%
  tally
```

```
## Source: local data frame [5 x 2]
## 
##   continent     n
##      (fctr) (int)
## 1    Africa   624
## 2  Americas   300
## 3      Asia   396
## 4    Europe   360
## 5   Oceania    24
```

What if we wanted to add the number of unique countries for each continent?


```r
gtbl %>%
  group_by(continent) %>%
  summarize(n_obs = n(),
            n_countries = n_distinct(country))
```

```
## Source: local data frame [5 x 3]
## 
##   continent n_obs n_countries
##      (fctr) (int)       (int)
## 1    Africa   624          52
## 2  Americas   300          25
## 3      Asia   396          33
## 4    Europe   360          30
## 5   Oceania    24           2
```

#### General summarization

The functions you'll apply within `summarize()` include classical statistical summaries, like `mean()`, `median()`, `sd()`, and `IQR`. Remember they are functions that take $n$ inputs and distill them down into 1 output.

Although this may be statistically ill-advised, let's compute the average life expectancy by continent.


```r
gtbl %>%
  group_by(continent) %>%
  summarize(avg_lifeExp = mean(lifeExp))
```

```
## Source: local data frame [5 x 2]
## 
##   continent avg_lifeExp
##      (fctr)       (dbl)
## 1    Africa    48.86533
## 2  Americas    64.65874
## 3      Asia    60.06490
## 4    Europe    71.90369
## 5   Oceania    74.32621
```

`summarize_each()` applies the same summary function(s) to multiple variables. Let's compute average and median life expectancy and GDP per capita by continent by year ... but only for 1952 and 2007.


```r
gtbl %>%
  filter(year %in% c(1952, 2007)) %>%
  group_by(continent, year) %>%
  summarise_each(funs(mean, median), lifeExp, gdpPercap)
```

```
## Source: local data frame [10 x 6]
## Groups: continent [?]
## 
##    continent  year lifeExp_mean gdpPercap_mean lifeExp_median
##       (fctr) (dbl)        (dbl)          (dbl)          (dbl)
## 1     Africa  1952     39.13550       1252.572        38.8330
## 2     Africa  2007     54.80604       3089.033        52.9265
## 3   Americas  1952     53.27984       4079.063        54.7450
## 4   Americas  2007     73.60812      11003.032        72.8990
## 5       Asia  1952     46.31439       5195.484        44.8690
## 6       Asia  2007     70.72848      12473.027        72.3960
## 7     Europe  1952     64.40850       5661.057        65.9000
## 8     Europe  2007     77.64860      25054.482        78.6085
## 9    Oceania  1952     69.25500      10298.086        69.2550
## 10   Oceania  2007     80.71950      29810.188        80.7195
## Variables not shown: gdpPercap_median (dbl)
```

Let's focus just on Asia. What are the minimum and maximum life expectancies seen by year?

```r
gtbl %>%
  filter(continent == "Asia") %>%
  group_by(year) %>%
  summarize(min_lifeExp = min(lifeExp), max_lifeExp = max(lifeExp))
```

```
## Source: local data frame [12 x 3]
## 
##     year min_lifeExp max_lifeExp
##    (dbl)       (dbl)       (dbl)
## 1   1952      28.801      65.390
## 2   1957      30.332      67.840
## 3   1962      31.997      69.390
## 4   1967      34.020      71.430
## 5   1972      36.088      73.420
## 6   1977      31.220      75.380
## 7   1982      39.854      77.110
## 8   1987      40.822      78.670
## 9   1992      41.674      79.360
## 10  1997      41.763      80.690
## 11  2002      42.129      82.000
## 12  2007      43.828      82.603
```

Of course it would be much more interesting to see *which* country contributed these extreme observations. Is the minimum (maximum) always coming from the same country? That's where window functions come in.

#### Window functions

Recall that window functions take $n$ inputs and give back $n$ outputs. Here we use window functions based on ranks and offsets.

Let's revisit the worst and best life expectancies in Asia over time, but retaining info about *which* country contributes these extreme values.


```r
gtbl %>%
  filter(continent == "Asia") %>%
  select(year, country, lifeExp) %>%
  arrange(year) %>%
  group_by(year) %>%
  filter(min_rank(desc(lifeExp)) < 2 | min_rank(lifeExp) < 2)
```

```
## Source: local data frame [24 x 3]
## Groups: year [12]
## 
##     year     country lifeExp
##    (dbl)      (fctr)   (dbl)
## 1   1952 Afghanistan  28.801
## 2   1952      Israel  65.390
## 3   1957 Afghanistan  30.332
## 4   1957      Israel  67.840
## 5   1962 Afghanistan  31.997
## 6   1962      Israel  69.390
## 7   1967 Afghanistan  34.020
## 8   1967       Japan  71.430
## 9   1972 Afghanistan  36.088
## 10  1972       Japan  73.420
## ..   ...         ...     ...
```

We see that (min = Agfhanistan, max = Japan) is the most frequent result, but Cambodia and Israel pop up at least once each as the min or max, respectively. That table should make you impatient for our upcoming work on tidying and reshaping data! Wouldn't it be nice to have one row per year?

How did that actually work? First, I store and view the result including everything but the last `filter()` statement. All of these operations are familiar.


```r
asia <- gtbl %>%
  filter(continent == "Asia") %>%
  select(year, country, lifeExp) %>%
  arrange(year) %>%
  group_by(year)
asia
```

```
## Source: local data frame [396 x 3]
## Groups: year [12]
## 
##     year          country lifeExp
##    (dbl)           (fctr)   (dbl)
## 1   1952      Afghanistan  28.801
## 2   1952          Bahrain  50.939
## 3   1952       Bangladesh  37.484
## 4   1952         Cambodia  39.417
## 5   1952            China  44.000
## 6   1952 Hong Kong, China  60.960
## 7   1952            India  37.373
## 8   1952        Indonesia  37.468
## 9   1952             Iran  44.869
## 10  1952             Iraq  45.320
## ..   ...              ...     ...
```

Now we apply a window function -- `min_rank()`. Since `asia` is grouped by year, `min_rank()` operates within mini-datasets, each for a specific year. Applied to the variable `lifeExp`, `min_rank()` returns the rank of each country's observed life expectancy. FYI, the `min` part just specifies how ties are broken. Here is an explicit peek at these within-year life expectancy ranks, in both the (default) ascending and descending order.


```r
asia %>%
  mutate(le_rank = min_rank(lifeExp),
         le_desc_rank = min_rank(desc(lifeExp)))
```

```
## Source: local data frame [396 x 5]
## Groups: year [12]
## 
##     year          country lifeExp le_rank le_desc_rank
##    (dbl)           (fctr)   (dbl)   (int)        (int)
## 1   1952      Afghanistan  28.801       1           33
## 2   1952          Bahrain  50.939      25            9
## 3   1952       Bangladesh  37.484       7           27
## 4   1952         Cambodia  39.417       9           25
## 5   1952            China  44.000      16           18
## 6   1952 Hong Kong, China  60.960      31            3
## 7   1952            India  37.373       5           29
## 8   1952        Indonesia  37.468       6           28
## 9   1952             Iran  44.869      17           17
## 10  1952             Iraq  45.320      18           16
## ..   ...              ...     ...     ...          ...
```

You can understand the original `filter()` statement now:


```r
filter(min_rank(desc(lifeExp)) < 2 | min_rank(lifeExp) < 2)
```

These two sets of ranks are formed, within year group, and `filter()` retains rows with rank less than 2, which means ... the row with rank = 1. Since we do for ascending and descending ranks, we get both the min and the max.

If we had wanted just the min OR the max, an alternative approach using `top_n()` would have worked.

```r
gtbl %>%
  filter(continent == "Asia") %>%
  select(year, country, lifeExp) %>%
  arrange(year) %>%
  group_by(year) %>%
  #top_n(1)               ## gets the min
  top_n(1, desc(lifeExp)) ## gets the max
```

```
## Source: local data frame [12 x 3]
## Groups: year [12]
## 
##     year     country lifeExp
##    (dbl)      (fctr)   (dbl)
## 1   1952 Afghanistan  28.801
## 2   1957 Afghanistan  30.332
## 3   1962 Afghanistan  31.997
## 4   1967 Afghanistan  34.020
## 5   1972 Afghanistan  36.088
## 6   1977    Cambodia  31.220
## 7   1982 Afghanistan  39.854
## 8   1987 Afghanistan  40.822
## 9   1992 Afghanistan  41.674
## 10  1997 Afghanistan  41.763
## 11  2002 Afghanistan  42.129
## 12  2007 Afghanistan  43.828
```

#### Grand Finale

So let's answer that "simple" question: which country experienced the sharpest 5-year drop in life expectancy? Recall that this excerpt of the Gapminder data only has data every five years, e.g. for 1952, 1957, etc. So this really means looking at life expectancy changes between adjacent timepoints.

At this point, that's just too easy, so let's do it by continent while we're at it.


```r
gtbl %>%
  group_by(continent, country) %>%
  select(country, year, continent, lifeExp) %>%
  mutate(le_delta = lifeExp - lag(lifeExp)) %>%
  summarize(worst_le_delta = min(le_delta, na.rm = TRUE)) %>%
  filter(min_rank(worst_le_delta) < 2) %>%
  arrange(worst_le_delta)
```

```
## Source: local data frame [5 x 3]
## Groups: continent [5]
## 
##   continent     country worst_le_delta
##      (fctr)      (fctr)          (dbl)
## 1    Africa      Rwanda        -20.421
## 2  Americas El Salvador         -1.511
## 3      Asia    Cambodia         -9.097
## 4    Europe  Montenegro         -1.464
## 5   Oceania   Australia          0.170
```

Ponder that for a while. The subject matter and the code. Mostly you're seeing what genocide looks like in dry statistics on average life expectancy.

Break the code into pieces, starting at the top, and inspect the intermediate results. That's certainly how I was able to *write* such a thing. These commands do not [leap fully formed out of anyone's forehead](http://tinyurl.com/athenaforehead) -- they are built up gradually, with lots of errors and refinements along the way. I'm not even sure it's a great idea to do so much manipulation in one fell swoop. Is the statement above really hard for you to read? If yes, then by all means break it into pieces and make some intermediate objects. Your code should be easy to write and read when you're done.

In later tutorials, we'll explore more of `dplyr`, such as operations based on two datasets.

### Resources

`dplyr` official stuff

  * package home [on CRAN](http://cran.r-project.org/web/packages/dplyr/index.html)
    - note there are several vignettes, with the [introduction](http://cran.r-project.org/web/packages/dplyr/vignettes/introduction.html) being the most relevant right now
    - the [one on window functions](http://cran.rstudio.com/web/packages/dplyr/vignettes/window-functions.html) will also be interesting to you now
  * development home [on GitHub](https://github.com/hadley/dplyr)
  * [tutorial HW delivered](https://www.dropbox.com/sh/i8qnluwmuieicxc/AAAgt9tIKoIm7WZKIyK25lh6a) (note this links to a DropBox folder) at useR! 2014 conference

[RStudio `dplyr` and `tidyr` cheatsheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf?version=0.99.687&mode=desktop). Remember you can get to these via *Help > Cheatsheets.*

[Excellent slides](https://github.com/tjmahr/MadR_Pipelines) on pipelines and `dplyr` by TJ Mahr, talk given to the Madison R Users Group.

Blog post [Hands-on dplyr tutorial for faster data manipulation in R](http://www.dataschool.io/dplyr-tutorial-for-faster-data-manipulation-in-r/) by Data School, that includes a link to an R Markdown document and links to videos

[Cheatsheet](bit001_dplyr-cheatsheet.html) I made for `dplyr` join functions (not relevant yet but soon)
