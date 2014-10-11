---
title: "Homework 05: Prove you are in control of factors by writing and reading files"
output:
  html_document:
    toc: true
    toc_depth: 4
---

### Overview

Consult the [general homework guidelines](hw00_homework-guidelines.html).

Due anytime Thursday 2014-10-16.

The goal is to reorder a factor in a principled way based on the data and to demonstrate how this reordering is (is not) preserved in various approaches to writing and reading data to file.

This content should provide everything you need:

  * [Be the boss of your factors](block014_factors.html)
  * [Indicative code from cm011 hands on activities](https://github.com/STAT545-UBC/STAT545-UBC.github.io/blob/master/cm011_files-out-in-script.r) re: writing and reading files
  * [polished 2013 lesson](http://www.stat.ubc.ca/~jenny/STAT545A/block05_getNumbersOut.html) on reading and writing files *only substantive difference to 2014 is we've switched to using `dplyr` for data manipulation*

Remember the [sampler concept](http://en.wikipedia.org/wiki/Sampler_(needlework)). Your homework should serve as your own personal cheatsheet in the future for how to be the boss of your factors and how to write data to file so you don't kick yourself when you read it back in.

#### Gapminder data

Work with the [Gapminder excerpt](http://tiny.cc/gapminder). *Now is a good time to think seriously about finding another dataset, but have a very high standard of cleanliness!*

### Drop Oceania

Filter the Gapminder data to remove everything associated with the `continent` of Oceania. Use `droplevels()` to remove unused factor levels. Provide concrete information on the data before and after removing these rows and Oceania; address the number of rows, the number and identity of the continents and countries.

### Model life expectancy as a function of year

For each country, retain estimated intercept and slope from a linear fit -- regressing life expectancy on year. I include `country` AND `continent` in the factors on which to split, so that the `continent` factor appears in my result. The country-specific estimated intercepts and slopes, in the data.frame `j_coefs`, will be used in exercises below.

```r
library(plyr)
j_coefs <- ddply(gDat, ~ country + continent, function(dat, offset = 1952) {
  the_fit <- lm(lifeExp ~ I(year - offset), dat)
  setNames(coef(the_fit), c("intercept", "slope"))
})
```

Perform a basic characterization and description of the `j_coef` object. Use inline R code to embed some relevant number(s) into the text.

### Order of data vs. order of factor levels

Consider `post_arrange`, `post_reorder`, and `post_both` as defined below.

```r
library(dplyr)
post_arrange <- j_coefs %>% arrange(slope)
post_reorder <- j_coefs %>%
  mutate(country = reorder(country, slope))
post_both <- j_coefs %>%
  mutate(country = reorder(country, slope)) %>%
  arrange(country)
```

How do the three objects differ? Don't just assert this -- show, with code, how they differ. Discuss the differences in terms of utility within an exploratory analysis.

In the definition of `post_both`, if I swapped out `arrange(country)` for `arrange(slope)`, would I get the same result? Do you have any preference for one arrange statement over the other? Hint: what if the `reorder()` command got changed to `reorder(country, intercept)` or `reorder(country, gdpPercap, max)`... which `arrange()` statement seems best now? Why?

### Revalue a factor

Pick a handful of countries, each of which you can associate with a stereotypical food (or any other non-controversial thing ... sport? hobby? type of music, art or dance? animal? landscape feature?). Create an excerpt of the Gapminder data, filtered to just these countries. Create a new factor -- you pick the name! -- and use one or more of these functions to map the existing `country` factor levels into new ones.

  * from `plyr` package: `revalue()` or `mapvalues()`
  * from `car` package: `recode()` 
  
Examples: Italy --> wine, Germany --> beer, Japan --> sake. (Austria, Germany) --> German, (Mexico, Spain) --> Spanish, (Portugal, Brazil) --> Portuguese. Let your creativity flourish.

Make a table and/or a figure that provides clear proof that your new factor is a revalued version of `country`.

### Reorder a factor

Pick one of the factors `country` or `continent` to reorder.

If you're reordering `country`, you can filter the data even further, though you don't have to.

Reorder the factor in a principled way, based on information in the quantitative variables `lifeExp`, `gdpPercap`, `pop`. It could be simple (average life expectancy in 2002) or more involved (extreme ratio of life expectancy to GDP per capita, median correlation between life expectancy and GDP per capita).

Make a figure (and table?) that shows (summarized?) data before and after the reordering. In fact, one way to choose your reordering is to revisit a figure you've made or seen in someone else's work and to do a reordering that makes the figure more informative.

### Write and read data to file

As we did [in class](cm011_files-out-in.html), write data to file, remove the associated object from the workspace, read the data back in. Compare the object before and after this "round trip". Practice using functions like `all.equal()`, `identical()`, and/or functions from `assertthat` or `ensurer` to confirm sameness or detect difference.

Show clearly if object survives unscathed. If not, what has changed?

Cover these methods:

  * `write.table()` + `read.table()`
    - What sort of argument values for writing out and reading in work well together?
  * `saveRDS()` + `readRDS()`
  * `dput()` + `dget()`
  
Write up what you have learned. When will you use one strategy over another? What conventions will you follow about naming the object file and the object to which you reassign it? Think about your future policies for writing information to file for downstream use.

### But I want to do more!

Play with the `factor(, ... levels = ...)` function for explicitly setting factor levels. It's behavior can be surprising!

  - Can you create a gotcha, i.e. do something that seems natural but gives an unexpected result?
  - Experiment with using `stringsAsFactors = FALSE` in `read.table()` followed by an explicit call to `factor()`. When might you do this?
  - Can you use it to set factor levels to the order in which they appear in the data? Can you exploit that as a way to transmit factor level order even with the `write.table() / read.table()` workflow?
  - Can you use it to apply factor levels from one version of a factor to another? Specifically, reorder `country` based on estimated slope or intercept in `j_coefs` THEN apply those factor levels back to `country` in the raw Gapminder data.
  
Learn to love `dput()`. Fit some sort of model to the data from one country. Use `dput()` to write a plain text representation of this to file. Clean out the workspace, restart R. Create a new R script. Use `dget()` and copy/paste from the `dput()`ed file to initialize your script with R code that creates this fitted object in the clean workspace. Use one of the many functions for extracting info from the fitted model object (e.g. `coef()`, `resid()`, `deviance()`, `summary()`) to get info on the model. Appreciate the power of `dput()` to create plain text representations of R objects!

Experiment with gluing two factors together. What if they have the same levels? Different levels? Try it gluing two "naked" factors together, then try it again when those factors are embedded in conformable two data.frames.

### Report your process

You're encouraged to reflect on what was hard/easy, problems you solved, helpful tutorials you read, etc. Give credit to your sources, whether it's a blog post, a fellow student, an online tutorial, etc.

### Submit the assignment

Follow instructions on [How to submit homework](hw00_homework-guidelines.html#how-to-submit-homework)

### Rubric

__Start using our [general rubric](peer-review01_marking-rubric.html) for specifics to evaluate! The form will require you to do so!__

Check minus: One or more elements are missing or sketchy. Missed opportunities to complement code and numbers with a figure and interpretation. Technical problem that is relatively easy to fix. It's hard to find the report in this crazy repo.

Check: Hits all the elements. No obvious mistakes. Pleasant to read. No heroic detective work required. Well done! *This should be the most typical mark!*

Check plus: Exceeded the requirements in number of dimensions. Developed novel tasks that were indeed interesting and "worked". Impressive use of R -- maybe involving functions, packages or workflows that weren't given in class materials. Impeccable organization of repo and report. You learned something new from reviewing their work and you're eager to incorporate it into your work.