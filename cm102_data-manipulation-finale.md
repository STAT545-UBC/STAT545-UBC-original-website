---
output:
  html_document:
    toc: true
---

### cm102 2014-10-22 Wednesday overview

  * STAT 545A [HW06](hw06_repo-hygiene-figure-boss.html) *Optional, unmarked* activities for the STAT 545A / STAT 547M transition. Submit the usual way, so we know you've done it.
  * New schedule for homework: Due the Thursday 8 days after a topic is covered on Mon + Wed.
    - HW07 due Thursday October 29; will cover this weeks material.
  * What's coming?
    - Today: conclude main coverage of data manipulation. Mostly hands-on exercises. Free time to get help with a new dataset or start on exercises that will become the homework.
    - Week of Oct 27: Data cleaning, regular expressions, wrangling character data (Gloria Li)
    - Week of Nov 03: Task automation and building pipelines (Shaun Jackman)
    - Week of Nov 10: Build your first R package (Bernhard Konrad)
    - Week of Nov 17: Build your first Shiny app (Julia Gustavsen)
    - Week of Nov 24: Get data off the web (Andrew MacDonald)
  * TODAY:
    - Complete [tidy data lesson](bit002_tidying-lotr-data.html)
    - Prompts for student's choice exercises on more advanced data wrangling tasks
    
### Advanced data wrangling

#### Join and merges

When do you need to join or merge or "look up"? When you have two data sources and you need info from both. Examples:

  * You want to bring info into the Gapminder data.frame on ... language spoken, NATO membership, number of medals won at recent Olympics, latitude + longitude or capitol city, etc.
  * The second data source would have one row per country, a country variable, and one or more variables with this extra information.

Explore joins and merges with this [`dplyr` join cheatsheet](bit001_dplyr-cheatsheet.html).

Inspiration for an activity:

  * Set up two data.frames based on the Gapminder data.
  * Example: a country-focused table (more rows, in a relative sense) and a continent-focused table (fewer rows).
  * Analogy with the cheatsheet: countries = superheros, continents = publishers.
  * Continent-focused table should contain a novel variable, such as northern vs southern hemisphere. Analogy with the cheatsheet: hemisphere = year publisher founded.
  * Explore the various joining operations.
  * You will likely need to iterate between your data prep and your joining to make your explorations comprehensive and interesting. For example, you will want a specific amount (or lack) of overlap between the two data.frames, in order to demonstrate all the different joins. You will want both the data.frames to be as small as possible, while still retaining the expository value.

Further ideas:

If you just need to add one piece of information, such as "year founded" or "hemisphere", you could do that using the base R function `match()`. Do that. Which join(s) can be emulated with a `match()`-based approach and how?

#### Use of `plyr` with arrays and lists

We [worked with `plyr::ddply()`](http://stat545-ubc.github.io/block013_plyr-ddply.html) for an important special case in data aggregation:

  * input is a data.frame
  * it is split up into sub-data.frames based on one or more factors
  * a non-trivial computation is applied to each sub-data.frame
  * the results are re-assembled and the ultimate output is a data.frame

In this special case, there are competing `dplyr` workflows, namely using `group_by()` and `do()` available, but I chose to show `ddply()` due to its approachable syntax for very general problems.

But what if you need to do this sort of operation on something other than a data.frame? Like a vector or matrix or array or list? And what if you need something other than a data.frame back? That is an area covered by `plyr` (and not covered by `dplyr`).

Refresh your understanding of the data aggregation and `plyr` basics:

  * Intro to the [`plyr::ddply()` lesson](http://stat545-ubc.github.io/block013_plyr-ddply.html)
  * Big picture [slides about data aggregation on slideshare](http://www.slideshare.net/jenniferbryan5811/cm009-data-aggregation)

Inspiration for an activity:

  * Use `dlply()` to enact linear regression on each Gapminder country:
  
    - input = Gapminder data as a data.frame
    - split on country
    - apply computation = fit our usual linear model of life expectancy on year
    - combine those fitted models into a list; not some clean little extract like the estimated coefficients, but the actual `lm` object
    
    
  * Explore that list until you feel comfortable with it
  
    - `str()`, `length()`, `names()`, etc.
    - `foo[[i]]`, `foo[["Canada"]]`, `str(foo[[i]])`, etc.
    
  * Use `ldply()` to pull information out of the fitted models. Examples:
  
    - pull out the estimated coefficients; output = a data.frame with one row per country and variables `country`, `intercept`, `slope`
    - pull out the estimated coefficients; output = a data.frame with two rows per country and variables `country`, factor `coefficient` with levels intercept and slope, numeric variable `value` with estimated coefficient
    - pull out the fitted values and residuals; output a data.frame with 12 rows per country and variables `country`, `year`, `lifeExp`, `fitted`, `resid`
    - use the `tidy()` function from the [`broom` package](https://github.com/dgrtwo/broom) to get a full inferential table on the regression coefficients; output = a data.frame with two rows per country and variables `country`, variable identifying which coefficient, plus variables for the estimate, estimated std error, $t$ statistic, and p-value (Getting Genetics Done has a nice [blog post on `broom`](http://gettinggeneticsdone.blogspot.ca/2014/09/r-package-convert-statistical-analysis-object-tidy-data-frame.html))
    
What are some reasons why you'd use the `ldply()` + more wrangling approach over `ddply()` like we did originally? Hint: Think about this in terms of the [DRY principle ("don't repeat yourself")](http://code.tutsplus.com/tutorials/3-key-software-principles-you-must-understand--net-25161): "Every piece of knowledge must have a single, unambiguous, authoritative representation within a system."

Can you see more than one way to accomplish these sorts of tasks? Pick one (input, output) pair and describe at least two ways to convert the input to the output. These will come from different combinations of choices of:

  * how to split up the data
  * what computation to apply
  * the "shape" or form of the outputs
  * how the outputs are combined into one object
  * reshaping

If you can cultivate an attitude of "to any problem, there are multiple solutions," you will spend less time banging your head against the wall in data analysis. If something's really hard, sneak up on it from a different angle.

#### General data reshaping and relationship to aggregation

We have talked about [tidy data](bit002_tidying-lotr-data.html) and have used the `gather()` function from the `tidyr` package. The converse function is `tidyr::spread()`, which is also important but comes up less often.

The powerful package under the hood of `tidyr` is [`reshape2`](https://github.com/hadley/reshape). The functions `gather()` and `spread()` are friendlier but less powerful versions of the true workhorses in `reshape2`: `melt()` and `dcast()/acast()`.

There is a strong inter-relationship between data aggregation and reshaping. Usually there are multiple solutions to a data wrangling problem: you can perform the data aggregation one way, then follow with some reshaping or you could aggregate another way and eliminate the need for reshaping.

Ideas for activities:

  * Pick from this [2013 challenge list on data aggregation](http://www.stat.ubc.ca/~jenny/STAT545A/hw03_dataAggregation.html).
  * 2013 [HW03](http://www.stat.ubc.ca/~jenny/STAT545A/hw03_dataAggregation.html) and [HW04](http://www.stat.ubc.ca/~jenny/STAT545A/hw04_univariateLattice.html) have good data aggregation/reshaping tasks and companion figures.
  * Solve these challenges in different ways.
    - `dplyr` wasn't on my radar last year but you know how to use it.
    - `tidyr` didn't even exist yet. Use it.
    - We aren't really covering `reshape2`, but many of you are ready to read up on `melt()` and `dcast()/acast()` and try them out.
  * TA Andrew MacDonald has a nice [data manipulation sampler](https://gist.github.com/aammd/11386424). Make up a similar set of exercises for yourself, in the abstract or (even better) using Gapminder or other data, and solve them.