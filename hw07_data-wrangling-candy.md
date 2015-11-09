---
title: "Homework 07: Data Wrangling"
output:
  html_document:
    toc: true
    toc_depth: 4
---

Due date: TBD, probably between Nov 11th-17th?

###Overview
The goal of this homework is to perform a complete data wrangling workflow using the [Candy Survey data]( https://github.com/jennybc/candy).

It is vital that you finish some task, nachos to cheesecake. We want a bit of story, some tables, some figures. Keep scaling back the cleaning and reshaping until you can manage this. Then scale up until you run out of time or patience.

###Your mission

Bring the Candy Survey data – or part of it – to a ready-to-analyze state and complete some exploratory / analytical task.

Some example tasks:

* Easy: Examining how joy/despair scores change with age

* Medium: Comparing the joy/despair values of different types of candy (Chocolate vs. “true candy” like Nerds/Starburst)

* Medium: Looking for predictors of candy preference (i.e. in the non-candy fields, or perhaps looking at correlations between candy preferences).

* Hard: Looking for ‘structure’ in the data. For example, are there classes of individuals with similar candy preference profiles? 

###Sections of the Assignment

####Examining the raw data and choosing a task
Familiarize yourself with the raw data if you haven’t already. Based on the information available, formulate a task you want to complete and explain what it is. Make it fairly specific, like the tasks above.

####Wrangling
Based on the task you chose, get the data in a workable format. This will likely involve all kinds of fun dropping columns, using regex to clean text and headers, some tidyr for gathering, etc. Divide each step by a unique heading in your document. By the end, you will likely want things in tidy data format so you can easily use dplyr/ggplot for your analysis/exploration.

####Exploring/Analyzing
Now that your data us ready to analyze, complete the task you set out to complete! This will also be multipart, so again divide things up logically. Perhaps you will start with some basic exploration + tables to get a sense of the data, and then move onto dplyr and plotting.

####But I Want to Do More!
Taking a sufficiently difficult/ambitious task to completion would certainly qualify you for a check plus, but here are some other ideas:

*	Mine some of the free text fields for data using regular expressions

*	Join in the 2014 data and compare Joy/Despair results.

###Rubric

The [general rubric](http://stat545-ubc.github.io/peer-review01_marking-rubric.html) applies, and in addition:

Check minus: Student did not sufficiently complete any of the above sections, or performed a trivially simple task. Weak application of wrangling skills learned in class. Student missed clear opportunities to complement numbers with a figure. Technical problem(s) that are relatively easy to fix. Repository organization – or lack thereof – leaves work for the reader, in terms of finding the necessary files.

Check: Hits all the elements. You chose a reasonable task, wrangling the data, and completed the task. No obvious mistakes. Pleasant to read. No heroic detective work required. Solid.

Check plus: Exceeded the requirements in number of dimensions. Chose an ambitious/difficult task and pulled it off. Impressive use of dplyr, plyr, broom, and/or ggplot2. Impeccable organization of repo and report. You learned something new from reviewing their work and you’re eager to incorporate it into your work.


