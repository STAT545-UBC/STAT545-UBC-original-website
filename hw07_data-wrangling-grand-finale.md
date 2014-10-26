---
title: "Homework 07: Data wrangling Grand Finale"
output:
  html_document:
    toc: true
    toc_depth: 4
---

### Overview

You have learned alot about data wrangling! You know how to:

  * Filter rows and select variables in a principled or name-based manner
  * Modify and create new variables
  * Split a data object into chunks, apply a function to each chunk, and combine the results into another usable data object
  * Reshape a data object
  * Get new information into a data.frame via look-up or joining/merging
  * Read/write data from/to a file
  
This ecosystem of packages works well together to accomplish these tasks: `dplyr`, `plyr`, `tidyr`, `reshape2`.

The goal of this homework is to solidify your data wrangling skills by working some realistic problems, which typically live in the grey area between data aggregation and data reshaping.

If you internalize that there are multiple solutions to most problems, you will spend less time banging your head against the wall in data analysis. If something's really hard, sneak up on it from a different angle.

Due anytime Thursday October 30th 2014.

### Choose your own adventure

Do two of the problems below. At least.

As always, it is fine to work with a new dataset and/or create variations on these problem themes. I point out the important principles, so you can craft comparable exercises.

### Return of HW03

For the STAT545 alums who have just joined us: `dplyr` is a new element in this course and is extremely powerful for data manipulation. I encourage you to go through this course material:

  * [Introduction to dplyr](block009_dplyr-intro.html)
  * [`dplyr` functions for a single dataset](block010_dplyr-end-single-table.html)

and draw on the exercises in [HW03](hw03_dplyr-and-more-ggplot2.html) to get some experience with `dplyr`.

### Join, merge, look up

__Problem__: You have two data sources and you need info from both in one new data object. Sometimes you have a primary data object and the other is secondary. That feels like "table look up" to me. Sometimes the data sources are equally important. That feels more like a "merge" to me. Under the hood, these are still the same type of problem.

__Solution__: Perform a __join__, which borrows terminology from the database world, specifically SQL.

__Background reading__:

  * I have made a [`dplyr` join cheatsheet](bit001_dplyr-cheatsheet.html), which includes base function `merge()`.
  * In 2013, the [demo of mapping Gapminder countries into colors](http://www.stat.ubc.ca/~jenny/STAT545A/block15_colorMappingBase.html) used base functions `match()` and `merge()` to bring country color information into Gapminder.
  * If that's not enough, [Google is your friend](http://www.google.com/search?q=r+merge+match)

__Possible activities__:

Activity #1

  * Create a second data.frame, complementary to Gapminder. Join this with (part of) Gapminder using a `dplyr` join function, `merge()`, and/or `match()` and make some observations about the process and result. Explore the different types of joins. Examples:
    - One row per country, a country variable and one or more variables with extra info, such as language spoken, NATO membership, national animal, or capitol city.
    - One row per continent, a continent variable and one or more variables with extra info, such as northern versus southern hemisphere.
    
Activity #2

  * Create your own cheatsheet patterned after mine but focused on something you care about. Examples:
    - Pets I have owned + breed + friendly vs. unfriendly + ??. Join to a table of pet breed, including variables for furry vs not furry, mammal true or false, etc.
    - Movies and studios....
    - Athletes and teams....

You will likely need to iterate between your data prep and your joining to make your explorations comprehensive and interesting. For example, you will want a specific amount (or lack) of overlap between the two data.frames, in order to demonstrate all the different joins. You will want both the data.frames to be as small as possible, while still retaining the expository value.

### Data aggregation based on lists and arrays

We [worked with `plyr::ddply()`](http://stat545-ubc.github.io/block013_plyr-ddply.html) for an important special case in data aggregation:

  * input is a data.frame
  * it is split up into sub-data.frames based on one or more factors
  * a non-trivial computation is applied to each sub-data.frame
  * the results are re-assembled and the ultimate output is a data.frame

In this special case, there are competing `dplyr` workflows, namely using `group_by()` and `do()` available, but I chose to show `ddply()` due to its approachable syntax for very general problems.

__Problem__: What if you need to do this sort of operation on something other than a data.frame? Like a vector or matrix or array or list? And what if you need something other than a data.frame back?

__Solution__: Use `plyr`. Specifically the functions that start and end with `l` for list or `a` for array, e.g. `laply()`, `ldply()`, `llply()`, `l_ply()`.

__Background reading__ on basics of data aggregation and `plyr`:

  * Intro to the [`plyr::ddply()` lesson](http://stat545-ubc.github.io/block013_plyr-ddply.html)
  * Big picture [slides about data aggregation on slideshare](http://www.slideshare.net/jenniferbryan5811/cm009-data-aggregation)
  * The split-apply-combine strategy for data analysis. Hadley Wickham. Journal of Statistical Software, vol. 40, no. 1, pp. 1–29, 2011. <http://www.jstatsoft.org/v40/i01/paper>

__Possible activities__:

Activity #1

  * Use `dlply()` to enact linear regression on each Gapminder country:
  
    - input = Gapminder data as a data.frame
    - split on country
    - apply computation = fit our usual linear model of life expectancy on year
    - combine those fitted models into a list; not some clean little extract like the estimated coefficients, but the actual `lm` objects    
  * Explore that list until you feel comfortable with it
    - `str()`, `length()`, `names()`, etc.
    - `foo[[i]]`, `foo[["Canada"]]`, `str(foo[[i]])`, etc.
  * Use `ldply()` to pull information out of the fitted models. Examples:
    - pull out the estimated coefficients; output = a data.frame with one row per country and variables `country`, `intercept`, `slope`
    - pull out the estimated coefficients; output = a data.frame with two rows per country and variables `country`, factor `coefficient` with levels intercept and slope, numeric variable `value` with estimated coefficient
    - pull out the fitted values and residuals; output a data.frame with 12 rows per country and variables `country`, `year`, `lifeExp`, `fitted`, `resid`
    - use the `tidy()` function from the [`broom` package](https://github.com/dgrtwo/broom) to get a full inferential table on the regression coefficients; output = a data.frame with two rows per country and variables `country`, variable identifying which coefficient, plus variables for the estimate, estimated std error, $t$ statistic, and p-value (Getting Genetics Done has a nice [blog post on `broom`](http://gettinggeneticsdone.blogspot.ca/2014/09/r-package-convert-statistical-analysis-object-tidy-data-frame.html))

__Reflect on__ things like this:

  * Why might you use the `ldply()` + more wrangling approach over `ddply()`? Hint: Think about this in terms of the [DRY principle ("don't repeat yourself")](http://code.tutsplus.com/tutorials/3-key-software-principles-you-must-understand--net-25161): "Every piece of knowledge must have a single, unambiguous, authoritative representation within a system."
  * Find an example of this in your work: One (input, output) pair can be achieved with two different workflows. Describe the competing workflows in terms of different choices of:

    - how to split up the data
    - what computation to apply
    - the "shape" or form of the outputs
    - how the outputs are combined into one object
    - reshaping

Activity #2

  * Use `plyr` or `dplyr` to write out the data for each country to a separate delimited file in a sub-directory, like `country_data`, with good names, like `Canada.tsv`.
  * Use `list.files()` to capture the file listing of this sub-directory as a character vector (which is an array). Use this array as input below.
  * Use one or more `plyr` functions starting with `a` to do something for each country. Examples:
    - Use `adply()` to read the mini datasets back in and re-combine to recreate the original Gapminder data.
    - Use `aaply()` to read the mini datasets back in and retain one single piece of info, such as the continent, the number of rows, or the maximum life expectancy. When recombined, you will have have an atomic vector (which is an array).
    - Use `alply()` to read the mini datasets back in and fit a linear model for life expectancy against time.
    - Use `a_ply()` to read the mini datasets back in, create a country-specific plot, and write it to file.

### General data reshaping and relationship to aggregation

__Problem__: You have data in one "shape" but you wish it were in another. Usually this is because the alternative shape is superior for presenting a table, making a figure, or doing aggregation and statistical analysis.

__Solution__: Reshape your data. For simple reshaping, `gather()` and `spread()` from `tidyr` will suffice. If that fails, use the more powerful tools under the hood: `melt()`, `dcast()`, and `acast()` from `reshape2`.

__Background reading__:

  * Tidy data by Hadley Wickham. Journal of Statistical Software. Vol. 59, Issue 10, Sep 2014. <http://www.jstatsoft.org/v59/i10>
  * `tidyr` package on [GitHub](https://github.com/hadley/tidyr) and [CRAN](http://cran.r-project.org/web/packages/tidyr/index.html) (read the vignette!)
  * Tyler Rinker's [minimal guide to `tidyr`](https://github.com/trinker/tidyr_in_a_nutshell)
  * We used the `gather()` function from the `tidyr` package to reshape the [Lord of the Rings wordcount data](https://github.com/jennybc/lotr) in [this lesson](http://stat545-ubc.github.io/bit002_tidying-lotr-data.html).
  - [`reshape2`](https://github.com/hadley/reshape) package

__Possible activities__:

__NOTE: I PLAN TO PICK SPECIFIC CHALLENGES TO LIST HERE BUT FEEL FREE TO CHOOSE YOUR OWN.__

  * Pick from this [2013 challenge list on data aggregation](http://www.stat.ubc.ca/~jenny/STAT545A/hw03_dataAggregation.html).
  * 2013 [HW03](http://www.stat.ubc.ca/~jenny/STAT545A/hw03_dataAggregation.html) and [HW04](http://www.stat.ubc.ca/~jenny/STAT545A/hw04_univariateLattice.html) have good data aggregation/reshaping tasks and companion figures.
  * Solve these challenges in different ways.
    - `dplyr` wasn't on my radar last year but you know how to use it.
    - `tidyr` didn't even exist yet. Use it.
    - We aren't really covering `reshape2`, but many of you are ready to read up on `melt()` and `dcast()/acast()` and try them out.
  * TA Andrew MacDonald has a nice [data manipulation sampler](https://gist.github.com/aammd/11386424). Make up a similar set of exercises for yourself, in the abstract or (even better) using Gapminder or other data, and solve them.
