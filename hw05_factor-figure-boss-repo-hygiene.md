---
title: "Homework 05: Factor and figure management; Repo hygiene"
output:
  html_document:
    toc: true
    toc_depth: 4
---

### Overview

Consult the [general homework guidelines](hw00_homework-guidelines.html).

Due anytime Wednesday 2015-10-28.

Goals:

  * Reorder a factor in a principled way based on the data and demonstrate the effect in arranged data and in figures.
  * Remake at least one previously made figure, in light of recent coverage of visualization design principles.
  * Write a figure to file explicitly and include it your R Markdown report via `![Alt text](/path/to/img.png)`.
  * Clean up your repo, to celebrate the completion of STAT 545 and/or to prepare for the glorious future of STAT 547.

Remember the [sampler concept](http://en.wikipedia.org/wiki/Sampler_(needlework)). Your homework should serve as your own personal cheatsheet in the future for how to be the boss of your factors and how to write data to file so you don't kick yourself when you read it back in.

#### Gapminder data ... or whatever

You can work with the [Gapminder excerpt](http://tiny.cc/gapminder) or take this chance to play with something else. In which case, you'll have to create comparable tasks for yourself.

### Factor management

**Drop Oceania.** Filter the Gapminder data to remove observations associated with the `continent` of Oceania. Additionally, Use `droplevels()` to remove unused factor levels. Provide concrete information on the data before and after removing these rows and Oceania; address the number of rows and the levels of the affected factors. Use a figure that includes a legend to further explore the effects of filtering data and/or changing factor levels.

**Reorder the levels of `country` or `continent`.** Use `reorder()` to change the order of the factor levels, based on a summary statistic of one of the quantitative variables or another derived quantity, such as estimated intercept or slope. If you use a summary of, e.g., life expectancy, try something besides the default of `mean()`.

Characterize the (derived) data before and after your factor re-leveling.

  * Explore the effects of `arrange()`. Does merely arranging the data have any effect on, say, a figure?
  * Explore the effects of `reorder()` and `reorder()` + `arrange()`. What effect does this have on a figure?
  * These explorations should involve the data, the factor levels, and some figures.

### Visualization design

Remake at least one figure, in light of something you learned in the recent class meetings about visualization design and color. Maybe juxtapose before and after and reflect on the differences. Consult the guest lecture from Tamara Munzner and [everything here](graph00_index.html).

### Writing figures to file

Use `ggsave()` to explicitly write a figure to file. Then use `![Alt text](/path/to/img.png)` to embed it in your report. Things to play around with:

  * Arguments of `ggsave()`, such as width, height, resolution or text scaling.
  * Various graphics devices, e.g. a vector vs. raster format.
  * Explicit provision of the plot object `p` via `ggsave(..., plot = p)`. Show a situation in which this actually matters.
  
### Clean up your repo!

You have 6 weeks of R Markdown and GitHub experience now. You've reviewed 8 peer assignments. Surely there are aspects of your current repo organization that could be better. Deal with that. Ideas:

  * A nice Table of Contents in top-level README that links to individual pieces of work.
    - Good for future: `hw03 dplyr verbs`
    - Bummer in the future: `hw03`
    - Include a slug with content info!
  * Remove all downstream stuff, e.g. figures, html, etc. and re-render everything. It will be nice to not have weird, vestigial files lying around to puzzle you in future.
  * Anything that's `Rmd` but that could be `md`? Convert it.

### But I want to do more!

Play with the `factor(, ... levels = ...)` function for explicitly setting factor levels. It's behavior can be surprising!

  - Can you create a gotcha, i.e. do something that seems natural but gives an unexpected result?
  - Experiment with using `stringsAsFactors = FALSE` in `read.table()` followed by an explicit call to `factor()`. When might you do this?
  - Can you use it to set factor levels to the order in which they appear in the data? Can you exploit that as a way to transmit factor level order even with the `write.table() / read.table()` workflow?
  - Can you use it to apply factor levels from one version of a factor to another? Specifically, reorder `country` based on estimated slope or intercept in `j_coefs` THEN apply those factor levels back to `country` in the raw Gapminder data.
  
Revalue a factor

  * Pick a handful of countries, each of which you can associate with a stereotypical food (or any other non-controversial thing ... sport? hobby? type of music, art or dance? animal? landscape feature?). Create an excerpt of the Gapminder data, filtered to just these countries. Create a new factor -- you pick the name! -- and use one or more of these functions to map the existing `country` factor levels into new ones.
    - from `plyr` package: `revalue()` or `mapvalues()`
    - from `car` package: `recode()` 
    * Examples: Italy --> wine, Germany --> beer, Japan --> sake. (Austria, Germany) --> German, (Mexico, Spain) --> Spanish, (Portugal, Brazil) --> Portuguese. Let your creativity flourish.
    
Experiment with gluing two factors together. What if they have the same levels? Different levels? Try it gluing two "naked" factors together, then try it again when those factors are embedded in conformable two data.frames.

### Report your process

You're encouraged to reflect on what was hard/easy, problems you solved, helpful tutorials you read, etc. Give credit to your sources, whether it's a blog post, a fellow student, an online tutorial, etc.

### Submit the assignment

Follow instructions on [How to submit homework](hw00_homework-guidelines.html#how-to-submit-homework)

### Rubric

Check minus: One or more elements are missing or sketchy. Missed opportunities to complement code and numbers with a figure and interpretation. Technical problem that is relatively easy to fix. It's hard to find the report in this crazy repo.

Check: Hits all the elements. No obvious mistakes. Pleasant to read. No heroic detective work required. Well done! *This should be the most typical mark!*

Check plus: Exceeded the requirements in number of dimensions. Developed novel tasks that were indeed interesting and "worked". Impressive use of R -- maybe involving functions, packages or workflows that weren't given in class materials. Impeccable organization of repo and report. You learned something new from reviewing their work and you're eager to incorporate it into your work.
