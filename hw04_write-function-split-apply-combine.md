---
title: "Homework 04: Use split-apply-combine with your functions within data.frames"
output:
  html_document:
    toc: true
    toc_depth: 4
---

### Overview

Consult the [general homework guidelines](hw00_homework-guidelines.html).

Due sometime Friday 2015-10-16. *I am open to negotiation if the lateness of this posting is creating hardship.*

The goal is to write one (or more) custom functions that do something useful to pieces of the Gapminder data. Then use `dplyr::do()` to apply to all such pieces. Then use `dplyr()` and or `ggplot2` to explore what you got back.

Remember the [sampler concept](http://en.wikipedia.org/wiki/Sampler_(needlework)). Your homework should serve as your own personal cheatsheet in the future for how to write a function and how to scale up its application with data aggregation machinery.

#### Gapminder data

Work with the [Gapminder excerpt](https://cran.r-project.org/package=gapminder). *If you really, really want to, you can explore a different dataset but get permission from Jenny.*

### Your mission, high-level

Write a function to compute something interesting on a piece of the Gapminder data. Make it something you can't easily do with built-in functions. Make it something that's not trivial to do with the simple `dplyr` verbs.

  * The linear regression function [we wrote together in cm011](block012_function-regress-lifeexp-on-year.html) is a good example.
  * Record some of the process. In fact, you might want to draft two R Markdown files for this assignment. One to develop and test the function. Another to apply it and explore results. Just like we split it up in class.

Use `dplyr::do()` to apply your function to all possible pieces of the Gapminder dataset and return the combined result.

Explore the results you get back. Use all your usual tricks, so I expect to see alot of `dplyr` and `ggplot2` here.

Make observations about what your tables/figures show and about the process.

### Inspiration for what to compute

Find countries with interesting stories. Remember this one from last week? You are even better equipped to tackle it now. Here are some ideas to get you thinking. Feel free to riff on them -- I don't expect rote implementation. Some of these ideas will impact the function you write AND the follow-up exploration.

  * Sudden, substantial departures from the temporal trend is interesting. This goes for life expectancy, GDP per capita, or population. How could you operationalize this notion of "interesting"?

  * Fit a regression of the response vs. time. Use the residuals to detect countries where your model is a terrible fit. Example:
    
    - Are there are 1 or more freakishly large residuals, in an absolute sense or relative to some estimate of background variability?
    
    - Are there strong patterns in the sign of the residuals? E.g., all pos, then all neg, then pos again.

  * Fit a regression using ordinary least squares and a robust technique. Determine the difference in estimated parameters under the two approaches. If it is large, consider that country "interesting". Check out `lmrob()` in [`robustbase`](http://cran.r-project.org/web/packages/robustbase/index.html).
  
Wear your statistical hat and characterize how well/poorly the simple linear model is working. Via residual analysis. Or by fitting something more complicated (but still appropriate for $n$ = 12!) -- like a degree 2 polynomial. Retain quantities that speak to goodness-of-fit and explore that across all 142 countries.

Do anything we've discussed so far but for a different combination of variables. How is GDP per capita changing over time? How about the relationship between GDP per capita and life expectancy?

### Exploration of the results

Once you've found something interesting to compute and you've used `dplyr::do()` to enact the computation broadly, it's vital that you digest and interpret the results.

This will probably mean some sorting, filtering, etc. All your `dplyr` skills will come in handy. There's probably a couple of interesting tables to make.

Whenever possible, include a companion figure that adds context to the numbers and bolsters your comments. The figure does not have to depict exactly or only what the table does -- it just needs to reinforce the connection back to the underlying data.

### But I want to do more!

Do your main data aggregation task with `dplyr::group_by() + do()` AND `plyr::ddply()`. Reflect on the pros/cons of the two approaches.

Explore more functions in the `broom` package.

Explore `plyr`'s capabilities to work with vectors, multi-dimensional arrays, and lists. Get outside the safe little world of data.frames.

Take a look at [`purrr`](https://github.com/hadley/purrr) for functional programming more generally. Here's a [blog post](http://lionel-.github.io/2015/10/08/using-purrr-with-dplyr/) by one of the authors on combining `purrr` and `dplyr`.
  
### Report your process

You're encouraged to reflect on what was hard/easy, problems you solved, helpful tutorials you read, etc. Give credit to your sources, whether it's a blog post, a fellow student, an online tutorial, etc.

### Submit the assignment

Follow instructions on [How to submit homework](hw00_homework-guidelines.html#how-to-submit-homework)

### Rubric

__Start using our [general rubric](peer-review01_marking-rubric.html) for specifics to evaluate! The form will require you to do so!__

Check minus: *One or more problems such as ...* Student's custom function was exactly what we did in class or a very modest extension. Exploration of the data aggregation results is missing or minimal. Student missed clear opportunities to complement numbers with a figure. Technical problem(s) that are relatively easy to fix. Repository organization -- or lack thereof -- leaves work for the reader, in terms of finding the necessary files.

Check: Hits all the elements. No obvious mistakes. Pleasant to read. No heroic detective work required. Solid.

Check plus: Exceeded the requirements in number of dimensions. Developed novel tasks that were indeed interesting and "worked". Impressive use of `dplyr`, `plyr`, `broom`, and/or `ggplot2`. Impeccable organization of repo and report. You learned something new from reviewing their work and you're eager to incorporate it into your work.
