---
title: "Homework 02: Explore Gapminder and use R markdown"
output:
  html_document:
    toc: true
    toc_depth: 4
---

### Overview

**2015-09-22: I'm going to refresh this for 2015 but this is 95% current. Want to switch to use the `gapminder` data package and to change the "play around" optional stretch goals.**

Consult the [general homework guidelines](hw00_homework-guidelines.html).

Due before class Tuesday 2015-09-29.

The goal is to explore a newly imported a dataset. In particular, to establish workflows based on `data.frame`. You will make a couple of figures with `ggplot2`. You will learn how to author a dynamic report in R Markdown and share it on the web.

Remember the [sampler concept](http://en.wikipedia.org/wiki/Sampler_(needlework)). Your homework should serve as your own personal cheatsheet in the future for things to do with a new dataset. Give yourself the cheatsheet you deserve!

#### Bring rectangular data in

Work with the [Gapminder excerpt](http://tiny.cc/gapminder) introduced this week. *If you really, really want to, you can explore a different dataset but get permission from Jenny.*

Import the data with the gapminder package. If it's not installed, just type `install.packages("gapminder")` in the R shell. To use the gapminder dataset, we need to import this package by the command `library(gapminder)`. Then you can start using the gapminder data.frame, though it's not shown in the environment block in RStudio.


#### Smell test the data

Explore your new data.frame.

  * Is it a data.frame, a matrix, a vector, a list?
  * What's its mode, class?
  * How many variables?
  * How many rows/observations?
  * Can you get these facts about "extent" or "size" in more than one way? Can you imagine different functions being useful in different contexts?
  * What flavor is each the variable?
  
#### Explore individual variables

Pick __at least__ one categorical variable and at least one quantitiative variable to explore.

  * Characterize what's possible, i.e. all possible values or max vs. min ... whatever's appropriate.
  * What's typical? What's the spread? What's the distribution? Etc., tailored to the variable at hand.
  * Feel free to use summary stats, tables, figures. We're NOT expecting high production value (yet).
  
#### But I want to do more!

*This is just for people who want to take things further! NOT REQUIRED!*

Play with this visual tool for exploring tabular data:

  * <http://setosa.io/blog/2014/08/03/csv-fingerprints/>
  * Yeah, you might need to get the Gapminder excerpt into comma delimited form to use the tool. See above re: being optional.
  
Check out the [`testdat`](https://github.com/ropensci/testdat) package. Does it ease the pain of getting your `read.table()` arguments "just right"?

  * <https://github.com/ropensci/testdat>
  * Yeah, you will have to install from GitHub instead of CRAN. See above re: being optional.
  
Read [What I do when I get a new data set as told through tweets](http://simplystatistics.org/2014/06/13/what-i-do-when-i-get-a-new-data-set-as-told-through-tweets/) from [SimplyStatistics](http://simplystatistics.org) to get some ideas!
  
### Report your process

You're encouraged to reflect on what was hard/easy, problems you solved, helpful tutorials you read, etc.

### Submit the assignment

Follow instructions on [How to submit homework](hw00_homework-guidelines.html#how-to-submit-homework)

### Rubric

__Start using our [general rubric](peer-review01_marking-rubric.html) for specifics to evaluate, but be gentle this week!__

Check minus: Hits the elements listed above in a really minimal or rote way, maybe even with a few mistakes/omissions. And/or it's hard to figure out which file I'm even supposed to be looking at.

Check: Hits all the elements. No obvious mistakes. Pleasant to read. No heroic detective work required. Solid.

Check plus: Some "above and beyond", creativity, etc. You learned something new from reviewing their work and you're eager to incorporate it into your work now.
