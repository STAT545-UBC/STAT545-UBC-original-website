---
title: "Homework 02: Explore Gapminder and use R markdown"
output:
  html_document:
    toc: true
    toc_depth: 4
---

**WARNING: 2015 version!!**

### Overview

Consult the [general homework guidelines](hw00_homework-guidelines.html).

Due sometime Tuesday 2015-09-29. Before class is better but get help in class or office hours of you need it.

The goal is to explore a new-to-you dataset. In particular, to establish workflows based on `data.frame`. You will make several figures with `ggplot2`. You will learn how to author a dynamic report in R Markdown and share it on the web.

Remember the [sampler concept](http://en.wikipedia.org/wiki/Sampler_(needlework)). Your homework should serve as your own personal cheatsheet in the future for things to do with a new dataset. Give yourself the cheatsheet you deserve!

#### Bring rectangular data in

Work with the `gapminder` data we explored in class. *If you really want to, you can explore a different dataset but get permission from Jenny. Self-assess the suitability of your dataset by reading [this issue](https://github.com/STAT545-UBC/Discussion/issues/115).*

The Gapminder data is distributed as an R package from [CRAN](https://cran.r-project.org/web/packages/gapminder/index.html). 

Install it if you have not done so already and remember to load it.

``` r
install.packages("gapminder")
library(gapminder)
```

#### Smell test the data

Explore the `gapminder` object:

  * Is it a data.frame, a matrix, a vector, a list?
  * What's its mode, class?
  * How many variables/columns?
  * How many rows/observations?
  * Can you get these facts about "extent" or "size" in more than one way? Can you imagine different functions being useful in different contexts?
  * What flavor is each variable?
  
#### Explore individual variables

Pick __at least__ one categorical variable and at least one quantitative variable to explore.

  * Characterize what's possible, i.e. all possible values or max vs. min ... whatever's appropriate.
  * What's typical? What's the spread? What's the distribution? Etc., tailored to the variable at hand.
  * Feel free to use summary stats, tables, figures. We're NOT expecting high production value (yet).
  
#### Explore various plot types

See the [`ggplot2` tutorial](https://github.com/jennybc/ggplot2-tutorial), which also uses the `gapminder` data for ideas. But I want to see you exploring multiple types of plot.
  
#### But I want to do more!

*This is just for people who want to take things further! NOT REQUIRED!*

Do more statistical summarization and visual exploration. For example, start to look at the relationships between variables.

Read [What I do when I get a new data set as told through tweets](http://simplystatistics.org/2014/06/13/what-i-do-when-i-get-a-new-data-set-as-told-through-tweets/) from [SimplyStatistics](http://simplystatistics.org) to get some ideas!
  
### Report your process

You're encouraged to reflect on what was hard/easy, problems you solved, helpful tutorials you read, etc.

### Submit the assignment

Follow instructions on [How to submit homework](hw00_homework-guidelines.html#how-to-submit-homework)

### Rubric

Our [general rubric](peer-review01_marking-rubric.html) applies, but also ...

Check minus: Hits the elements listed above in a really minimal or rote way, maybe even with a few mistakes/omissions. And/or it's hard to figure out which file I'm even supposed to be looking at.

Check: Hits all the elements. No obvious mistakes. Pleasant to read. No heroic detective work required. Solid.

Check plus: Some "above and beyond", creativity, etc. You learned something new from reviewing their work and you're eager to incorporate it into your work now.
