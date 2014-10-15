---
output:
  html_document:
    toc: true
---

### cm012 2014-10-15 Wednesday overview

  * [HW05](hw05_factor-boss-files-out-in.html) due anytime Thursday 2014-10-16. Last official homework of STAT545A. For those going on to STAT547M, this means a one week break in *marked* homework.
  * [HW06](hw06_repo-hygiene-figure-boss.html) *Optional, unmarked* activities for the STAT 545A / STAT 547M transition
  * What's coming?
    - Week of Oct 20: Tidy data, data reshaping, `plyr` beyond `ddply()`, joins and merges
    - Week of Oct 27: Data cleaning, regular expressions, wrangling character data (Gloria Li)
    - Week of Nov 03: Task automation and building pipelines (Shaun Jackman)
    - Weeks of Nov 10, 17, 24, order TBD: building an R package, building a Shiny app, getting data off the web
  * TODAY: More about making graphs!
    - [Do's and Don'ts of effective graphs](block015_graph-dos-donts.html)
    - Practical Pro Tips *there's no way we'll get to all this today*
      - tidy data! data.frames! factors! see [tutorial slides](https://github.com/jennybc/ggplot2-tutorial/blob/master/ggplot2-tutorial-slides.pdf)
      - writing figures to file, explicitly; see [2013 topic](http://www.stat.ubc.ca/~jenny/STAT545A/topic12_writeFigureToFile.html) and [tutorial slides](https://github.com/jennybc/ggplot2-tutorial/blob/master/ggplot2-tutorial-slides.pdf) (vector vs. raster, `ggsave()`, open device + plot + close device, `dev.print()`) 
      - chunk names --> figure names 
      - taking control of colors; see [2013 guidance on general colors](http://www.stat.ubc.ca/~jenny/STAT545A/block14_colors.html) and [2013 taking control of qualitative colors in `ggplot2`](http://www.stat.ubc.ca/~jenny/STAT545A/block17_colorsGgplot2Qualitative.html)
      - multiple plots on a "page"; many examples in [R graph catalog](http://shinyapps.stat.ubc.ca/r-graph-catalog/) and [`multiplot()` from Cookbook for R](http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/)
      - density plots, high-volume scatterplotting, fancy plots (see [some from 2013](http://www.stat.ubc.ca/~jenny/STAT545A/block18_gapminderGgplot2VsLattice.html)) 

Interesting links that aren't included in the pages referenced above

  * [Ten Simple Rules for Better Figures](http://www.ploscompbiol.org/article/info:doi/10.1371/journal.pcbi.1003833) PLoS CompBio
  * [Twenty rules for good graphics](http://robjhyndman.com/hyndsight/graphics/) by Rob Hyndman
  * [DATA + DESIGN](https://infoactive.co/data-design/titlepage01.html), A simple introduction to preparing and visualizing information. See especially
    - [CHAPTER 17 PERCEPTION DECEPTION](https://infoactive.co/data-design/ch17.html)
  * [Data visualization: A view of every Points of View column](http://blogs.nature.com/methagora/2013/07/data-visualization-points-of-view.html), a round-up of data visualization columns from *Nature*
  * [Sketchnotes by Jennifer Cham](http://jennycham.co.uk/2014/07/a-peek-into-the-world-of-data-visualisation-with-prof-munzner/) from a tutorial given by UBC colleague [Tamara Munzner](http://www.cs.ubc.ca/~tmm/)
    - Slides for the 5 hours minicourse Visualization Analysis & Design are [here](http://www.cs.ubc.ca/~tmm/talks.html#minicourse14)
  * A 1915 memo from the US Census Bureau on graphical presentation. It holds up very well!
    - <http://sappingattention.blogspot.ca/2014/08/data-visualization-rules-1915.html>
  * [Chart suggestions -- a thought starter](http://www.extremepresentation.com/uploads/documents/choosing_a_good_chart.pdf), a poster to help pick plot types. I don't approve of all of these but still worth a look.
  * [WTF Visualizations](http://wtfviz.net). Wow.
  * 19th-Century Infographic Shows American Mortality as a Cluster of Cute Little Charts from [slate.com](http://www.slate.com/blogs/the_vault/2014/09/15/vintage_infographics_mortality_charts_from_francis_amasa_walker_statistical.html)
  * [Data Is Ugly](http://www.reddit.com/r/dataisugly/) a subreddit "all about butchered statistics, misleading charts and unlabelled axes."
   