---
title: All the graph things
output:
  html_document:
    toc: true
    toc_depth: 4
---

We work on visualiation throughout the course. Here are the bits roughly in order of presentation.

  * R graphics landscape *[slides](http://www.slideshare.net/jenniferbryan5811/cm005-intro-ggplot2)*
    - why we prefer `ggplot2` (or `lattice`) over base R graphics
    - the underappreciated importance of data.frames, tidy data, and factor management to graphics
    - basic jargon of `ggplot2`
  * Lots of hands-on work; indicative code and resulting figures can be found in my [`ggplot2` tutorial](https://github.com/jennybc/ggplot2-tutorial)
    - scatterplots, stripplots, distributions, bars, themes, managing a color scheme, bubble and line plots
  * [Do's and don'ts of making effective graphs](block015_graph-dos-donts.html)
  * The [R Graph Catalog](http://shinyapps.stat.ubc.ca/r-graph-catalog/) presents a visual, clickable index of 100+ figures, mostly from Naomi Robbins' book ["Creating More Effective Graphs"](http://www.amazon.com/Creating-Effective-Graphs-Naomi-Robbins/dp/0985911123). For each figure, you can juxtapose the figure and the exact `ggplot2` code to produce it. Code for all the figures and the app available from [GitHub](https://github.com/jennybc/r-graph-catalog)
  * Colors
    - How to think about color and get good palettes in R *[2013 materials](http://www.stat.ubc.ca/~jenny/STAT545A/block14_colors.html)*
    - How to make `ggplot2` use your color palette *[2013 materials](http://www.stat.ubc.ca/~jenny/STAT545A/block17_colorsGgplot2Qualitative.html)*
  * Practical pro tips, i.e. a return to mechanics
    - [Secrets of a happy graphing life](block016_secrets-happy-graphing.html): data.frames! tidy data! factors!
    - writing figures to file, explicitly and implicitly, e.g. `ggsave()` & friends and chunk name --> figure name
    - multiple plots on a "page"; many examples in [R graph catalog](http://shinyapps.stat.ubc.ca/r-graph-catalog/) and [`multiplot()` from Cookbook for R](http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/)
    - underappreciated basics: density plots, high-volume scatterplots
