# Getting data in and out of R



### Optional getting started advice

*Ignore if you don't need this bit of support.*

This is one in a series of tutorials in which we explore basic data import, exploration and much more using data from the [Gapminder project](http://www.gapminder.org). Now is the time to make sure you are working in the appropriate directory on your computer, perhaps through the use of an [RStudio project](block01_basicsWorkspaceWorkingDirProject.html). To ensure a clean slate, you may wish to clean out your workspace and restart R (both available from the RStudio Session menu, among other methods). Confirm that the new R process has the desired working directory, for example, with the `getwd()` command or by glancing at the top of RStudio's Console pane.

Open a new R script (in RStudio, File > New > R Script). Develop and run your code from there (recommended) or periodicially copy "good" commands from the history. In due course, save this script with a name ending in .r or .R, containing no spaces or other funny stuff, and evoking "data export" or "writing data to file".

### Load the Gapminder data

Assuming the data can be found in the current working directory, this works:

```r
gDat <- read.delim("gapminderDataFiveYear.txt")
```

Plan B (I use here, because of where the source of this tutorial lives):

```r
## data import from URL
gdURL <- "http://www.stat.ubc.ca/~jenny/notOcto/STAT545A/examples/gapminder/data/gapminderDataFiveYear.txt"
gDat <- read.delim(file = gdURL)
```

Basic sanity check that the import has gone well:

```r
str(gDat)
## 'data.frame':	1704 obs. of  6 variables:
##  $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
##  $ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
##  $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
##  $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
##  $ gdpPercap: num  779 821 853 836 740 ...
```

### Data export mindset

There will be many occasions when you need to write data from R. Two main examples:

  * a clean ready-to-analyze dataset that you heroically created from messy data
  * a numerical result from data aggregation or modelling or statistical inference 

First tip: __today's outputs are tomorrow's inputs__. Think back on all the pain you have suffered importing data and try not self-inflict such pain in the future.

Second tip: don't be too cute or clever. A plain text file that is readable by a human being in a text editor should be your default until you have __actual proof__ that this will not work. Reading and writing to exotic or proprietary formats will be the first thing to break in the future or on a different computer. It also creates barriers for anyone who has a different toolkit than you do. Be software-agnostic. Aim for future-proof and moron-proof.

How does this fit with the current push towards dynamic reports? There is a time and place for everything. There are projects and documents where the scope and personnel will allow you to geek out with `knitr` and R Markdown. But there are lots of good reasons why (parts of) an analysis should not (only) be embedded in a dynamic report. Maybe you are just doing data cleaning to produce a valid input dataset. Maybe you are making a small but crucial contribution to a giant multi-author paper. Etc. Also remember there are other tools and workflows for making something reproducible. I'm looking at you, [make](http://kbroman.github.io/minimal_make/).

Finally, certain data "shapes" or formats are simply more amenable to modelling, data aggregation, and visualization. Try to get data into this form early on in an analysis and proactively keep it that way. See the references below for links to two excellent articles on this topic:

  * Nine simple ways to make it easier to (re)use your data by White, et al, primarily section 4 "Use Standard Data Formats"
  * Tidy data by Wickham

### Computing something worth exporting

Let's quickly redo an analysis [we developed when learning about data aggregation](block04_dataAggregation.html): linear regression of life expectancy on year, for each country separately. We store only the estimated slope and intercept.


```r
library(plyr)
yearMin <- min(gDat$year)
jFun <- function(x) {
  estCoefs <- coef(lm(lifeExp ~ I(year - yearMin), x))
  names(estCoefs) <- c("intercept", "slope")
  return(estCoefs)
  }
jCoefs <- ddply(gDat, ~ country + continent, jFun)
str(jCoefs)
## 'data.frame':	142 obs. of  4 variables:
##  $ country  : Factor w/ 142 levels "Afghanistan",..: 1 2 3 4 5 6 7 8 9 10 ...
##  $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 4 1 1 2 5 4 3 3 4 ...
##  $ intercept: num  29.9 59.2 43.4 32.1 62.7 ...
##  $ slope    : num  0.275 0.335 0.569 0.209 0.232 ...
tail(jCoefs)
##                country continent intercept       slope
## 137          Venezuela  Americas  57.51332  0.32972168
## 138            Vietnam      Asia  39.01008  0.67161538
## 139 West Bank and Gaza      Asia  43.79840  0.60110070
## 140        Yemen, Rep.      Asia  30.13028  0.60545944
## 141             Zambia    Africa  47.65803 -0.06042517
## 142           Zimbabwe    Africa  55.22124 -0.09302098
```

The `jCoefs` data.frame is an example of an intermediate result that we want to store for the future and for downstream analyses or visualizations.

### `write.table()`

Recall that `read.table()` is the main workhorse for importing rectangular, spreadsheet-y data. As you might guess, `write.table()` is the main workhorse for exporting rectangular, spreadsheet-y data.


```r
write.table(jCoefs, "jCoefs.txt")
```

> Note: I am not necessarily modelling good filenaming practice here. `jCoefs.txt` isn't terribly descriptive. But for this tutorial I want to keep the filename short and have it match the data.frame name. Humor me.

Let's look at the first few lines of `jCoefs.txt`. If you're following along, you should be able to open this file or, in a shell, use `head` on it.


```
"country" "continent" "intercept" "slope"
"1" "Afghanistan" "Asia" 29.9072948717949 0.275328671328671
"2" "Albania" "Europe" 59.2291282051282 0.334683216783216
"3" "Algeria" "Africa" 43.3749743589744 0.56927972027972
"4" "Angola" "Africa" 32.1266538461539 0.20933986013986
"5" "Argentina" "Americas" 62.6884358974359 0.231708391608391
```

I always find this mildly disappointing. All those quotes! Quoted stupid numerical rownames! No visible alignment! Must it be this ugly?

  * The character information (and yes, factors are character for this purpose, for that's what's written to file), is protected by quotes. Note this affects variable names, rownames, and variables themselves in the current example. For future re-import, this quoting is often not strictly necessary. In particular, these quotes are often not necessary for typical re-importation into R, so I often suppress. See [Pitfalls of delimited files](#pitfalls) below for more details.
  * The stupid character-coerced default numerical rownames are easy to suppress. I rarely use rownames deliberately -- if the info is important to me, I put it into a proper variable. But I can imagine contexts where the rownames are meaningful, such as immediately after certain data aggregation workflows.
  * It's not really fair to complain about the lack of visible alignment. Remember we are ["writing data for computers"](https://twitter.com/vsbuffalo/statuses/358699162679787521). If you really want to browse around the file, open it in Microsoft Excel (!) but don't succumb to the temptation to start doing artisanal data manipulations there ... get back to R and construct commands that you can re-run the next 15 times you import/clean/aggregate/export the same dataset. Trust me, it will happen.
  
Let's write to file again, using some of `write.table()`'s many arguments to impose our will.

```r
write.table(jCoefs, "jCoefs.txt", quote = FALSE, sep = "\t", row.names = FALSE)
```
and examine the first few lines:

```
country	continent	intercept	slope
Afghanistan	Asia	29.9072948717949	0.275328671328671
Albania	Europe	59.2291282051282	0.334683216783216
Algeria	Africa	43.3749743589744	0.56927972027972
Angola	Africa	32.1266538461539	0.20933986013986
Argentina	Americas	62.6884358974359	0.231708391608391
```
Much better.

### Invertibility

It turns out these self-imposed rules are often in conflict with one another

  * Write to plain text files
  * Break analysis into pieces: the output of script `i` is an input for script `i + 1`
  * Be the boss of factors: order the levels in a meaningful, usually non-alphabetical way
  * Avoid duplication of code and data

Example: after performing the country-specific linear fits, we might choose to reorder the levels of the country factor. We could order based on the intercept or the slope, possibly ordering within continent, perhaps even after reordering the continent levels themselves! In any case, those reordering operations are conceptually important and must be embodied in R commands stored in a script. However, as soon as we write `jCoefs` to a plain text file, that meta-information about the countries and continents is lost. Upon re-import with `read.table()`, we are back to alphabetically ordered factor levels. Any measure we take to avoid this loss immediately breaks another one of our rules.

So what do I do? I must admit I save (and re-load) R-specific binary files. Right after I save the plain text file. [Belt and suspenders](http://www.wisegeek.com/what-does-it-mean-to-wear-belt-and-suspenders.htm).

I have toyed with the idea of writing import helper functions for a specific project, that would re-order factor levels in principled ways. They could be defined in one file and called from many. This would also have a very natural implementation within [a workflow where each analytical project is an R package](http://carlboettiger.info/2012/05/06/research-workflow.html). But so far it has seemed too much like [yak shaving](http://sethgodin.typepad.com/seths_blog/2005/03/dont_shave_that.html).

### Reordering the levels of the country factor

The topic of [factor level reordering is covered elsewhere](block08_bossYourFactors.html), so let's Just. Do. It. I reorder the country factor levels according to the intercept, i.e. the life expectancy in 1952.


```r
head(levels(jCoefs$country)) # alphabetical order
## [1] "Afghanistan" "Albania"     "Algeria"     "Angola"      "Argentina"  
## [6] "Australia"
jCoefs <- within(jCoefs, country <- reorder(country, intercept))
head(levels(jCoefs$country)) # in increasing order of 1952 life expectancy
## [1] "Gambia"        "Afghanistan"   "Yemen, Rep."   "Sierra Leone" 
## [5] "Guinea"        "Guinea-Bissau"
head(jCoefs)
##       country continent intercept     slope
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
saveRDS(jCoefs, "jCoefs.rds")
```
Note that, unlike an approach based on `save()` and `load()`, you must make an object assignment upon import (see below). This implies that you could give the object a totally different name, but why confuse yourself like that? Full disclosure: you will eventually get curious about `save()` or `save.image()` + `load()`, which save and restore multiple objects or even an entire workspace. Tempting though it may be, I recommend you just say no to these functions. Source is real; workspaces are not.

`saveRDS()` has more arguments, such as one controlling compression, so read the help for more advanced usage. It is also very handy for saving non-rectangular objects, like a fitted regression model, that took a nontrivial amount of time to compute.

### Retaining factor levels upon re-import

Concrete demonstration of how non-alphabetical factor level order is lost with `write.table()` / `read.table()` but maintained with `saveRDS()` / `readRDS()`.


```r
jCoefs <- ddply(gDat, ~ country + continent, jFun)
jCoefs <- within(jCoefs, country <- reorder(country, intercept))
str(jCoefs)
## 'data.frame':	142 obs. of  4 variables:
##  $ country  : Factor w/ 142 levels "Gambia","Afghanistan",..: 2 98 52 7 109 132 120 83 17 131 ...
##   ..- attr(*, "scores")= num [1:142(1d)] 29.9 59.2 43.4 32.1 62.7 ...
##   .. ..- attr(*, "dimnames")=List of 1
##   .. .. ..$ : chr  "Afghanistan" "Albania" "Algeria" "Angola" ...
##  $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 4 1 1 2 5 4 3 3 4 ...
##  $ intercept: num  29.9 59.2 43.4 32.1 62.7 ...
##  $ slope    : num  0.275 0.335 0.569 0.209 0.232 ...
countryLevels <- data.frame(original = head(levels(jCoefs$country)))
write.table(jCoefs, "jCoefs.txt", quote = FALSE, sep = "\t", row.names = FALSE)
saveRDS(jCoefs, "jCoefs.rds")
rm(jCoefs)
head(jCoefs) # will cause error! proving jCoefs is really gone 
## Error in head(jCoefs): object 'jCoefs' not found
jCoefsTable <- read.delim("jCoefs.txt")
jCoefsRDS <- readRDS("jCoefs.rds")
countryLevels$postRDS <- head(levels(jCoefsRDS$country))
countryLevels$postTable <- head(levels(jCoefsTable$country))
countryLevels
##        original       postRDS   postTable
## 1        Gambia        Gambia Afghanistan
## 2   Afghanistan   Afghanistan     Albania
## 3   Yemen, Rep.   Yemen, Rep.     Algeria
## 4  Sierra Leone  Sierra Leone      Angola
## 5        Guinea        Guinea   Argentina
## 6 Guinea-Bissau Guinea-Bissau   Australia
```

Note how the original, post-reordering country factor levels are restored using the `saveRDS()` / `readRDS()` strategy but revert to alphabetical ordering using `write.table()` / `read.table()`.

### `dput()` and `dget()`

One last method of saving and restoring data deserves a mention: `dput()` and `dget()`. `dput()` offers this odd combination of features: it creates a plain text representation of an R object which still manages to be quite opaque. If you use the `file =` argument, `dput()` can write this representation to file but you won't be tempted to actually read that thing. `dput()` creates an R-specific-but-not-binary representation. Let's try it out.


```r
## first restore jCoefs with our desired country factor level order
jCoefs <- readRDS("jCoefs.rds")
dput(jCoefs, "jCoefs-dput.txt")
```

Now let's look at the first few lines of the file `jCoefs-dput.txt`.


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
jCoefsPut <- dget("jCoefs-dput.txt")
countryLevels$postPut <- head(levels(jCoefsPut$country))
countryLevels
##        original       postRDS   postTable       postPut
## 1        Gambia        Gambia Afghanistan        Gambia
## 2   Afghanistan   Afghanistan     Albania   Afghanistan
## 3   Yemen, Rep.   Yemen, Rep.     Algeria   Yemen, Rep.
## 4  Sierra Leone  Sierra Leone      Angola  Sierra Leone
## 5        Guinea        Guinea   Argentina        Guinea
## 6 Guinea-Bissau Guinea-Bissau   Australia Guinea-Bissau
```
Note how the original, post-reordering country factor levels are restored using the `dput()` / `dget()` strategy.

But why on earth would you ever do this?

The main application of this is [the creation of highly portable, self-contained minimal examples](http://stackoverflow.com/questions/5963269/how-to-make-a-great-r-reproducible-example). For example, if you want to pose a question on a forum or directly to an expert, it might be required or just plain courteous to NOT attach any data files. You will need a monolithic, plain text blob that defines any necessary objects and has the necessary code. `dput()` can be helpful for producing the piece of code that defines the object. If you `dput()` without specifying a file, you can copy the return value from Console and paste into a script. Or you can write to file and copy from there or add R commands below.

### Other types of objects to use `dput()` or `saveRDS()` on

My special dispensation to abandon human-readable, plain text files is even broader than I've let on. Above, I give my blessing to store data.frames via `dput()` and/or `saveRDS()`, when you've done some rational factor level re-ordering. The same advice and mechanics apply a bit more broadly: you're also allowed to use R-specific file formats to save vital non-rectangular objects, such as a fitted nonlinear mixed effects model or a classification and regression tree.

### Clean up

We've written several files in this tutorial. Some of them are not of lasting value or have confusing filenames. I choose to delete them, while demonstrating some of the many functions R offers for interacting with the filesystem. It's up to you whether you want to submit this command or not.


```r
file.remove(list.files(pattern = "^jCoef"))
## [1] TRUE TRUE TRUE
```


### Pitfalls of delimited files <a id="pitfalls"></a>

> Still under development. Really belongs in a data cleaning and import topic or tutorial, but such does not yet exist.

> I could also add explicit demos of writing LaTeX or HTML tables to file versus having them appear "live" in a dynamic report.

If a delimited file contains fields where a human being has typed, be crazy paranoid because people do really nutty things. Especially people who aren't in the business of programming and have never had to compute on text. Claim: a person's regular expression skill is inversely proportional to the skill required to handle the files they create. Implication: if someone has never heard of regular expressions, prepare for lots of pain working with their files.

When the header fields (often, but not always, the variable names) or actual data contain the delimiter, it can lead to parsing and import failures. Two popular delimiters are the comma `,` and the TAB `\t` and humans tend to use these when typing. If you can design this problem away during data capture, such as by using a drop down menu on an input form, by all means do so. Sometimes this is impossible or undesirable and you must deal with fairly free form text. That's a good time to allow text to be protected with quotes, because it will make parsing the delimited file go more smoothly.

Possible examples: numbers like "12,121" ... re-export from wherever it's coming from or import as character and then address; "bryan, jenny" ... maybe those should be two separate fields, so view the comma as a delimiter, not a problem

Sometimes, instead of rigid tab-delimiting, whitespace is used as the delimiter. That is, in fact, the default for both `read.table()` and `write.table()`. Assuming you will write/read variable names from the first line (a.k.a. the `header` in `write.table()` and `read.table()`), they must be valid R variable names ... or they will be coerced into something valid. So, for these two reasons, it is good practice to use "one word"" variable names whenever possible. If you need to evoke multiple words, use camelCase or underscores or periods to cope. Example: the header entry for the field holding the subject's last name should be `lastName` or `last_name` or `last.name` NOT `last name`.

### References

Nine simple ways to make it easier to (re)use your data by Ethan P White, Elita Baldridge, Zachary T. Brym, Kenneth J. Locey, Daniel J. McGlinn, Sarah R. Supp.

  * First appeared here: PeerJ PrePrints 1:e7v2 <http://dx.doi.org/10.7287/peerj.preprints.7v2>
  * Published here: Ideas in Ecology and Evolution 6(2): 1–10, 2013. doi:10.4033/iee.2013.6b.6.f <http://library.queensu.ca/ojs/index.php/IEE/article/view/4608>
  * Section 4 "Use Standard Data Formats" is especially good reading.
  
Tidy data by Hadley Wickham. Submitted to The Journal of Statistical Software. Preprint available <http://vita.had.co.nz/papers/tidy-data.pdf>.  

Data Manipulation with R [available via SpringerLink](http://ezproxy.library.ubc.ca/login?url=http://link.springer.com.ezproxy.library.ubc.ca/book/10.1007/978-0-387-74731-6/page/1) by Phil Spector, Springer (2008) &#124; [author webpage](http://www.stat.berkeley.edu/%7Espector/) &#124; [GoogleBooks search](http://books.google.com/books?id=grfuq1twFe4C&lpg=PP1&dq=data%2520manipulation%2520spector&pg=PP1#v=onepage&q=&f=false)

  * See Chapter 2 (“Reading and Writing Data”)

<div class="footer">
This work is licensed under the  <a href="http://creativecommons.org/licenses/by-nc/3.0/">CC BY-NC 3.0 Creative Commons License</a>.
</div>
