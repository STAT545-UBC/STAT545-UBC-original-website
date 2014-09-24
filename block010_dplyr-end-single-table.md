# dplyr functions for a single dataset



### Where were we?

In the [introduction to `plyr`](block009_dplyr-intro.html), we used two very important verbs and an operator:

  * `filter()` for subsetting data row-wise
  * `select()` for subsetting data variable- or column-wise
  * the pipe operator `%>%`, which feeds the LHS as the first argument to the expression on the RHS
  
Here we explore other `dplyr` functions, especially more verbs, for working with a single dataset.

#### Load `dplyr` and the Gapminder data

We use an excerpt of the Gapminder data and store it as a `tbl_df` object, basically an enhanced data.frame. I'll use the pipe operator even here, to demonstrate its utility outside of `dplyr`.


```r
suppressPackageStartupMessages(library(dplyr))
gd_url <- "http://tiny.cc/gapminder"
gtbl <- gd_url %>% read.delim %>% tbl_df
gtbl %>% glimpse
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

### Use `mutate()` to add new variables

Imagine we wanted to recover each country's GDP. After all, the Gapminder data has a variable for population and GDP per capita. Let's multiply them together.


```r
gtbl <- gtbl %>%
  mutate(gdp = pop * gdpPercap)
gtbl %>% glimpse
```

```
## Variables:
## $ country   (fctr) Afghanistan, Afghanistan, Afghanistan, Afghanistan,...
## $ year      (int) 1952, 1957, 1962, 1967, 1972, 1977, 1982, 1987, 1992...
## $ pop       (dbl) 8425333, 9240934, 10267083, 11537966, 13079460, 1488...
## $ continent (fctr) Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asi...
## $ lifeExp   (dbl) 28.80, 30.33, 32.00, 34.02, 36.09, 38.44, 39.85, 40....
## $ gdpPercap (dbl) 779.4, 820.9, 853.1, 836.2, 740.0, 786.1, 978.0, 852...
## $ gdp       (dbl) 6.567e+09, 7.585e+09, 8.759e+09, 9.648e+09, 9.679e+0...
```

Hmmmm ... those GDP numbers are almost uselessly large and abstract. Consider the [advice of Randall Munroe of xkcd](http://fivethirtyeight.com/datalab/xkcd-randall-munroe-qanda-what-if/): "One thing that bothers me is large numbers presented without context... 'If I added a zero to this number, would the sentence containing it mean something different to me?' If the answer is 'no,' maybe the number has no business being in the sentence in the first place." Maybe it would be more meaningful to consumers of my tables and figures if I reported GDP per capita, *relative to some benchmark country*. Since Canada is my adopted home, I'll go with that.


```r
just_canada <- gtbl %>% filter(country == "Canada")
gtbl <- gtbl %>%
  mutate(canada = just_canada$gdpPercap[match(year, just_canada$year)],
         gdpPercapRel = gdpPercap / canada)
gtbl %>%
  select(country, year, gdpPercap, canada, gdpPercapRel)
```

```
## Source: local data frame [1,704 x 5]
## 
##        country year gdpPercap canada gdpPercapRel
## 1  Afghanistan 1952     779.4  11367      0.06857
## 2  Afghanistan 1957     820.9  12490      0.06572
## 3  Afghanistan 1962     853.1  13462      0.06337
## 4  Afghanistan 1967     836.2  16077      0.05201
## 5  Afghanistan 1972     740.0  18971      0.03901
## 6  Afghanistan 1977     786.1  22091      0.03559
## 7  Afghanistan 1982     978.0  22899      0.04271
## 8  Afghanistan 1987     852.4  26627      0.03201
## 9  Afghanistan 1992     649.3  26343      0.02465
## 10 Afghanistan 1997     635.3  28955      0.02194
## ..         ...  ...       ...    ...          ...
```

```r
gtbl %>%
  select(gdpPercapRel) %>%
  summary
```

```
##   gdpPercapRel  
##  Min.   :0.007  
##  1st Qu.:0.062  
##  Median :0.172  
##  Mean   :0.327  
##  3rd Qu.:0.447  
##  Max.   :9.535
```

Note that, `mutate()` builds new variables sequentially so you can reference earlier ones (like `canada`) when defining later ones (like `gdpPercapRel`). (I got a little off topic here using `match()` to do table look up, but [you can figure that out](http://www.rdocumentation.org/packages/base/functions/match).)

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
##        country year      pop continent lifeExp gdpPercap       gdp canada
## 1  Afghanistan 1952  8425333      Asia   28.80     779.4 6.567e+09  11367
## 2      Albania 1952  1282697    Europe   55.23    1601.1 2.054e+09  11367
## 3      Algeria 1952  9279525    Africa   43.08    2449.0 2.273e+10  11367
## 4       Angola 1952  4232095    Africa   30.02    3520.6 1.490e+10  11367
## 5    Argentina 1952 17876956  Americas   62.48    5911.3 1.057e+11  11367
## 6    Australia 1952  8691212   Oceania   69.12   10039.6 8.726e+10  11367
## 7      Austria 1952  6927772    Europe   66.80    6137.1 4.252e+10  11367
## 8      Bahrain 1952   120447      Asia   50.94    9867.1 1.188e+09  11367
## 9   Bangladesh 1952 46886859      Asia   37.48     684.2 3.208e+10  11367
## 10     Belgium 1952  8730405    Europe   68.00    8343.1 7.284e+10  11367
## ..         ...  ...      ...       ...     ...       ...       ...    ...
## Variables not shown: gdpPercapRel (dbl)
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
##                     country year      pop continent lifeExp gdpPercap
## 1                 Swaziland 2007  1133066    Africa   39.61    4513.5
## 2                Mozambique 2007 19951656    Africa   42.08     823.7
## 3                    Zambia 2007 11746035    Africa   42.38    1271.2
## 4              Sierra Leone 2007  6144562    Africa   42.57     862.5
## 5                   Lesotho 2007  2012649    Africa   42.59    1569.3
## 6                    Angola 2007 12420476    Africa   42.73    4797.2
## 7                  Zimbabwe 2007 12311143    Africa   43.49     469.7
## 8               Afghanistan 2007 31889923      Asia   43.83     974.6
## 9  Central African Republic 2007  4369038    Africa   44.74     706.0
## 10                  Liberia 2007  3193942    Africa   45.68     414.5
## ..                      ...  ...      ...       ...     ...       ...
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
##             country year       pop continent lifeExp gdpPercap       gdp
## 1             Japan 2007 127467972      Asia   82.60     31656 4.035e+12
## 2  Hong Kong, China 2007   6980412      Asia   82.21     39725 2.773e+11
## 3           Iceland 2007    301931    Europe   81.76     36181 1.092e+10
## 4       Switzerland 2007   7554661    Europe   81.70     37506 2.833e+11
## 5         Australia 2007  20434176   Oceania   81.23     34435 7.037e+11
## 6             Spain 2007  40448191    Europe   80.94     28821 1.166e+12
## 7            Sweden 2007   9031088    Europe   80.88     33860 3.058e+11
## 8            Israel 2007   6426679      Asia   80.75     25523 1.640e+11
## 9            France 2007  61083916    Europe   80.66     30470 1.861e+12
## 10           Canada 2007  33390141  Americas   80.65     36319 1.213e+12
## ..              ...  ...       ...       ...     ...       ...       ...
## Variables not shown: canada (dbl), gdpPercapRel (dbl)
```

I advise that your analyses NEVER rely on rows or variables being in a specific order. But it's still true that human beings write the code and the interactive development process can be much nicer if you reorder the rows of your data as you go along. Also, once you are preparing tables for human eyeballs, it is imperative that you step up and take control of row order.

### Use `rename()` to rename variables

*NOTE: I am using the development version of `dplyr` which will soon become the official release 0.3. If `rename()` does not work for you, try `rename_vars()`, which is what this function is called in version 0.2 on CRAN. You could also use `plyr::rename()`, but then you have to be careful to always load `plyr` before `dplyr`.*

I am in the awkward life stage of switching from [`camelCase`](http://en.wikipedia.org/wiki/CamelCase) to [`snake_case`](http://en.wikipedia.org/wiki/Snake_case), so I am vexed by the variable names I chose when I cleaned this data years ago. Let's rename some variables!


```r
gtbl %>%
  rename(life_exp = lifeExp, gdp_percap = gdpPercap,
         gdp_percap_rel = gdpPercapRel)
```

```
## Source: local data frame [1,704 x 9]
## 
##        country year      pop continent life_exp gdp_percap       gdp
## 1  Afghanistan 1952  8425333      Asia    28.80      779.4 6.567e+09
## 2  Afghanistan 1957  9240934      Asia    30.33      820.9 7.585e+09
## 3  Afghanistan 1962 10267083      Asia    32.00      853.1 8.759e+09
## 4  Afghanistan 1967 11537966      Asia    34.02      836.2 9.648e+09
## 5  Afghanistan 1972 13079460      Asia    36.09      740.0 9.679e+09
## 6  Afghanistan 1977 14880372      Asia    38.44      786.1 1.170e+10
## 7  Afghanistan 1982 12881816      Asia    39.85      978.0 1.260e+10
## 8  Afghanistan 1987 13867957      Asia    40.82      852.4 1.182e+10
## 9  Afghanistan 1992 16317921      Asia    41.67      649.3 1.060e+10
## 10 Afghanistan 1997 22227415      Asia    41.76      635.3 1.412e+10
## ..         ...  ...      ...       ...      ...        ...       ...
## Variables not shown: canada (dbl), gdp_percap_rel (dbl)
```

I did NOT assign the post-rename object back to `gtbl` because that would make the chunks in this tutorial harder to copy/paste and run out of order. In real life, I would probably assign this back to `gtbl`, in a data preparation script, and proceed with the new varaible names.

### `group_by()` is a mighty weapon

I have found friends and family love to ask seemingly innocuous questions like, "which country experienced the sharpest 5-year drop in life expectancy?". In fact, that is a totally natural question to ask. But if you are using a language that doesn't know about data, it's an incredibly annoying question to answer.

`dplyr` offers powerful tools to solve this class of problem.

  * `group_by()` adds extra structure to your dataset -- grouping information -- which lays the groundwork for computations within the groups.
  * `summarize()` takes a dataset with $n$ observations, computes requested summaries, and returns a dataset with 1 observation.
  * window functions take a dataset with $n$ observations and return a dataset with $n$ observations.
  
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
## 1    Africa   624
## 2  Americas   300
## 3      Asia   396
## 4    Europe   360
## 5   Oceania    24
```

The `tally()` function is a convenience wrapper for this sort of thing.


```r
gtbl %>%
  group_by(continent) %>%
  tally
```

```
## Source: local data frame [5 x 2]
## 
##   continent   n
## 1    Africa 624
## 2  Americas 300
## 3      Asia 396
## 4    Europe 360
## 5   Oceania  24
```

What if we wanted to add the number of unique countries for each continent?


```r
gtbl %>%
  group_by(continent) %>%
  summarize(n_obs = n(), n_countries = n_distinct(country))
```

```
## Source: local data frame [5 x 3]
## 
##   continent n_obs n_countries
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
## 1    Africa       48.87
## 2  Americas       64.66
## 3      Asia       60.06
## 4    Europe       71.90
## 5   Oceania       74.33
```

`summarize_each()` applies the same summary function(s) to multiple variables. Let's compute average and median life expectancy and GDP per capita by continent by year ... but only for 1952 and 2007.

*NOTE: you won't have `summarize_each()` if you're using `dplyr` version 0.2. Just wait for it.*


```r
gtbl %>%
  filter(year %in% c(1952, 2007)) %>%
  group_by(continent, year) %>%
  summarise_each(funs(mean, median), lifeExp, gdpPercap)
```

```
## Source: local data frame [10 x 6]
## Groups: continent
## 
##    continent year lifeExp_mean gdpPercap_mean lifeExp_median
## 1     Africa 1952        39.14           1253          38.83
## 2     Africa 2007        54.81           3089          52.93
## 3   Americas 1952        53.28           4079          54.74
## 4   Americas 2007        73.61          11003          72.90
## 5       Asia 1952        46.31           5195          44.87
## 6       Asia 2007        70.73          12473          72.40
## 7     Europe 1952        64.41           5661          65.90
## 8     Europe 2007        77.65          25054          78.61
## 9    Oceania 1952        69.25          10298          69.25
## 10   Oceania 2007        80.72          29810          80.72
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
##    year min_lifeExp max_lifeExp
## 1  1952       28.80       65.39
## 2  1957       30.33       67.84
## 3  1962       32.00       69.39
## 4  1967       34.02       71.43
## 5  1972       36.09       73.42
## 6  1977       31.22       75.38
## 7  1982       39.85       77.11
## 8  1987       40.82       78.67
## 9  1992       41.67       79.36
## 10 1997       41.76       80.69
## 11 2002       42.13       82.00
## 12 2007       43.83       82.60
```

Of course it would be much more interesting to see *which* country contributed these extreme observations. Is the minimum (maximum) always coming from the same country? That's where window functions come in.

#### Window functions

Recall that window functions take $n$ inputs and give back $n$ outputs. Here we use window functions based on ranks and offsets.

Let's revisit the worst and best life expectancies in Asia over time, but with the added info about *which* country contributes these extreme values.


```r
gtbl %>%
  filter(continent == "Asia") %>%
  group_by(year) %>%
  select(year, country, lifeExp) %>%
  filter(min_rank(desc(lifeExp)) < 2 | min_rank(lifeExp) < 2) %>%
  arrange(year)
```

```
## Source: local data frame [24 x 3]
## 
##    year     country lifeExp
## 1  1952 Afghanistan   28.80
## 2  1952      Israel   65.39
## 3  1957 Afghanistan   30.33
## 4  1957      Israel   67.84
## 5  1962 Afghanistan   32.00
## 6  1962      Israel   69.39
## 7  1967 Afghanistan   34.02
## 8  1967       Japan   71.43
## 9  1972 Afghanistan   36.09
## 10 1972       Japan   73.42
## 11 1977    Cambodia   31.22
## 12 1977       Japan   75.38
## 13 1982 Afghanistan   39.85
## 14 1982       Japan   77.11
## 15 1987 Afghanistan   40.82
## 16 1987       Japan   78.67
## 17 1992 Afghanistan   41.67
## 18 1992       Japan   79.36
## 19 1997 Afghanistan   41.76
## 20 1997       Japan   80.69
## 21 2002 Afghanistan   42.13
## 22 2002       Japan   82.00
## 23 2007 Afghanistan   43.83
## 24 2007       Japan   82.60
```

That result should make you impatient for our upcoming work of tidying and reshaping data! Wouldn't it be nice to have one row per year?

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
## 
##   continent     country worst_le_delta
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

Blog post [Hands-on dplyr tutorial for faster data manipulation in R](http://www.dataschool.io/dplyr-tutorial-for-faster-data-manipulation-in-r/) by Data School, that includes a link to an R Markdown document and links to videos

[Cheatsheet](http://stat545-ubc.github.io/bit001_dplyr-cheatsheet.html) I made for `dplyr` join functions (not relevant yet but soon)
