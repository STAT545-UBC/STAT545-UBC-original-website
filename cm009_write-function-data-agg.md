---
output:
  html_document:
    toc: true
---

### cm008 2014-10-01 Wednesday overview

  * HW04 will be due before class ~~Monday 2014-10-06~~ Wednesday 2014-10-08. Will be to write a function, documenting process from interactive pilot to formal tests. Polishing today's last example will be the easiest option, but you could do something else. Apply function to Gapminder using `plyr`. ~~Watch Twitter.~~ Now posted [here](http://stat545-ubc.github.io/hw04_write-function-use-plyr.html).
  * Writing your own functions! The exciting conclusion
    - [Write your own R functions, part 1](block011_write-your-own-function-01.html) *done Monday*
    - [Write your own R functions, part 2](block011_write-your-own-function-02.html) *done Monday*
    - [Write your own R functions, part 3](block011_write-your-own-function-03.html) *TODAY*
    - [Function-writing Practicum](block012_function-regress-lifeexp-on-year.html)  *TODAY*
  * Data aggregation
    - Big picture slides linked and embedded below
    - [Guided challenge](block012_function-regress-lifeexp-on-year.html): write function to regress life expectancy on year and return the estimated intercept and slope
    - [Use `plyr::ddplyr()`](block013_plyr-ddply.html) to apply this function to each country in Gapminder
  * What's left for 545? these topics are on the horizon
    - More data aggregation
    - Tidy data
    - File I/O
    - Be the boss of your factors
    - Back to figs: effective graphs, be the boss of colors
    
#### Slides and links

Slides available on [slideshare](https://www.slideshare.net/jenniferbryan5811/cm009-data-aggregation)

<iframe src="//www.slideshare.net/slideshow/embed_code/39778629" width="427" height="356" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="https://www.slideshare.net/jenniferbryan5811/cm009-data-aggregation" title="UBC STAT545 2014 Cm009 overview of data aggregation" target="_blank">UBC STAT545 2014 Cm009 overview of data aggregation</a> </strong> from <strong><a href="http://www.slideshare.net/jenniferbryan5811" target="_blank">Jennifer Bryan</a></strong> </div>

Links from the slides:

  * The split-apply-combine strategy for data analysis. Hadley Wickham. Journal of Statistical Software, vol. 40, no. 1, pp. 1–29, 2011. <http://www.jstatsoft.org/v40/i01/paper>
  * [plyr package](http://cran.rstudio.com/web/packages/plyr/)
  * [dplyr package](http://cran.rstudio.com/web/packages/dplyr/)