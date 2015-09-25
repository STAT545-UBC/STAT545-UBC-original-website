---
output:
  html_document:
    toc: true
    toc_depth: 4
---

### cm006 2015-09-24 Thursday overview

  * Peer review closes today for [Homework 01](hw01_edit-README.html). TAs will then come through through your repos and comment. We send marks via email using the email you provided in the class survey.
  * [Homework 02](hw02_explore-gapminder-use-rmarkdown.html) due sometime next Tuesday 2015-09-29.
    - Explore the `gapminder` data.frame
    - Make some figures with `ggplot2`.
    - Practice writing R Markdown.
  * Today we'll handle the last mechanical bit: R Markdown.
    - By end of class, you'll have seen all the course mechanics: Git(Hub), (R) Markdown, HW submission, peer review, Discussion, etc.
    - Questions? Comments?
  * [Test drive R Markdown](block007_first-use-rmarkdown.html)
  * In class exercise:
    - Make a plot of [our enrollment data](https://gist.github.com/jennybc/924fe242a31e0239762f#file-2015_stat545_enrollment-csv) in and R Markdown document.
    - How to bring that into R?
        ``` r
        read.csv("https://gist.githubusercontent.com/jennybc/924fe242a31e0239762f/raw/ea615f4a811a6e9e8a1fe95020a4407785181a21/2015_STAT545_enrollment.csv")
        ```
  * What's next?
    - Next week we'll move on to `dplyr` and understanding the different flavours of R objects

#### Slides and links

*there were no slides*

#### Q and A from 2014

R Markdown is not the only way to get a pretty report. You can also get one from an __R script__.

  * When editing a `.R` file, RStudio offers a button for this is the spiral bound notebook icon, near where the "Knit HTML" button appears for `.Rmd`. Click and you get "Compile Notebook".
  * Under the hood, you are using a function called `spin()` from the `knitr` package.
  * Jenny's [`ggplot2` tutorial](https://github.com/jennybc/ggplot2-tutorial) includes alot of Markdown that was made this way, i.e. from `.R` not `.Rmd`
    - look at source vs. rendered to get a feel for this
    - download the source and render yourself!
  * Basically, the special comment prefix `#'` becomes very important
  * R Markdown: prose is queen, R code is sequestered in special chunks
  * R script: code is queen, prose is sequestered in special comments
  * You can get virtually same HTML report either way. Which to choose? Depends whether the report is primary goal (choose `.Rmd`) or a by-product (choose `.R`).
  
I passed around hard copies of these 5 books (note: some links to eBooks and repositories are tuned to UBC users):

  * [R Graphics Cookbook](http://shop.oreilly.com/product/0636920023135.do) by Winston Chang, O'Reilly (2013). The [graphs section](http://www.cookbook-r.com/Graphs/) of his [Cookbook for R website](http://www.cookbook-r.com) will give you a good sense of the book, which contains more material in greater detail.

  * ggplot2: Elegant Graphics for Data Analysis [available via SpringerLink](http://ezproxy.library.ubc.ca/login?url=http://link.springer.com.ezproxy.library.ubc.ca/book/10.1007/978-0-387-98141-3/page/1) by Hadley Wickham, Springer (2009) | [online docs (nice!)](http://docs.ggplot2.org/current/) | [author's website for the book](http://ggplot2.org/book/), including all the code | [author's landing page for the package](http://ggplot2.org)

  * R Graphics, 2nd edition [available via StatsNetbase](http://ezproxy.library.ubc.ca/login?url=http://www.crcnetbase.com.ezproxy.library.ubc.ca/ISBN/978-1-4398-3176-2) by Paul Murrell, Chapman & Hall/CRC Press (2011) | [author's webpage for the book](http://www.stat.auckland.ac.nz/~paul/RG2e/) | [GoogleBooks search](http://books.google.ca/books?id=uacCQgAACAAJ&source=gbs_book_other_versions) | [companion R package, RGraphics, on CRAN](http://cran.r-project.org/web/packages/RGraphics/index.html)

  * [Dynamic documents with R and `knitr`](http://www.amazon.com/Dynamic-Documents-knitr-Chapman-Series/dp/1482203537) by Yihui Xie, part of the CRC Press / Chapman & Hall R Series (2013). ISBN: 9781482203530. *No online access (yet?).*

  * [Reproducible Research with R & RStudio](http://www.amazon.com/Reproducible-Research-RStudio-Chapman-Series/dp/1466572841) by Christopher Gandrud, part of the CRC Press / Chapman & Hall R Series (2013). ISBN: 978-1466572843. [Book website](http://christophergandrud.github.io/RepResR-RStudio/) | [Examples and code](https://github.com/christophergandrud/Rep-Res-Examples) | [Book source](https://github.com/christophergandrud/Rep-Res-Book). *No online access (yet?).*
  
