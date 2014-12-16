# Comparing two almost-identical data.frames
Dean Attali & Jenny Bryan  
December 15, 2014  

## Overview
In [hw07](http://stat545-ubc.github.io/hw07_data-wrangling-grand-finale.html),
one of the suggested exercises which was widely attempted was to take the
[Gapminder data](https://github.com/jennybc/gapminder), split it up by country,
write out a mini data.frame for each country to a different file, and then read
and merge all the newly created files into a data.frame to re-create the 
original data.  Many of you noticed that the data.frame created from the saved
files was not identical to the original data.frame, though very similar.  This
may have been counter-intuitive (and frustrating) - all you wanted to do is
break something apart and glue it back together, but it looked like it didn't
glue back the exact same way.  
In this document, we will dig into this issue by walking through a real example
of troubleshooting this problem.  We will use the Gapminder data to write
the information of each country to a different tsv file, then read all the files
and combine them together to form a data.frame that should resemble the original
Gapminder data.  We will then investigate why the two are slightly different
and take steps to transform the new data to completely match the original.

## Load data

We're going to use `plyr` and `dplyr` for a lot of data manipulation, and
`gapminder` for data.  `gapminder` is available on
[Jenny Bryan's GitHub](https://github.com/jennybc/gapminder) and can be
installed as follows:

```
install.packages("devtools")
devtools::install_github("jennybc/gapminder")
```

Let's load the packages:


```r
library(gapminder)
library(plyr)
library(dplyr)
library(knitr)
```

Now that we've loaded `gapminder` package, we can use `gapminder` as a regular
object. I prefer to also explicitly load it so that it will be in our global
environment and we can see it in the Environment panel in RStudio.


```r
data(gapminder)
```

Just a quick sanity check to ensure we have gapminder properly loaded.


```r
tbl_df(gapminder)
```

```
## Source: local data frame [1,704 x 6]
## 
##        country continent year lifeExp      pop gdpPercap
## 1  Afghanistan      Asia 1952  28.801  8425333  779.4453
## 2  Afghanistan      Asia 1957  30.332  9240934  820.8530
## 3  Afghanistan      Asia 1962  31.997 10267083  853.1007
## 4  Afghanistan      Asia 1967  34.020 11537966  836.1971
## 5  Afghanistan      Asia 1972  36.088 13079460  739.9811
## 6  Afghanistan      Asia 1977  38.438 14880372  786.1134
## 7  Afghanistan      Asia 1982  39.854 12881816  978.0114
## 8  Afghanistan      Asia 1987  40.822 13867957  852.3959
## 9  Afghanistan      Asia 1992  41.674 16317921  649.3414
## 10 Afghanistan      Asia 1997  41.763 22227415  635.3414
## ..         ...       ...  ...     ...      ...       ...
```

## Split gapminder to one file per country

First, it's a good idea to create a separate directory for all these files
we're about to creat.


```r
outdir <- file.path("tmp-gapminder")
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)
```

Now we will use `d_ply` to split the data by country and write the data for
each country to its own file.  
Note the use of `d_ply` from the `plyr` package! It's easy to forgot about it
since `dlply` and `ddply` are used very commonly. Remember the basics of `plyr`:
split-apply-combine. Split the gapminder data, apply a function to each chunk
(write a file), and combine the results. In our case we don't need to combine
anything since the _apply_ step is doing the work we want, so there's no need
to ask for a data.frame or a list back, we want to discard the results, and we
specify that with the "_" in the function name.  
Also note the use of `paste0`, which is a shorthand for using `paste` with
`sep = ""`.  Jenny had mentioned in class how this function was not always
available, and that it was a joyous day when it came, so appreciate what you
have and use it :)


```r
d_ply(gapminder, ~ country, function(x) {
  filename <- file.path(outdir, paste0(x$country[1], ".tsv"))
  write.table(x, file = filename, quote = FALSE, sep = "\t" ,row.names = FALSE)
})
```

## Read the files to re-create gapminder

Now that we have a file for each country with its data, we can read in all
those files and combine them into a data.frame, which will hopefully be
identical to the `gapminder` data that was split to create these files.

We know that the data files are `.tsv`, so let's use a simple regular expression
pattern to find all the files.


```r
fileRegex <- "^.*\\.tsv$"
out_files <- list.files(outdir, pattern = fileRegex, full.names = TRUE)
out_files %>% head
```

```
## [1] "tmp-gapminder/Afghanistan.tsv" "tmp-gapminder/Albania.tsv"    
## [3] "tmp-gapminder/Algeria.tsv"     "tmp-gapminder/Angola.tsv"     
## [5] "tmp-gapminder/Argentina.tsv"   "tmp-gapminder/Australia.tsv"
```

Ok, looks like we have a list with all our files, so let's read them into
`dejavu` and see if it matches the original `gapminder`!


```r
dejavu <- ldply(out_files, read.delim)
all.equal(gapminder, dejavu)
```

```
## [1] "Component \"country\": Attributes: < Component \"levels\": 2 string mismatches >"  
## [2] "Component \"country\": 24 string mismatches"                                       
## [3] "Component \"continent\": Attributes: < Component \"levels\": 4 string mismatches >"
## [4] "Component \"lifeExp\": Mean relative difference: 0.09774601"                       
## [5] "Component \"pop\": Mean relative difference: 0.1702937"                            
## [6] "Component \"gdpPercap\": Mean relative difference: 0.1890264"
```

Bummer.  
It looks like we have non-equalness in every variable except "year". 
Every time you run into such a problem, it will be a unique problem, and you
need to use the text from the output as hints for where to look to find the
differences.

## Digging into the non-identical-ness

I find that the last three messages, about numerical differences,
are the easiest to understand just by reading them, so I'll try to tackle them
first.  
`Component XXX: Mean relative difference: NNNNN` - it's not to difficult
to understand what this message means. The `XXX` numeric variable has a
mean relative difference (the exact meaning of this is not super important) of
`NNNNN` between the two datasets.  I'll first look at the gdpPercap variable
just because it has the largest difference (picking which message to address
first is very arbitrary).

-------------

#### Aside 1 - Floating point numbers
This is somewhat technical, so don't worry if you don't understand it,
but the main takehome message is this: R (and any other programming language)
can be a little inaccurate when representing certain numbers.  
**Explanation**: Because of the way computers work and store information, only
integers and fractions whose denominator is a power of 2 can be represented
exactly. Any other number has to be approximated and rounded off, though you
generally don't see this behaviour because the rounding is performed at a very
insignificant digit. As a result, two fractions that should be equal might not
be equal in R, simply because different algorithms are used to compute them,
so they may be rounded a little bit differently.  

For example, any dummy can tell you that 1 - 0.9 = 0.1, right? Let's see
what R says


```r
1 - 0.9
```

```
## [1] 0.1
```

No problem, what was I making such a big fuss about?? Let's look again...


```r
1 - 0.9 == 0.1
```

```
## [1] FALSE
```

That's the problem I was talking about. Another way to see this more clearly:

```r
1 - 0.9 - 0.1
```

```
## [1] -2.775558e-17
```

As you can see, the difference is tiny. Most people can live their lives
perfectly happy never knowing about this seemingly horrible shortcoming of
computers, but it's good to keep in mind.  

You can Google for this to learn more, or [read this StackOverflow
thread](http://stackoverflow.com/questions/9508518/why-are-these-numbers-not-equal)
to see a nice detailed discussion that is tailored to R. It is important to
remember that this is NOT an R-specific problem though, so don't hate on R
because of this. (Though, granted, there are [many other reasons to hate on
R](http://www.burns-stat.com/pages/Tutor/R_inferno.pdf) if you so wish.)


#### Aside 2 - Difference between `all.equal` and `identical`

According to the `identical` documentation:  "The safe and reliable way to test
two objects for being exactly equal". Notice the stress on "exactly equal".  
According to the all.equal documentation: "a utility to compare R objects x and
y testing ‘near equality’".  What exactly do they mean by "near equality"? 
Unfortunately the documentation doesn't tell us that exactly, but generally
`all.equal` will return `TRUE` if the two objects are equal enough for (almost)
all intents and purposes, while `identical` is a perfectionist with a gold medal
in OCD that will only return `TRUE` if everything about the two objects is
absolutely exactly the same.  

For example, `all.equal` doesn't care about the exact storage type of numerics
if they pretty much represent the same thing, while `identical` does.


```r
all.equal(as.integer(5), as.double(5))
```

```
## [1] TRUE
```

```r
identical(as.integer(5), as.double(5))
```

```
## [1] FALSE
```

Another example is that `all.equal` is aware of the floating-point numbers
problem described above, so it is a little lenient if two numbers are not
exactly identical.  As shown above, 1 - 0.9 - 0.1 is represented in R as
-2.7755576\times 10^{-17}.  But `all.equal` realizes this is an insignificant difference
and that for most everyday uses, that number is as good as `0`.


```r
all.equal(1 - 0.9 - 0.1, 0)
```

```
## [1] TRUE
```

```r
identical(1 - 0.9 - 0.1, 0)
```

```
## [1] FALSE
```

You can actually change the error tolerance of `all.equal`, which is
1.4901161\times 10^{-8} by default (varies by computer). This means that
any two numbers differing by less than 1.4901161\times 10^{-8} will be 
reported as the same.


```r
all.equal(1 - 0.9 - 0.1, 0, tolerance = 1e-15)
```

```
## [1] TRUE
```

```r
all.equal(1 - 0.9 - 0.1, 0, tolerance = 1e-20)
```

```
## [1] "Mean relative difference: 1"
```

We're getting side-tracked, so if you really want to understand the checks that
`all.equal` performs or what the output means, you can look at the source code
of all the different `all.equal` methods: there is an `all.equal.numeric` for
numeric data, `all.equal.character` for character data, etc. Just use tab
completion to find out what the different `all.equal.` methods are.  In case you
didn't know, if you type the name of a function without parentheses, it will
show you the function code (since a function is really just a variable) instead
of running that function. So if you want to see the code of `all.equal.numeric`,
simply run `all.equal.numeric`.

----------

#### Back to business

Let's get back on track. So now that we understand that numbers can be
sometimes approximated, we can use that knowledge to try to see if that's the
source of the numeric discrepancy. As mentioned above, the inaccuracies are
in very insignificant digits, so we would expect all numbers to still be
accurate up to at least 0.01.  
So let's check if all the difference between GDP between the two datasets
are smaller than 0.01.


```r
check_gdp_diff <- abs(gapminder$gdpPercap - dejavu$gdpPercap) > 0.01
sum(check_gdp_diff)
```

```
## [1] 24
```
Hmm.. 24 observations have gdpPercap that is different by more than 0.01
between the two sources.  Let's see which observations these are.


```r
which(check_gdp_diff)
```

```
##  [1] 613 614 615 616 617 618 619 620 621 622 623 624 625 626 627 628 629
## [18] 630 631 632 633 634 635 636
```

They seem to all be in a row, suggesting they are all from the same country.
Let's take a closer look at what the data from the two data.frames looks like
at these observations.


```r
data.frame(
  with(gapminder, data.frame(
       continent, country, year, gdpPercap)),
  with(dejavu, data.frame(
    continent, country, year, gdpPercap))
  ) %>%
  filter(check_gdp_diff) %>%
  kable
```



continent   country          year   gdpPercap  continent.1   country.1        year.1   gdpPercap.1
----------  --------------  -----  ----------  ------------  --------------  -------  ------------
Africa      Guinea           1952    510.1965  Africa        Guinea-Bissau      1952      299.8503
Africa      Guinea           1957    576.2670  Africa        Guinea-Bissau      1957      431.7905
Africa      Guinea           1962    686.3737  Africa        Guinea-Bissau      1962      522.0344
Africa      Guinea           1967    708.7595  Africa        Guinea-Bissau      1967      715.5806
Africa      Guinea           1972    741.6662  Africa        Guinea-Bissau      1972      820.2246
Africa      Guinea           1977    874.6859  Africa        Guinea-Bissau      1977      764.7260
Africa      Guinea           1982    857.2504  Africa        Guinea-Bissau      1982      838.1240
Africa      Guinea           1987    805.5725  Africa        Guinea-Bissau      1987      736.4154
Africa      Guinea           1992    794.3484  Africa        Guinea-Bissau      1992      745.5399
Africa      Guinea           1997    869.4498  Africa        Guinea-Bissau      1997      796.6645
Africa      Guinea           2002    945.5836  Africa        Guinea-Bissau      2002      575.7047
Africa      Guinea           2007    942.6542  Africa        Guinea-Bissau      2007      579.2317
Africa      Guinea-Bissau    1952    299.8503  Africa        Guinea             1952      510.1965
Africa      Guinea-Bissau    1957    431.7905  Africa        Guinea             1957      576.2670
Africa      Guinea-Bissau    1962    522.0344  Africa        Guinea             1962      686.3737
Africa      Guinea-Bissau    1967    715.5806  Africa        Guinea             1967      708.7595
Africa      Guinea-Bissau    1972    820.2246  Africa        Guinea             1972      741.6662
Africa      Guinea-Bissau    1977    764.7260  Africa        Guinea             1977      874.6859
Africa      Guinea-Bissau    1982    838.1240  Africa        Guinea             1982      857.2504
Africa      Guinea-Bissau    1987    736.4154  Africa        Guinea             1987      805.5725
Africa      Guinea-Bissau    1992    745.5399  Africa        Guinea             1992      794.3484
Africa      Guinea-Bissau    1997    796.6645  Africa        Guinea             1997      869.4498
Africa      Guinea-Bissau    2002    575.7047  Africa        Guinea             2002      945.5836
Africa      Guinea-Bissau    2007    579.2317  Africa        Guinea             2007      942.6542

Looks like the rows for Guinea and Guinea-Bissau have swapped their order.
That's interesting. I wonder if R just treated Guinea-Bissau as coming
before Guinea in the alphabet.  Let's see if that's what R thinks:


```r
sort(c("Guinea-Bissau", "Guinea"))
```

```
## [1] "Guinea"        "Guinea-Bissau"
```

Nope, it looks like R treats Guinea as coming first. So why did `dejavu` 
have Guinea-Bissau first?  I would think that it's because the vector of 
files it was reading from listed Guinea-Bissau first. Let's see if that's true:


```r
grep("Guinea", out_files, value = TRUE)
```

```
## [1] "tmp-gapminder/Equatorial Guinea.tsv"
## [2] "tmp-gapminder/Guinea-Bissau.tsv"    
## [3] "tmp-gapminder/Guinea.tsv"
```

Ok, so this at least makes sense - because the files vector listed Guinea-Bissau
first, it appeared first in the `dejavu` data.  Now we have to figure out why
Guinea-Bissau comes before Guinea in this files vector.  

We obtained the files using `list.files`.  The documentation for `list.files`
says under the **Value** section that "The files are sorted in alphabetical
order".  
Ok... so the files are supposed to be sorted alphabetically, yet that's not
what we're seeing - we just saw earlier than R knows that Guinea comes before
Guinea-Bissau!  
Or at least that's what I initially thought. If you take a closer look at the
files, you'll realize what's going on here is that R sorts the files based on
the full file path, including its extension. So it's comparing 
tmp-gapminder/Guinea-Bissau.tsv to
tmp-gapminder/Guinea.tsv.  
Now do you see the problem? Both files are identical up to the end of "Guinea",
at which point one file has a "-Bissau.tsv" and the other has a ".tsv". So
R was behaving correctly all along, just not the way we wanted it to.  We wanted
to sort the files by the country name only, not the full file path.  
Just to make sure that the reasoning here is correct, let's make sure that 
a dash does indeed come before a period


```r
sort(c(".", "-"))
```

```
## [1] "-" "."
```

Yes. Looks like we understand why we got the problem.  

Now that we understand why `dejavu` has a different order, we just
need to think of a way to fix it. The approach I will use it to sort the
files based on the country name, before reading the files.  
The way I do it is by extracting the country name from each file and
sorting the file paths based on the country order. I slightly modified
the `fileRegex` from above by just adding parentheses `()` around the `.*`
so that we can backreference the country name (we learned about regex in hw08).


```r
fileRegex <- "^(.*)\\.tsv$"
out_files <- out_files[order(sub(fileRegex, "\\1", basename(out_files)))]
```

If this line is confusing to you, just break it up into each piece
and think for a minute what each step is doing. Reordering vectors using a
similar approach can be very useful, so do take a minute to take that in.

Now let's ensure that the order of the Guineas is correct in the new vector.


```r
grep("Guinea", out_files, value = TRUE)
```

```
## [1] "tmp-gapminder/Equatorial Guinea.tsv"
## [2] "tmp-gapminder/Guinea.tsv"           
## [3] "tmp-gapminder/Guinea-Bissau.tsv"
```

Success!  
So let's construct `dejavu` again.


```r
dejavu <- ldply(out_files, read.delim)
all.equal(gapminder, dejavu)
```

```
## [1] "Component \"continent\": Attributes: < Component \"levels\": 4 string mismatches >"
```

Sweet, that got rid of most of the mismatches.  Only one remains - and the error
is not too cryptic and tells us that there are 4 mismatches in the levels of
the continent variable. What odes this mean? Well, I'm not sure exactly, so one 
powerful tool that we always have to inspect any object is `str()`. Let's try to
see if we see a difference between `gapminder` and `dejavu` continent variables.


```r
str(gapminder$continent)
```

```
##  Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
```

```r
str(dejavu$continent)
```

```
##  Factor w/ 5 levels "Asia","Europe",..: 1 1 1 1 1 1 1 1 1 1 ...
```

Okay, we definitely see a difference. But this doesn't show us enough
information.  We know that the message said something about the levels, so let's
look at those more closely.


```r
data.frame(gapminder = levels(gapminder$continent),
           dejavu = levels(dejavu$continent))
```

```
##   gapminder   dejavu
## 1    Africa     Asia
## 2  Americas   Europe
## 3      Asia   Africa
## 4    Europe Americas
## 5   Oceania  Oceania
```

Interesting! `gapminder` levels seem to be alphabetical, while `dejavu` levels
are not.  Now we just have to figure out what order the `dejavu` continent
levels are following.  
The first and most logical guess is that the continent levels are ordered
according to the order in which they are seen in the data. An easy way to 
check what order they appear in the data is to look what the unique continents
are.


```r
unique(gapminder$continent)
```

```
## [1] Asia     Europe   Africa   Americas Oceania 
## Levels: Africa Americas Asia Europe Oceania
```

Uh huh, we're on to something here! This output tells us that Asia is the
first continent that appears in the data (meaning that the first row is an
Asian country), and Europe is next (meaning that the first non-Asian row
is European). Notice how the order of the continents does not match the order
of the levels in the case of `gapminder`.

_Note: It's important to understand the difference between looking at the unique
continents as they appear in the data vs looking at the continent levels, which
are also unique, but can have a different ordering than the order in which they
appear in the data._

If we run the same command on `dejavu`, we expect to see the same order of
continents in the data since the dataframe is the same, but we know that the
order of the levels is different.


```r
unique(dejavu$continent)
```

```
## [1] Asia     Europe   Africa   Americas Oceania 
## Levels: Asia Europe Africa Americas Oceania
```

Yup, just as we suspected! See how in the case of `dejavu`, the order in which
the continents are seen in the data is the same as the levels order. This is
good, we're learning.

So now we know that in order to make our two dataframes the same, we just need
to reorder the continent levels of one of them.  Alphabetical vs chronological
doesn't really make a difference, since both are not terribly useful for
visualization. Remember that we often want to reorder factors for plotting, as
we learned in hw05. Let's choose to reorder the `dejavu` continent levels
to be alphabetical.


```r
dejavu <- dejavu %>%
  mutate(continent = factor(continent, continent %>% levels %>% sort))
all.equal(gapminder, dejavu)
```

```
## [1] TRUE
```

Success!  
We were able to find all the differences between the original
dataset and the written-to-files dataset.  As you can see, there isn't
a clear step-by-step guide that will you can always follow. This is 
mostly problem-solving (sometimes combined with bashing your head against the
wall) and you need to use the tools we have in R to solve the question of
"what's different?".  Some common tools are to use the output from `all.equal`,
`str`, `levels`, `unique`, or simply just looking at the raw data. Hopefully
this can make you more comfortable in tackling a similar problem with different
data in the future.


## Bonus: getting the data.frames to be IDENTICAL

As mentioned before, `identical` checks for exact identity, and often times
will return FALSE even when two objects seem completely similar to you.  I
wanted to see if we can get `dejavu` to be `identical` to `gapminder`, so 
let's go!


```r
identical(gapminder, dejavu)
```

```
## [1] FALSE
```

So we know that `all.equal` thinks they are equal, but `identical` doesn't. 
We can't use the output from `all.equal` to direct us to the possible mismatches
anymore - we're on our own now. Scary!

Let's see if we can see any obvious differences... Using `str` again:


```r
str(gapminder)
```

```
## 'data.frame':	1704 obs. of  6 variables:
##  $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
##  $ year     : num  1952 1957 1962 1967 1972 ...
##  $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
##  $ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
##  $ gdpPercap: num  779 821 853 836 740 ...
```

```r
str(dejavu)
```

```
## 'data.frame':	1704 obs. of  6 variables:
##  $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
##  $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
##  $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
##  $ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
##  $ gdpPercap: num  779 821 853 836 740 ...
```

Oh, I do see a difference! The "year" variable is numeric in `gapminder` and
`int` in `dejavu`. I'm not purposely going in circles here - this is how you
troubleshoot these problems in the real world: incrementally, and with
mistakes along the way. So let's change `dejavu` to match `gapminder`:


```r
dejavu <- dejavu %>%
  mutate(year = as.numeric(year))
identical(gapminder,dejavu)
```

```
## [1] FALSE
```

Alright, still not identical. No more easy answers. Next I'll have to try to
zoom in on every single variable and see which ones are causing the
non-identical-ness.


```r
identicalVars <-
  sapply(colnames(gapminder), function(x){
    identical(gapminder[[x]], dejavu[[x]])
  })
nonIdenticalVars <- names(identicalVars[!identicalVars])
```

It looks like the pop and gdpPercap columns are the ones that are causing
non-identity of the two dataframes.  Those two columns are numeric - could it
be that the floating-point number issue described above is the cause of this?


```r
which(gapminder$pop != dejavu$pop)
```

```
## [1] 289
```

```r
which(gapminder$gdpPercap != dejavu$gdpPercap)
```

```
## [1] 289
```

Ok, looks like there is one row in which both the population and gdpPercap
aren't the same in both datasets. Is the difference tiny as we suspect?


```r
idxDiff <- which(gapminder$pop != dejavu$pop)
gapminder$pop[idxDiff] - dejavu$pop[idxDiff]
```

```
## [1] -4.768372e-07
```

```r
gapminder$gdpPercap[idxDiff] - dejavu$gdpPercap[idxDiff]
```

```
## [1] -1.136868e-13
```

Yup, both are tiny differences that could be attributable to computer storage.
The difference these numbers is so small that unless we're dealing with
astrophysics computations, I doubt this matters.  I would normally just leave
our data in its current state and come to terms with the fact that it's not
"identical" to `gapminder`, but if it bothers you too much, there is a cheat
we can apply to fix it. There might be better ways, but this is what I can think
of immediately. It is a big hack so don't repeat this at home!


```r
dejavu[idxDiff, nonIdenticalVars] <- gapminder[idxDiff, nonIdenticalVars]
identical(gapminder, dejavu)
```

```
## [1] TRUE
```
There, I hope you're happy now :) The last step is more for pleasing your
OCD than anything else, but it's nice to know that if we force these two
numbers to be the same, `identical` is finally TRUE!


## Cleanup

Don't forget to clean up after yourself.

```r
unlink(outdir, recursive = TRUE)
```

## Extras

#### Ensuring your filenames are valid
One potential problem you might run into when creating files with filenames
based on data is that not all filenames are legal or desireable.  

For example, we've discussed many times in class how having spaces in a filename
is a bad idea, and some countries do contain a space, so you might want to
remove spaces from filenames.  One possibility is to simply strip spaces, but
another solution would be to replace spaces with underscores. (Of course, then
you can ask "but what about a country name with an underscore?" Well, there
are always ways around everything, but I'll ignore that case for now.)

To do this, all you have to do is slightly modify the code that writes files:
```
d_ply(gapminder, ~ country, function(x) {
  country <- gsub(" ", "_", x$country[1])
  filename <- file.path(outdir, paste0(country, ".tsv"))
  write.table(x, file = filename, quote = FALSE, sep = "\t" ,row.names = FALSE)
})
```

You can get even fancier and more advanced if you need.  On Windows, filenames
cannot contain colons or quotes, so you can replace all those characters
in country names as well, but we don't have to worry about that.
