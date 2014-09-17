---
title: "Homework 02: Explore Gapminder and use R markdown"
output:
  html_document:
    toc: true
    toc_depth: 4
---

### Overview

Consult the [general homework guidelines](hw00_homework-guidelines.html).

Due before class Monday 2014-09-22.

The goal is to practice exploring a dataset. In particular, to establish workflows based on `data.frame`. You will make a couple of figures with `ggplot2`. You will learn how to author a dynamic report in R Markdown and share it on the web.

### Draft of HW guts

Work with the Gapminder excerpt from this week. If you really, really want to, you can explore a different dataset but get permission from Jenny.

Import the data with `read.delim()` and with `read.table()`. FYI: `read.delim()` is just a wrapper around `read.table()` with specific arguments set to certain values. Read the documentation!

  * Try simple calls to both functions. Do you get the same resulting object in your workspace? Use all the ways we've learned to inspect an object to back up your claims with hard facts.
  * If you're not getting the same object, why not?
  * Develop the call to `read.table()` that is equivalent to `read.delim()`, i.e. how do you need to set various arguments.
  
Determine and report basic facts like the number of observations and which variables are there and what sort of variables they are.

Make at least one figure.

Report some very basic descriptive statistics, such as results from `summary()`. 

There is no requirement to go beyond what we've presented in class/tutorials, but of course it's great if your curiosity leads you to go further.

### Report your process

You're encouraged to reflect on what was hard/easy, problems you solved, helpful tutorials you read, etc.

### Submit the assignment

Follow instructions on [How to submit homework](http://stat545-ubc.github.io/hw00_homework-guidelines.html#how-to-submit-homework)

### Rubric

Check minus: ???

Check: something in between

Check plus: ???