# Do's and Don'ts for Effective Graphs



*In 2015, this was mercifully replaced by a [guest lecture from UBC colleague Tamara Munzner](http://stat545-ubc.github.io/cm014_viz-design-munzner.html). The content below would be better with links to specific figures from Naomi Robbins' book, but the Shiny app does not make that possible. Or perhaps I should just embed my versions of them.*

### Goal: create more effective graphs

According to Naomi Robbins, effective graphs "improve understanding of data". They do not confuse or mislead.

To paraphrase: Most of us use a computer to write but we would never characterize a Nobel prize winning writer as being highly skilled with Microsoft Word. Similarly, advanced `ggplot2` skills won't necessarily lead to effective communication of numerical data. You have to master the __principles of effective graphs__ in addition to the mechanics.

> One graph is more effective than another if its quantitative information can be decoded more quickly or more easily by most observers.

When I'm lost in data and struggling to make a figure, I repeat this mantra distilled from Gelman, et al:

  * Facilitate comparisons
  * Reveal trends

*CMEG = Naomi Robbins' book ["Creating More Effective Graphs"](http://www.amazon.com/Creating-Effective-Graphs-Naomi-Robbins/dp/0985911123); visual catalog of figures via the [R Graph Catalog](http://shiny.stat.ubc.ca/r-graph-catalog/)*

### No no's

#### Pie charts

The [most loathed graph of all](http://www.google.com/search?q=pie+charts+suck) and yet surprisingly common. Give your average person a bunch of numbers that add up to one and they want to make a pie chart. Why? My hypothesis is it goes back to all the pies and pizzas referenced when kids learn to work with fractions.

Why do the pros hate pie charts? They are awful because they encode quantitative information in angles and areas, which are very hard for humans to judge. Skeptical? Read on.

Examples from CMEG and the [R Graph Catalog](http://shiny.stat.ubc.ca/r-graph-catalog/):

  * Try to place the wedges in order from largest to smallest based on the pie chart in Fig 1.1. Now do same using the dot plot in Fig 1.2. Which figure made this task easier? Which presentation of this data improves your understanding of the data? Reflect on the same info presented as a table, Fig 1.3.
  * Try to decode the data from the pie chart in Fig 2.2. Now do the same using the dot plot in Fig 2.3.
  
We are best able to make comparisons via position of objects along a common scale, which is why these simple dot plots are so much more effective than the pie charts.

#### More pie charts

Tufte, as quoted by Robbins: "the only worse design than a pie chart is several of them."

  * "Problem 2: pie charts are worse at showing trends" from [Three reasons that pie charts suck](http://www.richardhollins.com/blog/why-pie-charts-suck/) shows a series of 3 pie charts versus a line chart.
  * Rob Hyndman nominated a 3 pie chart series as [the worst figure](http://robjhyndman.com/hyndsight/worst-figure/), which has the added horror of cross-hatching. Sorry, no before and after here. Do for [Homework 06](hw06_repo-hygiene-figure-boss.html) anyone?

#### Stacked and group bar charts

The average person, if told they should not make a pie chart, might then take that bunch of numbers for different categories and make a stacked bar chart. Especially if they have a a series of such numbers. But this is also a very difficult graph to decode.

  * Fig 8.11 from CMEG (not in the Catalog) presents a series of 4 pie charts, showing various nations' share of world car production from 1977 to 1980. The same data is presented as a stacked bar chart in Fig 8.12. How easy is it to figure out which countries are gaining and losing share? Now take a look at the facetted line chart in Fig 8.13. BOOM!
  
Stacked bar charts are difficult to decode because we need a common baseline to judge changes in length. So the trend for the category on the "ground floor" is easy to see but trends for those  stuck in the middle are hard to see.

  * Fig 5.1 shows petroleum stocks held by various countries over time as a stacked bar chart. Again it's easy to see the trend for the US, which sits on the "ground floor," but who knows what's going on with other countries. Fig 5.2 and 5.3 show alternative presentations that are much more effective.

Grouped bar charts also make it hard to see trends.

  * Fig 8.1 shows high, average, and low prices for gold over time as a stacked bar chart. The same info is presented differently in Fig 8.2, to much better effect.
  
Grouped bar charts are difficult because it's hard to make comparisons between things that aren't adjacent or at least very near each other.

#### Self-contradiction

When your text (especially the caption!) and the figure contradict each other, it undermines the reader's trust in everything you present. You can dramatically reduce your ability to shoot yourself in the foot this way by using an integrated reporting approach, such as R Markdown. If figures are made from live R code in chunks and numbers are inserted via live inline R code, the two cannot diverge.

Barring that, my advice is to proofread like a maniac.

#### Using Microsoft Excel to obscure your data and annoy your readers

We will look through this section (slides 1 - 36) of Karl Broman's excellent talk How to Display Data Badly (see References for links).

### Do: make the data stand out

This animation created by Darkhorse Analytics illustrates how communication can be greatly enhanced by eliminating clutter and de-emphasizing supporting elements. Every aspect of a figure should be there on a "need to have it" basis.

![](img/less-is-more-darkhorse-analytics.gif)
<!--http://i.imgur.com/WntrM6p.gif-->

In CMEG, Figs 6.2 vs 6.3 make much the same point, i.e. stripping the figure way down is a huge improvement. Figs 5.4 and 5.5 are both decent graphs but using dots (Fig 5.5) instead of bars (Fig 5.4) improves the data:ink ratio.

### Do: spare your reader from mental gymnastics

If you're going to talk about the difference between this and that, then please go ahead a plot the difference between this and that! Sure, it might be nice to plot this and that, on their own, but don't stop there. *You've got a computer. And software.* Use them to do annoying arithmetic for your reader.

  * Figs 2.14 and 2.15 show imports to England and exports from England from long ago. But if you are interested in the balance of trade, imports - exports, then plot that! It's very hard to do this well in your head.
  * Fig 2.16 show the function $y = 1/x^2$ and the same function shifted vertically by a constant. But the figure is incredibly deceptive, underscoring how bad we are at taking differences.
  * Figs 8.3, 8.4, 8.5, 8.6 show the time taken for subjects to do annoying things, like set the clock on their VCR, with two different sets of instructions. The original graph spread this out over 10 small bar charts, but the next 3 graphs present more direct looks at the improvement offered by revised instructions.

### Do: use position along a common scale

We are best able to make comparisons if items are positioned along a common scale. Design your graphs to take advantage of this.

We have a harder time with area, volume, length of non-adjacent things, length without a common baseline, angle, color, and shape.

  * Fig 2.18 shows a poorly ordered bubble plot that depicts population of various cities. It's really hard to order the cities by population, until you look at the clean dot plot in Fig 2.19.
  * Figs 6.24 and 6.25 encode numbers in the area of rectangles and triangles, respectively, when a simple bar chart or dotplot would have been better.  

### Do: take control of aspect ratio

We can see differences in angles when they're around 45 degrees. But as they get steeper, our ability to compare goes down quickly. You control the angles of line segments in your graphs by controlling the *aspect ratio*. Pick the ratio so that the "average line segment" is around 45 degrees, a.k.a. banking to 45.

  * Fig 7.1 shows how a proper aspect ratio makes it easier to see that the sunspot data rises much faster than it falls.

### Do: think about including zero

There is no global rule about whether axis limits must be chosen to include zero. It depends.

Robbins proposes you always include it in bar charts, but use your judgement with, e.g., line charts or dot plots.

Figs 7.3, 7.4, and 7.5 explore the inclusion of zero.

### Do: choose the scale with intention

Logarithically transformed scales are useful when

  * it makes sense to think of changes on a multiplicative scale, instead of additive.
    - example: gene expression ratios are naturally viewed on the log 2 scale, where 0 represents a ratio of 1 and equal expression and -1 and 1 represent ratios of 1/2 and 2, respectively
  * the data are skewed

Figs 7.7 and 7.8 show a skewed dataset before and after log transformation. We are also used to logging the `gdpPercap` variable in the Gapminder data, for the same reasons.

How about presenting two scales for the same axis?

  * It is OK to present tick marks in different "units," i.e. temperature in Fahrenheit vs. Celsius (Fig 7.16) or GDP per capita in raw dollars versus on the log 10 scale. However, this is not easy to do in `ggplot2`!
  * It is NOT OK to present two entirely different scales, just so you can squeeze two different variables onto the same plot.
    - Figs 7.17 and 7.18 explore how deceptive this can be.
  * Even if variables are technically reported in the same units, it might make a better graph to use facets and choose axis limits accordingly.
    - Figs 7.19 and 7.21 show the importance of facetting when looking at levels of blood lipids.

### Do: connect the dots with care

Consider two quantitative variables, where the x-axis is time or something similar. There are many legitimate ways to present such data. In `ggplot2` jargon, there are many relevant geoms.

  * Fig 4.17 shows a single time series presented 4 different ways, each serving a different purpose.
  * Fig 4.21 presents another line graph, showing used car price against mileage of car. Connecting these dots allows buyers and sellers to determine fair value, even if a specific car's mileage is not in the dataset.

Beware connecting the dots when the x axis represents an unordered categorical variable.

  * Figs 4.22, 4.23, and 4.24 depict mountain heights for different continents. The connecting line can be misleading here. What it the graph were targetted at an audience that speaks a different language? Even alphabetical is not a well-defined ordering. Unless sorting on size, best to avoid connecting these dots (and even then one must be careful).

### Do: convey groups clearly

Consider two quantitative variables, plus a third categorical variable. How to encode the factor?

If superposing, you have shape, filled-ness, and color at your disposal.

  * Figs 6.6 and 6.7 explore using these singly or, often better, in combination.

It is often better to avoid superposition and, instead, to put the groups into different facets.

  * Fig 6.8 revisits the data from Figs 6.6 and 6.7, but using facetting. Gridlines can be very helpful to faciliate comparisons across facets.
  * Figs 6.9 and 6.10 make this point for line charts.

#### A tour of the Do's

We will look through another section (slides 48 - 62) of Karl Broman's excellent talk How to Display Data Badly (see References for links).

### Resources

["Creating More Effective Graphs"](http://www.amazon.com/Creating-Effective-Graphs-Naomi-Robbins/dp/0985911123) by [Naomi Robbins](http://www.nbr-graphs.com)

The [R Graph Catalog](http://shiny.stat.ubc.ca/r-graph-catalog/) presents the figures from ["Creating More Effective Graphs"](http://www.amazon.com/Creating-Effective-Graphs-Naomi-Robbins/dp/0985911123) as a visual quilt. Click on a figure to see the `ggplot2` code that makes it.

Karl Broman's talk "How to display data badly"

  * Home on GitHub: https://github.com/kbroman/Talk_Graphs
  * The version I showed is the [combined PDF from the iowastate2013 branch](https://www.biostat.wisc.edu/~kbroman/presentations/IowaState2013/graphs_combined.pdf)

[`ggplot2`](http://ggplot2.org) written by [Hadley Wickham](http://hadley.github.io)

[Winston Chang's](https://github.com/wch) book ["R Graphics Cookbook"](http://shop.oreilly.com/product/0636920023135.do) and the [Graphs section](http://www.cookbook-r.com/Graphs/) of his [Cookbook for R website](http://www.cookbook-r.com/)

My [`ggplot2` tutorial](https://github.com/jennybc/ggplot2-tutorial)

"Let's Practice What We Preach: Turning Tables into Graphs" by Gelman A, Pasarica C, Dodhia R. *The American Statistician*, Volume 56, Number 2, 1 May 2002 , pp. 121-130(10). via [JSTOR](http://www.jstor.org/discover/10.2307/3087382?uid=2&uid=4&sid=21104340349921)

<!--
#### Distribution one quantitative variable

stripplot (+ summary stats, jittering) Fig 4.1, 4.8
histogram Fig 4.6
densityplot
boxplot
combinations of the above

#### Two quantitative variables

scatterplot + regression line / smooth
high volume scatterplots
-->
