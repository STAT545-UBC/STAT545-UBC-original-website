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

Slides available on [speakerdeck](https://speakerdeck.com/jennybc/ubc-stat545-split-apply-combine-intro)

<script async class="speakerdeck-embed" data-id="13a2198511d54801993cad0d7051af25" data-ratio="1.33333333333333" src="//speakerdeck.com/assets/embed.js"></script> <div style="margin-bottom:5px"> <strong> <a href="https://speakerdeck.com/jennybc/ubc-stat545-split-apply-combine-intro" title="UBC STAT545 Split Apply Combine Intro" target="_blank">UBC STAT545 Split Apply Combine Intro</a> </strong> from <strong><a href="https://speakerdeck.com/jennybc" target="_blank">Jennifer Bryan</a></strong> </div>

Links from the slides:

  * The split-apply-combine strategy for data analysis. Hadley Wickham. Journal of Statistical Software, vol. 40, no. 1, pp. 1–29, 2011. <http://www.jstatsoft.org/v40/i01/paper>
  * [`dplyr` package](http://cran.rstudio.com/web/packages/dplyr/)
  * [`plyr` package](http://cran.rstudio.com/web/packages/plyr/)
  * The `broom` package by David Robinson
    - Development on [GitHub](https://github.com/dgrtwo/broom)
    - On [CRAN](https://cran.r-project.org/web/packages/broom/index.html)
    - [Vignette](https://cran.r-project.org/web/packages/broom/vignettes/broom_and_dplyr.html) on using `broom` with `dplyr`
  * [`purrr` package](https://cran.r-project.org/web/packages/purrr/index.html)
