---
title: "Homework 03: Use dplyr to manipulate and explore data (also use ggplot2)"
output:
  html_document:
    toc: true
    toc_depth: 4
---

### Overview

Consult the [general homework guidelines](hw00_homework-guidelines.html).

Due sometime Tuesday 2017-10-03.

The goal is to manipulate and explore a dataset with the dplyr package, complemented by visualizations made with ggplot2.

Remember the [sampler concept](http://en.wikipedia.org/wiki/Sampler_(needlework)). Your homework should serve as your own personal cheatsheet in the future for ways to manipulate a dataset and produce companion figures. Give yourself the cheatsheet you deserve!

#### Gapminder data

Work with the [Gapminder excerpt](http://tiny.cc/gapminder). *If you really want to, you can explore a different dataset but get permission from Jenny. Self-assess the suitability of your dataset by reading [this issue](https://github.com/STAT545-UBC/Discussion/issues/115).*

### Your mission, high-level

Pick at least three of the tasks below and attack each with a table and figure.

  * dplyr should be your data manipulation tool
  * ggplot2 should be your visualization tool

Make observations about what your tables/figures show and about the process.

If you want to do something comparable but different, i.e. swap one quantitative variable for another, be my guest! If you are feeling inspired and curious, then we're doing this right. Go for it.

Relax about the following things:

  * Tidying/reshaping is NOT your assignment. Many of your tables will be awkwardly shaped in the report. That's OK.
  * Table beauty is not a big deal. Simply printing to "screen" is fine. You could also try the `knitr::kable()` function. Assuming `my_df` is a data.frame, here's an R chunk that should print it as a decent-looking table:

<pre><code>```{r results = 'asis'}
knitr::kable(my_df)
```</code></pre>

  * For all things, graphical and tabular, if you're dissatisfied with a result, discuss the problem, what you've tried and move on.

### Task menu

Get the maximum and minimum of GDP per capita for all continents.

Look at the spread of GDP per capita within the continents.

Compute a trimmed mean of life expectancy for different years. Or a weighted mean, weighting by population. Just try something other than the plain vanilla mean.

How is life expectancy changing over time on different continents?

Report the absolute and/or relative abundance of countries with low life expectancy over time by continent: Compute some measure of worldwide life expectancy – you decide – a mean or median or some other quantile or perhaps your current age. The determine how many countries on each continent have a life expectancy less than this benchmark, for each year.

Find countries with interesting stories. Open-ended and, therefore, hard. Promising but unsuccessful attempts are encouraged. This will generate interesting questions to follow up on in class.

Make up your own! Between the dplyr coverage in class and the list above, I think you get the idea.

### Companion graphs

For each table, make sure to include a relevant figure.

Your figure does not have to depict every last number from the data aggregation result. Use your judgement. It just needs to complement the table, add context, and allow for some sanity checking both ways.

Notice which figures are easy/hard to make, which data formats make better inputs for plotting functions vs. for human-friendly tables.

### But I want to do more!

Layout stretch goal: get table and figure side-by-side. [This gist](https://gist.github.com/jennybc/e9e9aba6ba18c72cec26) might get you started.

Table stretch goal: there are some really nice fancy table helper packages. [This tweet from \@polesasunder](https://twitter.com/polesasunder/status/464132152347475968) will point you toward some R packages you may want to check out (pander, xtable, stargazer).

### Report your process

You're encouraged to reflect on what was hard/easy, problems you solved, helpful tutorials you read, etc. Give credit to your sources, whether it's a blog post, a fellow student, an online tutorial, etc.

### Submit the assignment

Follow instructions on [How to submit homework](hw00_homework-guidelines.html#how-to-submit-homework)

### Rubric

__Start using our [general rubric](peer-review01_marking-rubric.html) for specifics to evaluate! The form will require you to do so!__

Check minus: Didn't tackle at least 3 tasks. Or didn't make companion graphs. Didn't interpret anything but left it all to the "reader". Or more than one technical problem that is relatively easy to fix. It's hard to find the report in this crazy repo.

Check: Hits all the elements. No obvious mistakes. Pleasant to read. No heroic detective work required. Solid.

Check plus: Exceeded the requirements in number of tasks. Or developed novel tasks that were indeed interesting and "worked". Impressive use of dplyr and/or ggplot2. Impeccable organization of repo and report. You learned something new from reviewing their work and you're eager to incorporate it into your work.
