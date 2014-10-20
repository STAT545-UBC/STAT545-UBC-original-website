---
title: All the graph things
output:
  html_document:
    toc: true
    toc_depth: 4
---

We work on visualiation throughout the course. Here are the bits in rough order of presentation.

  * R graphics landscape *[slides](http://www.slideshare.net/jenniferbryan5811/cm005-intro-ggplot2)*
    - why we prefer `ggplot2` (or `lattice`) over base R graphics
    - the underappreciated importance of data.frames, tidy data, and factor management to graphics
    - basic jargon of `ggplot2`
  * Learning `ggplot2` by using it
    - my [`ggplot2` tutorial](https://github.com/jennybc/ggplot2-tutorial) gives indicative code and all resulting figures 
    - scatterplots, stripplots, distributions, bars, themes, managing a color scheme, bubble and line plots
  * [Do's and don'ts of making effective graphs](block015_graph-dos-donts.html)
    - Effective = easy for audience to decode numerical info
    - Our ability to decode position along common axis >> area, angle, color, etc. 
  * The [R Graph Catalog](http://shinyapps.stat.ubc.ca/r-graph-catalog/) presents a visual, clickable index of 100+ figures
    - mostly from Naomi Robbins' book ["Creating More Effective Graphs"](http://www.amazon.com/Creating-Effective-Graphs-Naomi-Robbins/dp/0985911123)
    - see figure and the exact `ggplot2` code to produce it, side-by-side
    - code for all figures and app itself is on [GitHub](https://github.com/jennybc/r-graph-catalog)
  * Colors
    - [Using colors in R](block018_colors.html)
    - [Taking control of qualitative colors in `ggplot2`](block019_enforce-color-scheme.html)
  * Practical pro tips, i.e. a return to mechanics
    - [Secrets of a happy graphing life](block016_secrets-happy-graphing.html): data.frames! tidy data! factors!
    - [Writing figures to file](block017_write-figure-to-file.html)
    - [Multiple plots on a page](block020_multiple-plots-on-a-page.html)
    <!--
    - underappreciated basics: density plots, high-volume scatterplots
    good stuff here:
    http://www.ugrad.stat.ubc.ca/~stat540/seminars/seminar03_graphics-ggplot2.html
    -->