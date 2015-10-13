---
output:
  html_document:
    toc: true
---

### cm011 2015-10-13 Tuesday overview

  * [HW04](hw04_write-function-split-apply-combine.html) will be due ?? sometime Friday 2015-10-16 ??. Write a function, documenting process from interactive pilot to formal tests. Apply function to Gapminder using `dplyr` or, maybe, `plyr`. Invitation to experiment with `broom` and then do more split-apply-combine or visualization on the results.
  * Writing your own functions. You should have finished this on your own.
    - [Write your own R functions, part 1](block011_write-your-own-function-01.html)
    - [Write your own R functions, part 2](block011_write-your-own-function-02.html)
    - [Write your own R functions, part 3](block011_write-your-own-function-03.html)
  * Data aggregation
    - Big picture slides linked and embedded below
    - [Guided challenge](block012_function-regress-lifeexp-on-year.html): write function to regress life expectancy on year and return the estimated intercept and slope
    - [Use `dplyr::do()`](block023_dplyr-do.html) to apply this function to each country in Gapminder; use `broom` to do same in a slick way to linear models in general
    - [Use `plyr::ddply()`](block013_plyr-ddply.html) to apply this function to each country in Gapminder *2014 material I'm keeping around and linked, just in case*
  * What's left for 545?
    - Tidy data and reshaping
    - Be the boss of your factors
    - Back to figs: practical matters (e.g. color and file management), guest lecture from Tamara Munzner
    
#### Slides and links

Slides available on [slideshare](https://www.slideshare.net/jenniferbryan5811/cm009-data-aggregation)

<iframe src="//www.slideshare.net/slideshow/embed_code/39778629" width="427" height="356" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="https://www.slideshare.net/jenniferbryan5811/cm009-data-aggregation" title="UBC STAT545 2014 Cm009 overview of data aggregation" target="_blank">UBC STAT545 2014 Cm009 overview of data aggregation</a> </strong> from <strong><a href="http://www.slideshare.net/jenniferbryan5811" target="_blank">Jennifer Bryan</a></strong> </div>

Links from the slides:

  * The split-apply-combine strategy for data analysis. Hadley Wickham. Journal of Statistical Software, vol. 40, no. 1, pp. 1–29, 2011. <http://www.jstatsoft.org/v40/i01/paper>
  * [dplyr package](http://cran.rstudio.com/web/packages/dplyr/)
  * [plyr package](http://cran.rstudio.com/web/packages/plyr/)
  * The `broom` package by David Robinson
    - Development on [GitHub](https://github.com/dgrtwo/broom)
    - On [CRAN](https://cran.r-project.org/web/packages/broom/vignettes)
    - [Vignette](https://cran.r-project.org/web/packages/broom/vignettes/broom_and_dplyr.html) on using `broom` with `dplyr`
