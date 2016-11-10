---
title: "Homework 06: Data wrangling conclusion"
output:
  html_document:
    toc: true
    toc_depth: 4
---

### Overview

Consult the [general homework guidelines](hw00_homework-guidelines.html).

Due anytime Monday 2016-11-14.

Pick (at least) two of the topics below and do one of the exercise prompts
listed, or something comparable.

### Character data

Read and work the exercises in the [Strings
chapter](http://r4ds.had.co.nz/strings.html) or R for Data Science.

### Writing functions

Pick one:

  * Write one (or more) functions that do something useful to pieces of the
Gapminder data. It is logical to think about computing on the mini-data frames
corresponding to the data for each specific country. This would pair well with
the prompt below about working with a nested data frame, as you could apply your
function there.
    - Make it something you can't easily do with built-in functions.
Make it something that's not trivial to do with the simple `dplyr` verbs. The
linear regression function [presented
here](block012_function-regress-lifeexp-on-year.html) is a good starting point.
You could generalize that to do quadratic regression (include a squared term) or
use robust regression, using `MASS::rlm()` or `robustbase::lmrob()`.
  * If you plan to complete the homework where we build an R package, write a couple of experimental functions exploring some functionality that is useful to you in real life and that might form the basis of your personal package.

### Work with the candy data

In 2015, we explored a dataset based on a Halloween candy survey (but it
included many other odd and interesting questions). Work on something from [this
homework from 2015](hw07_2015_data-wrangling-candy.html). It is good practice on basic
data ingest, exploration, character data cleanup, and wrangling.

### Work with a list

Work through and write up a lesson from the [purrr
tutorial](https://jennybc.github.io/purrr-tutorial/index.html):

  * [Trump Android
Tweets](https://jennybc.github.io/purrr-tutorial/ls08_trump-tweets.html)
  * [Simplifying data from a list of GitHub
users](https://jennybc.github.io/purrr-tutorial/ls02_map-extraction-advanced.html)

### Work with a nested data frame

Create a nested data frame and map a function over the list column holding the
nested data. Use list extraction or other functions to pull interesting
information out of these results and work your way back to a simple data frame
you can visualize and explore.

Here's a fully developed prompt for Gapminder:

  * See the [split-apply-combine lesson from
class](block024_group-nest-split-map.html)
  * Nest the data by country (and continent).
  * Fit a model of life expectancy against year. Possibly quadratic,
possibly robust (see above prompt re: function writing).
  * Use functions for working with fitted models or the [broom
package](https://github.com/tidyverse/broom) to get information out of your
linear models.
  * Use the usual dplyr, tidyr, and ggplot2 workflows to explore,
e.g., the estimated cofficients.

Inspiration for the modelling and downstream inspiration

  * Find countries with interesting stories. - Sudden, substantial departures from the temporal trend is interesting. How could you operationalize this notion of "interesting"?
  * Use the residuals to detect countries where your model is a
terrible fit. Examples: Are there are 1 or more freakishly large residuals, in
an absolute sense or relative to some estimate of background variability? Are
there strong patterns in the sign of the residuals? E.g., all pos, then all neg,
then pos again.
  * Fit a regression using ordinary least squares and a robust
technique. Determine the difference in estimated parameters under the two
approaches. If it is large, consider that country "interesting".
  * Compare a linear and quadratic fit

### Report your process

You're encouraged to reflect on what was hard/easy, problems you solved, helpful
tutorials you read, etc. Give credit to your sources, whether it's a blog post,
a fellow student, an online tutorial, etc.

### Submit the assignment

Follow instructions on [How to submit
homework](hw00_homework-guidelines.html#how-to-submit-homework)

### Rubric

Check minus: One or more elements are missing or sketchy. Missed opportunities
to complement code and numbers with a figure and interpretation. Technical
problem that is relatively easy to fix. It's hard to find the report in this
crazy repo.

Check: Hits all the elements. No obvious mistakes. Pleasant to read. No heroic
detective work required. Well done! *This should be the most typical mark!*

Check plus: Exceeded the requirements in number of dimensions. Developed novel
tasks that were indeed interesting and "worked". Impressive use of R -- maybe
involving functions, packages or workflows that weren't given in class
materials. Impeccable organization of repo and report. You learned something new
from reviewing their work and you're eager to incorporate it into your work.
