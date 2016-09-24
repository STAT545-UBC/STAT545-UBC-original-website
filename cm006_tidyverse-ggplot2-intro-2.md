---
output:
  html_document:
    toc: true
    toc_depth: 4
---

### cm006 2016-09-22 Thursday overview

  * You should have submitted [Homework 01](hw01_edit-README.html) Tuesday.
    - Peer review is open, as described in [this issue](https://github.com/STAT545-UBC/Discussion/issues/330).
    - Technically it's "due" Monday but I'd prefer you do it sooner. You might learn something from seeing your peer's work or *vice versa*, which could lead to better work on Homework 02.
  * [Homework 02](hw02_explore-gapminder-dplyr.html) due next Tuesday 2016-09-27.
  * Today. Continuing to draw from (and then revising) these topics:
    - Care and feeding of data frames -- or tibbles! -- with the [`tidyverse`](https://github.com/hadley/tidyverse)
    - Slides with very simple view of some R objects [on Speakerdeck](https://speakerdeck.com/jennybc/simple-view-of-r-objects)
    - [Basic care and feeding of data in R](block006_care-feeding-data.html)
    - [Introduction to dplyr](block009_dplyr-intro.html)
    - [`dplyr` functions for a single dataset](block010_dplyr-end-single-table.html)
    - Indicative code from this week's live coding in class: [`cm005_hello-gapminder-tidyverse.R`](https://github.com/STAT545-UBC/STAT545-UBC.github.io/blob/master/cm005_hello-gapminder-tidyverse.R)
    - A first look at `ggplot2`
    - [`ggplot2` tutorial](https://github.com/jennybc/ggplot2-tutorial)
  * Read the "Explore" chapters in [R for Data Science](http://r4ds.had.co.nz)
   
#### Slides

Slides for my ggplot2 tutorial are available on [speakerdeck](https://speakerdeck.com/jennybc/ggplot2-tutorial)

<script async class="speakerdeck-embed" data-id="f5ebca79660c4c3eb05b5bfbe1018545" data-ratio="1.33333333333333" src="//speakerdeck.com/assets/embed.js"></script> <div style="margin-bottom:5px"> <strong> <a href="https://speakerdeck.com/jennybc/ggplot2-tutorial" title="ggplot2 tutorial" target="_blank">ggplot2 tutorial</a> </strong> from <strong><a href="https://speakerdeck.com/jennybc" target="_blank">Jennifer Bryan</a></strong> </div>

#### Links

All the material for a tutorial I give on `ggplot2` is on Github:

  * <https://github.com/jennybc/ggplot2-tutorial>
  
[ggplot2: Elegant Graphics for Data Analysis](http://www.amazon.com/dp/0387981403/ref=cm_sw_su_dp?tag=ggplot2-20), the `ggplot2` book by Hadley Wickham. Hadley and Carson Sievert are working on a new edition. You can watch the whole process and get all the content from GitHub:
  
 * <https://github.com/hadley/ggplot2-book>
 * The [companion website](http://ggplot2.org/book/) for the existing edition offers one R script per chapter, providing the code used in the book.

[`ggplot2` online docs](http://docs.ggplot2.org/current/)

[`ggplot2` "homepage"](http://ggplot2.org)

[`ggplot2` package development on github](https://github.com/hadley/ggplot2) 

[The R Graphics Cookbook](http://shop.oreilly.com/product/0636920023135.do), an excellent book by Winston Chang. *I really really love this book.*

- The [graphs section](http://www.cookbook-r.com/Graphs/) of Winston Chang's website Cookbook for R. The book listed above contains much more material, but the website is good too.

A [`ggplot2` tutorial](http://stcorp.nl/R_course/tutorial_ggplot2.html) by Paul Hiemstra, one of [many excellent R courses](http://stcorp.nl/R_course/) he offers.

[A quick introduction to ggplot2](http://inundata.org/2013/04/10/a-quick-introduction-to-ggplot2/) by Karthik Ram. Slides and code from a 2 hour talk/hands on presentation for ggplot2 beginners.

Why do I teach `ggplot2`? Shouldn't beginners see "base" graphics first? I think not. David Robinson explains it well in [Don't teach built-in plotting to beginners (teach ggplot2)](http://varianceexplained.org/r/teach_ggplot2_to_beginners/).

Zev Ross has a lovely blog post: [Beautiful plotting in R: A ggplot2 cheatsheet](http://zevross.com/blog/2014/08/04/beautiful-plotting-in-r-a-ggplot2-cheatsheet-3/)
