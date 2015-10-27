# Getting data in and out of R



### File I/O overview

We've been loading the Gapminder data as a data.frame from the `gapminder` data package. We haven't been explicitly writing any data or derived results to file. In real life, you'll bring rectangular data into and out of R all the time. Sometimes you'll need to do same for non-rectangular objects.

How do you do this? What issues should you think about?

#### Data import mindset

Data import generally feels one of two ways:

  * "Surprise me!" This is the attitude you must adopt when you first get a dataset. You are just happy to import without an error. You start to explore. You discover flaws in the data and/or the import. You address them. Lather, rinse, repeat.
  * "Another day in paradise." This is the attitude when you bring in a tidy dataset you have maniacally cleaned in one or more cleaning scripts. There should be no surprises. You should express your expectations about the data in formal assertions at the very start of these downstream scripts.
  
In the second case, and as the first cases progresses, you actually know a lot about how the data is / should be. My main import advice: **use the arguments of your import function to get as far as you can, as fast as possible**. Novice code often has a great deal of unnecessary post import fussing around. Read the docs for the import functions and take maximum advantage of the arguments to control the import.

#### Data export mindset

There will be many occasions when you need to write data from R. Two main examples:

  * a tidy ready-to-analyze dataset that you heroically created from messy data
  * a numerical result from data aggregation or modelling or statistical inference 

First tip: __today's outputs are tomorrow's inputs__. Think back on all the pain you have suffered importing data and don't inflict such pain on yourself!

Second tip: don't be too cute or clever. A plain text file that is readable by a human being in a text editor should be your default until you have __actual proof__ that this will not work. Reading and writing to exotic or proprietary formats will be the first thing to break in the future or on a different computer. It also creates barriers for anyone who has a different toolkit than you do. Be software-agnostic. Aim for future-proof and moron-proof.

How does this fit with our emphasis on dynamic reporting via R Markdown? There is a time and place for everything. There are projects and documents where the scope and personnel will allow you to geek out with `knitr` and R Markdown. But there are lots of good reasons why (parts of) an analysis should not (only) be embedded in a dynamic report. Maybe you are just doing data cleaning to produce a valid input dataset. Maybe you are making a small but crucial contribution to a giant multi-author paper. Etc. Also remember there are other tools and workflows for making something reproducible. I'm looking at you, [make](http://kbroman.github.io/minimal_make/).

### Locate the Gapminder data

We could load the data from the package as usual, but instead we will load it from tab delimited file. The `gapminder` package includes the data normally found in the `gapminder` data.frame as a `.tsv`. So let's get the path to that file on *your* system.


```r
(gap_tsv <- system.file("gapminder.tsv", package = "gapminder"))
## [1] "/Users/jenny/resources/R/library/gapminder/gapminder.tsv"
```

### Bring rectangular data in

The workhorse data import function of base R is `read.table()`. Here's the call we'd need to get the usual data.frame we know and love:


```r
gapminder <- read.table(gap_tsv, header = TRUE, sep = "\t", quote = "")
str(gapminder)
## 'data.frame':	1704 obs. of  6 variables:
##  $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
##  $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
##  $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
##  $ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
##  $ gdpPercap: num  779 821 853 836 740 ...
```

There are pre-built wrappers around `read.table()` that have some of the arguments set to common combinations of values. We can get the usual data with a much simpler call to `read.delim()`, which is for tab-delimited data:


```r
gapminder <- read.delim(gap_tsv)
str(gapminder)
## 'data.frame':	1704 obs. of  6 variables:
##  $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
##  $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
##  $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
##  $ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
##  $ gdpPercap: num  779 821 853 836 740 ...
```

There's a similar convenience wrapper for comma-separated values, `read.csv()`.

Finally, I encourage you to use a new-ish package `readr` (on [CRAN](https://cran.r-project.org/web/packages/readr/index.html), on [GitHub](https://github.com/hadley/readr))


```r
library(readr)
gapminder <- read_tsv(gap_tsv)
str(gapminder)
## Classes 'tbl_df', 'tbl' and 'data.frame':	1704 obs. of  6 variables:
##  $ country  : chr  "Afghanistan" "Afghanistan" "Afghanistan" "Afghanistan" ...
##  $ continent: chr  "Asia" "Asia" "Asia" "Asia" ...
##  $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
##  $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
##  $ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
##  $ gdpPercap: num  779 821 853 836 740 ...
```

Notice that the default behavior is to NOT convert strings to factors, i.e. `country` and `continent` are character immediately after import. In the grand scheme of things, this is better default behavior, although we go ahead and convert them to factor here. Do not be deceived -- in general, you will do less post-import fussing if you use `readr`.


```r
gapminder$country <- factor(gapminder$country)
gapminder$continent <- factor(gapminder$continent)
str(gapminder)
## Classes 'tbl_df', 'tbl' and 'data.frame':	1704 obs. of  6 variables:
##  $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
##  $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
##  $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
##  $ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
##  $ gdpPercap: num  779 821 853 836 740 ...
```

#### Bring rectangular data in -- summary

Base R: `read.table()` and friends. Use the arguments!

The `readr` package: the `read_delim()` family of functions. The Gapminder data is too clean and simple to show off the great features of `readr`, so I encourage you to check out the vignette on [column types](https://cran.r-project.org/web/packages/readr/vignettes/column-types.html). Highly recommended.

### Compute something worthy of export

We need compute something worth writing to file. We'll quickly redo [the linear regression of life expectancy on year, for each country](block023_dplyr-do.html). We store only the estimated slope and intercept.


```r
suppressPackageStartupMessages(library(dplyr))
le_lin_fit <- function(dat, offset = 1952) {
  the_fit <- lm(lifeExp ~ I(year - offset), dat)
  setNames(data.frame(t(coef(the_fit))), c("intercept", "slope"))
}
gfits <- gapminder %>%
  group_by(country, continent) %>% 
  do(le_lin_fit(.)) %>% 
  ungroup()
gfits
## Source: local data frame [142 x 4]
## 
##        country continent intercept     slope
##         (fctr)    (fctr)     (dbl)     (dbl)
## 1  Afghanistan      Asia  29.90729 0.2753287
## 2      Albania    Europe  59.22913 0.3346832
## 3      Algeria    Africa  43.37497 0.5692797
## 4       Angola    Africa  32.12665 0.2093399
## 5    Argentina  Americas  62.68844 0.2317084
## 6    Australia   Oceania  68.40051 0.2277238
## 7      Austria    Europe  66.44846 0.2419923
## 8      Bahrain      Asia  52.74921 0.4675077
## 9   Bangladesh      Asia  36.13549 0.4981308
## 10     Belgium    Europe  67.89192 0.2090846
## ..         ...       ...       ...       ...
```

The `gfits` data.frame is an example of an intermediate result that we want to store for the future and for downstream analyses or visualizations.

### Write rectangular data out

The workhorse export function for rectangular data in base R is `write.table()`.


```r
write.table(gfits, "gfits.tsv")
```

Let's look at the first few lines of `gfits.tsv`. If you're following along, you should be able to open this file or, in a shell, use `head` on it.


```
"country" "continent" "intercept" "slope"
"1" "Afghanistan" "Asia" 29.9072948717949 0.275328671328671
"2" "Albania" "Europe" 59.2291282051282 0.334683216783216
"3" "Algeria" "Africa" 43.3749743589744 0.56927972027972
"4" "Angola" "Africa" 32.1266538461539 0.20933986013986
"5" "Argentina" "Americas" 62.6884358974359 0.231708391608391
```

Such disappointment. All those quotes! Quoted stupid numerical rownames! No visible alignment! Must it be this ugly?

  * The character information is protected by quotes (and yes, factors are character for this purpose, for that's what's written to file). Note this affects variable names, rownames, and variables themselves in the current example. For future re-import, this quoting is often not strictly necessary. In particular, these quotes are often not necessary for typical re-importation into R, so I often suppress. See [Pitfalls of delimited files](#pitfalls) below for more details.
  * The stupid character-coerced default numerical rownames are dispensable. I never use rownames -- if the info is important to me, it goes into a proper variable.
  * It's not really fair to complain about the lack of visible alignment. Remember we are ["writing data for computers"](https://twitter.com/vsbuffalo/statuses/358699162679787521). If you really want to browse around the file, open it in Microsoft Excel (!) but don't succumb to the temptation to start doing artisanal data manipulations there ... get back to R and construct commands that you can re-run the next 15 times you import/clean/aggregate/export the same dataset. Trust me, it will happen.
  
Let's write to file again, using some of `write.table()`'s many arguments to impose our will.


```r
write.table(gfits, "gfits.tsv", quote = FALSE, sep = "\t", row.names = FALSE)
```

Examine the first few lines again:


```
country	continent	intercept	slope
Afghanistan	Asia	29.9072948717949	0.275328671328671
Albania	Europe	59.2291282051282	0.334683216783216
Algeria	Africa	43.3749743589744	0.56927972027972
Angola	Africa	32.1266538461539	0.20933986013986
Argentina	Americas	62.6884358974359	0.231708391608391
```

Much better.

There's a convenience wrapper for comma-separated values, `write.csv()`.

But again, I encourage you to use `readr` for data export.


```r
write_tsv(gfits, "gfits.tsv")
```

Examine the first few lines one last time:


```
country	continent	intercept	slope
Afghanistan	Asia	29.9072948717949	0.275328671328671
Albania	Europe	59.2291282051282	0.334683216783216
Algeria	Africa	43.3749743589744	0.56927972027972
Angola	Africa	32.1266538461539	0.20933986013986
Argentina	Americas	62.6884358974359	0.231708391608391
```

Now you've gotten a nice look at the typically cleaner interface of `readr`.

### Invertibility

It turns out these self-imposed rules are often in conflict with one another

  * Write to plain text files
  * Break analysis into pieces: the output of script `i` is an input for script `i + 1`
  * Be the boss of factors: order the levels in a meaningful, usually non-alphabetical way
  * Avoid duplication of code and data

Example: after performing the country-specific linear fits, we reorder the levels of the country factor. We could order based on the intercept or the slope, possibly ordering within continent, perhaps even after reordering the continent levels themselves! In any case, those reordering operations are conceptually important and must be embodied in R commands stored in a script. However, as soon as we write `gfits` to a plain text file, that meta-information about the countries and continents is lost. Upon re-import with `read.table()`, we are back to alphabetically ordered factor levels. Any measure we take to avoid this loss immediately breaks another one of our rules.

So what do I do? I must admit I save (and re-load) R-specific binary files. Right after I save the plain text file. [Belt and suspenders](http://www.wisegeek.com/what-does-it-mean-to-wear-belt-and-suspenders.htm).

I have toyed with the idea of writing import helper functions for a specific project, that would re-order factor levels in principled ways. They could be defined in one file and called from many. This would also have a very natural implementation within [a workflow where each analytical project is an R package](http://carlboettiger.info/2012/05/06/research-workflow.html). But so far it has seemed too much like [yak shaving](http://sethgodin.typepad.com/seths_blog/2005/03/dont_shave_that.html). I'm intrigued by a recent discussion of putting such information in YAML frontmatter (see Martin Fenner blog post [Using YAML frontmatter with CSV](http://blog.datacite.org/using-yaml-frontmatter-with-csv/)).

### Reordering the levels of the country factor

The topic of [factor level reordering is covered elsewhere](block08_bossYourFactors.html), so let's Just. Do. It. I reorder the country factor levels according to the intercept, i.e. the life expectancy in 1952.


```r
head(levels(gfits$country)) # alphabetical order
## [1] "Afghanistan" "Albania"     "Algeria"     "Angola"      "Argentina"  
## [6] "Australia"
gfits <- gfits %>% 
  mutate(country = reorder(country, intercept))
head(levels(gfits$country)) # in increasing order of 1952 life expectancy
## [1] "Gambia"        "Afghanistan"   "Yemen, Rep."   "Sierra Leone" 
## [5] "Guinea"        "Guinea-Bissau"
head(gfits)
## Source: local data frame [6 x 4]
## 
##       country continent intercept     slope
##        (fctr)    (fctr)     (dbl)     (dbl)
## 1 Afghanistan      Asia  29.90729 0.2753287
## 2     Albania    Europe  59.22913 0.3346832
## 3     Algeria    Africa  43.37497 0.5692797
## 4      Angola    Africa  32.12665 0.2093399
## 5   Argentina  Americas  62.68844 0.2317084
## 6   Australia   Oceania  68.40051 0.2277238
```

Note that the __row order of `jCoefs` has not changed__. I could choose to reorder the rows of the data.frame if, for example, I was about to prepare a table to present to people. But I'm not, so I won't.

### `saveRDS()` and `readRDS()`

If you have a data.frame AND you have exerted yourself to rationalize the factor levels, you have my blessing to save it to file in a way that will preserve this hard work upon re-import. Use `saveRDS()`.


```r
saveRDS(gfits, "gfits.rds")
```

`saveRDS()` serializes an R object to a binary file. It's not a file you will able to open in an editor, diff nicely with Git(Hub), or share with non-R friends. It's a special purpose, limited use function that I use in specific situations.

The opposite of `saveRDS()` is `readRDS()`. You must assign the return value to an object. I highly recommend you assign back to the same name as before. Why confuse yourself?!?


```r
rm(gfits)
gfits
## Error in eval(expr, envir, enclos): object 'gfits' not found
gfits <- readRDS("gfits.rds")
gfits
## Source: local data frame [142 x 4]
## 
##        country continent intercept     slope
##         (fctr)    (fctr)     (dbl)     (dbl)
## 1  Afghanistan      Asia  29.90729 0.2753287
## 2      Albania    Europe  59.22913 0.3346832
## 3      Algeria    Africa  43.37497 0.5692797
## 4       Angola    Africa  32.12665 0.2093399
## 5    Argentina  Americas  62.68844 0.2317084
## 6    Australia   Oceania  68.40051 0.2277238
## 7      Austria    Europe  66.44846 0.2419923
## 8      Bahrain      Asia  52.74921 0.4675077
## 9   Bangladesh      Asia  36.13549 0.4981308
## 10     Belgium    Europe  67.89192 0.2090846
## ..         ...       ...       ...       ...
```

`saveRDS()` has more arguments, in particular `compress` for controlling compression, so read the help for more advanced usage. It is also very handy for saving non-rectangular objects, like a fitted regression model, that took a nontrivial amount of time to compute.

You will eventually hear about `save()` + `load()` and even `save.image()`. You may even see them in documentation and tutorials, but don't be tempted. Just say no. These functions encourage unsafe practices, like storing multiple objects together and even entire workspaces. There are legitimate uses of these functions, but not in your typical data analysis.

### Retaining factor levels upon re-import

Concrete demonstration of how non-alphabetical factor level order is lost with `write.table()` / `read.table()` workflows but maintained with `saveRDS()` / `readRDS()`.


```r
gfits <- gapminder %>%
  group_by(country, continent) %>% 
  do(le_lin_fit(.)) %>% 
  ungroup() %>% 
  mutate(country = reorder(country, intercept))
str(gfits)
## Classes 'tbl_df', 'tbl' and 'data.frame':	142 obs. of  4 variables:
##  $ country  : Factor w/ 142 levels "Gambia","Afghanistan",..: 2 98 52 7 109 132 120 83 17 131 ...
##   ..- attr(*, "scores")= num [1:142(1d)] 29.9 59.2 43.4 32.1 62.7 ...
##   .. ..- attr(*, "dimnames")=List of 1
##   .. .. ..$ : chr  "Afghanistan" "Albania" "Algeria" "Angola" ...
##  $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 4 1 1 2 5 4 3 3 4 ...
##  $ intercept: num  29.9 59.2 43.4 32.1 62.7 ...
##  $ slope    : num  0.275 0.335 0.569 0.209 0.232 ...
country_levels <- data_frame(original = head(levels(gfits$country)))
write.table(gfits, "gfits.tsv", sep = "\t")
saveRDS(gfits, "gfits.rds")
rm(gfits)
head(gfits) # will cause error! proving gfits is really gone 
## Error in head(gfits): object 'gfits' not found
gfits_via_tsv <- read.delim("gfits.tsv")
gfits_via_rds <- readRDS("gfits.rds")
country_levels <- country_levels %>% 
  mutate(via_tsv = head(levels(gfits_via_tsv$country)),
         via_rds = head(levels(gfits_via_rds$country)))
country_levels
## Source: local data frame [6 x 3]
## 
##        original     via_tsv       via_rds
##           (chr)       (chr)         (chr)
## 1        Gambia Afghanistan        Gambia
## 2   Afghanistan     Albania   Afghanistan
## 3   Yemen, Rep.     Algeria   Yemen, Rep.
## 4  Sierra Leone      Angola  Sierra Leone
## 5        Guinea   Argentina        Guinea
## 6 Guinea-Bissau   Australia Guinea-Bissau
```

Note how the original, post-reordering country factor levels are restored using the `saveRDS()` / `readRDS()` strategy but revert to alphabetical ordering using `write.table()` / `read.table()`.

### `dput()` and `dget()`

One last method of saving and restoring data deserves a mention: `dput()` and `dget()`. `dput()` offers this odd combination of features: it creates a plain text representation of an R object which still manages to be quite opaque. If you use the `file =` argument, `dput()` can write this representation to file but you won't be tempted to actually read that thing. `dput()` creates an R-specific-but-not-binary representation. Let's try it out.


```r
## first restore gfits with our desired country factor level order
gfits <- readRDS("gfits.rds")
dput(gfits, "gfits-dput.txt")
```

Now let's look at the first few lines of the file `gfits-dput.txt`.


```
structure(list(country = structure(c(2L, 98L, 52L, 7L, 109L, 
132L, 120L, 83L, 17L, 131L, 33L, 27L, 95L, 84L, 81L, 115L, 13L, 
38L, 23L, 42L, 136L, 28L, 34L, 88L, 70L, 86L, 36L, 44L, 69L, 
97L, 61L, 111L, 105L, 127L, 138L, 18L, 74L, 75L, 40L, 66L, 10L, 
15L, 16L, 121L, 130L, 29L, 1L, 129L, 53L, 126L, 46L, 5L, 6L, 
31L, 49L, 110L, 117L, 141L, 32L, 21L, 62L, 79L, 128L, 119L, 123L, 
```

Huh? Don't worry about it. Remember we are ["writing data for computers"](https://twitter.com/vsbuffalo/statuses/358699162679787521). The partner function `dget()` reads this representation back in.


```r
gfits_dget <- dget("gfits-dput.txt")
country_levels <- country_levels %>% 
  mutate(via_dput = head(levels(gfits_dget$country)))
country_levels
## Source: local data frame [6 x 4]
## 
##        original     via_tsv       via_rds      via_dput
##           (chr)       (chr)         (chr)         (chr)
## 1        Gambia Afghanistan        Gambia        Gambia
## 2   Afghanistan     Albania   Afghanistan   Afghanistan
## 3   Yemen, Rep.     Algeria   Yemen, Rep.   Yemen, Rep.
## 4  Sierra Leone      Angola  Sierra Leone  Sierra Leone
## 5        Guinea   Argentina        Guinea        Guinea
## 6 Guinea-Bissau   Australia Guinea-Bissau Guinea-Bissau
```

Note how the original, post-reordering country factor levels are restored using the `dput()` / `dget()` strategy.

But why on earth would you ever do this?

The main application of this is [the creation of highly portable, self-contained minimal examples](http://stackoverflow.com/questions/5963269/how-to-make-a-great-r-reproducible-example). For example, if you want to pose a question on a forum or directly to an expert, it might be required or just plain courteous to NOT attach any data files. You will need a monolithic, plain text blob that defines any necessary objects and has the necessary code. `dput()` can be helpful for producing the piece of code that defines the object. If you `dput()` without specifying a file, you can copy the return value from Console and paste into a script. Or you can write to file and copy from there or add R commands below.

### Other types of objects to use `dput()` or `saveRDS()` on

My special dispensation to abandon human-readable, plain text files is even broader than I've let on. Above, I give my blessing to store data.frames via `dput()` and/or `saveRDS()`, when you've done some rational factor level re-ordering. The same advice and mechanics apply a bit more broadly: you're also allowed to use R-specific file formats to save vital non-rectangular objects, such as a fitted nonlinear mixed effects model or a classification and regression tree.

### Clean up

We've written several files in this tutorial. Some of them are not of lasting value or have confusing filenames. I choose to delete them, while demonstrating some of the many functions R offers for interacting with the filesystem. It's up to you whether you want to submit this command or not.


```r
file.remove(list.files(pattern = "^gfits"))
## [1] TRUE TRUE TRUE
```

### Pitfalls of delimited files <a id="pitfalls"></a>

If a delimited file contains fields where a human being has typed, be crazy paranoid because people do really nutty things. Especially people who aren't in the business of programming and have never had to compute on text. Claim: a person's regular expression skill is inversely proportional to the skill required to handle the files they create. Implication: if someone has never heard of regular expressions, prepare for lots of pain working with their files.

When the header fields (often, but not always, the variable names) or actual data contain the delimiter, it can lead to parsing and import failures. Two popular delimiters are the comma `,` and the TAB `\t` and humans tend to use these when typing. If you can design this problem away during data capture, such as by using a drop down menu on an input form, by all means do so. Sometimes this is impossible or undesirable and you must deal with fairly free form text. That's a good time to allow/force text to be protected with quotes, because it will make parsing the delimited file go more smoothly.

Sometimes, instead of rigid tab-delimiting, whitespace is used as the delimiter. That is, in fact, the default for both `read.table()` and `write.table()`. Assuming you will write/read variable names from the first line (a.k.a. the `header` in `write.table()` and `read.table()`), they must be valid R variable names ... or they will be coerced into something valid. So, for these two reasons, it is good practice to use "one word"" variable names whenever possible. If you need to evoke multiple words, use `snake_case` or `camelCase` to cope. Example: the header entry for the field holding the subject's last name should be `last_name` or `lastName` NOT `last name`. With the `readr` package, "column names are left as is, not munged into valid R identifiers (i.e. there is no `check.names = TRUE`)". So you can get away with whitespace in variable names and yet I recommend that you do not.

### References

Nine simple ways to make it easier to (re)use your data by Ethan P White, Elita Baldridge, Zachary T. Brym, Kenneth J. Locey, Daniel J. McGlinn, Sarah R. Supp.

  * First appeared here: PeerJ PrePrints 1:e7v2 <http://dx.doi.org/10.7287/peerj.preprints.7v2>
  * Published here: Ideas in Ecology and Evolution 6(2): 1?10, 2013. doi:10.4033/iee.2013.6b.6.f <http://library.queensu.ca/ojs/index.php/IEE/article/view/4608>
  * Section 4 "Use Standard Data Formats" is especially good reading.
  
Tidy data by Hadley Wickham.

  * In the Journal of Statistical Software Vol 59 (2014), Issue 10, 10.18637/jss.v059.i10: <http://www.jstatsoft.org/article/view/v059i10>
  * PDF also available here: <http://vita.had.co.nz/papers/tidy-data.pdf>

Data Manipulation with R [available via SpringerLink](http://ezproxy.library.ubc.ca/login?url=http://link.springer.com.ezproxy.library.ubc.ca/book/10.1007/978-0-387-74731-6/page/1) by Phil Spector, Springer (2008) &#124; [author webpage](http://www.stat.berkeley.edu/%7Espector/) &#124; [GoogleBooks search](http://books.google.com/books?id=grfuq1twFe4C&lpg=PP1&dq=data%2520manipulation%2520spector&pg=PP1#v=onepage&q=&f=false)

  * See Chapter 2 ("Reading and Writing Data")
