---
output:
  html_document:
    toc: true
    toc_depth: 4
---

### cm005 2014-09-17 Wednesday overview

  * Peer review has been set in motion
    - you should have been assigned 3 issues, one for each peer you are to review
    - all instructions are IN the issue
    - finish by midday Friday; should take less than an hour total
  * Making progress on data and R
    - More exploring the Gapminder data
    - Introductory words re `ggplot2`
  * R Markdown
  * What's next?
    - [HW 2](hw02_explore-gapminder-use-rmarkdown.html) due before class Monday 2014-09-22
    - Next week we begin serious data wrangling and aggregation with apply functions, `plyr` and `dplyr`
    
#### Slides and links

Slides available on [slideshare](http://www.slideshare.net/jenniferbryan5811/cm005-intro-ggplot2)

<iframe src="//www.slideshare.net/slideshow/embed_code/39204474" width="427" height="356" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="https://www.slideshare.net/jenniferbryan5811/cm005-intro-ggplot2" title="UBC STAT545 2014 Cm005 R graphics landscape, use ggplot2" target="_blank">UBC STAT545 2014 Cm005 R graphics landscape, use ggplot2</a> </strong> from <strong><a href="http://www.slideshare.net/jenniferbryan5811" target="_blank">Jennifer Bryan</a></strong> </div>

Links and notes related to the slides

  * A `ggplot2` [tutorial](https://github.com/jennybc/ggplot2-tutorial) I taught May 2013 contains lots of working code, in source form and compiled to something pretty
    - [ggplot2 online docs](http://docs.ggplot2.org/current/)
    - [ggplot2 "homepage"](http://ggplot2.org)
    - [ggplot2 development on github](https://github.com/hadley/ggplot2) 
    - [The R Graphics Cookbook](http://shop.oreilly.com/product/0636920023135.do), an excellent book by Winston Chang.
    - The [graphs section](http://www.cookbook-r.com/Graphs/) of Winston Chang's website Cookbook for R. The book listed above contains much more material, but the website is good too.
    - [ggplot2: Elegant Graphics for Data Analysis](http://www.amazon.com/dp/0387981403/ref=cm_sw_su_dp?tag=ggplot2-20) by Hadley Wickham. [Book's companion website](http://ggplot2.org/book/) offers one R script per chapter, providing the code used in the book.
    - [A quick introduction to ggplot2](http://inundata.org/2013/04/10/a-quick-introduction-to-ggplot2/) by Karthik Ram. Slides and code from a 2 hour talk/hands on presentation for ggplot2 beginners.
  * Nine simple ways to make it easier to (re)use your data by Ethan P White, Elita Baldridge, Zachary T. Brym, Kenneth J. Locey, Daniel J. McGlinn, Sarah R. Supp. Ideas in Ecology and Evolution 6(2): 1–10, 2013. doi:10.4033/iee.2013.6b.6.f <http://library.queensu.ca/ojs/index.php/IEE/article/view/4608>. Section 4 "Use Standard Data Formats" is especially good reading. Keeping data in the right format is __critical__ to the process of making figures.
  * [Tidy data by Hadley Wickham](http://www.jstatsoft.org/v59/i10). Journal of Statistical Software 59(10) 2014.  
  * Packages to keep data in tip-top shape for making graphs and more
    - [`tidyr`](https://github.com/hadley/tidyr)
    - [Lesson I contributed](bit002_tidying-lotr-data.html) to [Data Carpentry](http://software-carpentry.org/blog/2014/05/our-first-data-carpentry-workshop.html) on tidying data with `tidyr`
    - `reshape2` package: on [GitHub](https://github.com/hadley/reshape)
    - `dplyr` package: on [GitHub](https://github.com/hadley/dplyr) | an [introduction vignette](http://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html)

#### For R novices

You should have finished working through these by now:

  * [R basics, workspace and working directory, RStudio projects](block002_hello-r-workspace-wd-project.html)
  * [R objects (beyond data.frames) and indexing](block004_basic-r-objects.html)
  * [Basic care and feeding of data in R](block006_care-feeding-data.html)

#### Did anyone work with `swirl`?

I want to check in with people who looked at [swirl](http://swirlstats.com).

Please chime in this [issue](https://github.com/STAT545-UBC/Discussion/issues/10) I've opened in our [Discussion repo](https://github.com/STAT545-UBC/Discussion).

#### Short intro to `ggplot2`

This week's goal is just to introduce `ggplot2`, so your HW02 about exploring data can contain some figures: "Start the way you mean to finish ... which is with lots of figures!"

All of this will be eventually ported over into STAT545 materials but will go ahead and link now.

  * A `ggplot2` [tutorial](https://github.com/jennybc/ggplot2-tutorial) I taught May 2013

#### R Markdown

This week's goal is for you to report on your data exploration by authoring an R Markdown document.

Here is a write-up of my hands-on demo of R Markdown:

  * [Test your ability to author an R Markdown report](block007_first-use-rmarkdown.html)
  
Here is a recap on the combined usage of RStudio (and a Project), a Git repo linked to a remote repo on GitHub, and an R Markdown report:

  * [Git(Hub) usage](block008_git-usage.html)

Here is material from a talk and short workshop I gave at SFU in November 2013

  * <https://github.com/jennybc/2013-11_sfu>
  