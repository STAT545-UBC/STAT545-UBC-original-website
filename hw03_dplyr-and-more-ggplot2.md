---
title: "Homework 03: Use dplyr to manipulate and explore data (also use ggplot2)"
output:
  html_document:
    toc: true
    toc_depth: 4
---

### Overview

Consult the [general homework guidelines](hw00_homework-guidelines.html).

Due before class Monday 2014-09-29.

The goal is to manipulate and explore a dataset with the `dplyr` package, complemented by visualizations made with `ggplot2`. In particular, we keep our focus on working with a `data.frame` (but note: `dplyr` can work with other data storage formats seamlessly).

Remember the [sampler concept](http://en.wikipedia.org/wiki/Sampler_(needlework)). Your homework should serve as your own personal cheatsheet in the future for ways to manipulate a dataset and produce companion figures. Give yourself the cheatsheet you deserve!

#### Gapminder data

Work with the [Gapminder excerpt](http://tiny.cc/gapminder). *If you really, really want to, you can explore a different dataset but get permission from Jenny.*

#### HW Guts

__THIS IS JUST A DRAFT, FOR ANYONE WHO WANTS TO START EARLY.__

*I will adapt parts of [homework 3](http://www.stat.ubc.ca/%7Ejenny/STAT545A/hw03_dataAggregation.html) and [homework 4](http://www.stat.ubc.ca/%7Ejenny/STAT545A/hw04_univariateLattice.html) from 2013. 2013's Homework 3 relied on the `ddply()` function from the `plyr` package, but we have not covered that yet. Plus, `dplyr` is the nicer way to do such things now. So the adaptation will revolve around that. The idea of creating "graphical companions" to your data aggregation results will be retained.*

#### But I want to do more!

*This is just for people who want to take things further! NOT REQUIRED!*

Ask and ye shall receive! This will probably just be posing some more complicated `dplyr`-ish challenges......
  
### Report your process

You're encouraged to reflect on what was hard/easy, problems you solved, helpful tutorials you read, etc.

### Submit the assignment

Follow instructions on [How to submit homework](hw00_homework-guidelines.html#how-to-submit-homework)

### Rubric

__Start using our [general rubric](peer-review01_marking-rubric.html) for specifics to evaluate! The form will require you to do so!__

Check minus: Hits the elements listed above in a really minimal or rote way, maybe even with a few mistakes/omissions. And/or it's hard to figure out which file I'm even supposed to be looking at.

Check: Hits all the elements. No obvious mistakes. Pleasant to read. No heroic detective work required. Solid.

Check plus: Some "above and beyond", creativity, etc. You learned something new from reviewing their work and you're eager to incorporate it into your work now.