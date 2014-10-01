# Write your own R functions, part 3



### Where were we? Where are we going?

In [part 2]() we generalized our first R function so it could take the difference between any two quantiles of a numeric vector. We also set default values for the underlying probabilities, so that, by default, we compute the max minus the min.

In this part, we tackle `NA`s, the special argument `...` and formal testing.

### Load the Gapminder data

As usual, load the Gapminder excerpt.


```r
gDat <- read.delim("gapminderDataFiveYear.txt")
str(gDat)
## 'data.frame':	1704 obs. of  6 variables:
##  $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
##  $ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
##  $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
##  $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
##  $ gdpPercap: num  779 821 853 836 740 ...
## or do this if the file isn't lying around already
## gd_url <- "http://tiny.cc/gapminder"
## gDat <- read.delim(gd_url)
```

### Load assertthat and our qdiff function

We'll keep using `assert_that()` to check that `x` is numeric and we'll want our previous function around as a baseline.


```r
library(assertthat)
qdiff4 <- function(x, probs = c(0, 1)) {
  assert_that(is.numeric(x))
  the_quantiles <- quantile(x, probs)
  return(max(the_quantiles) - min(the_quantiles))
}
```

### Be proactive about `NA`s

I am being gentle by letting you practice with the Gapminder data. In real life, you will be plagued by missing data. If you are lucky, it will be properly indicated by the special value `NA`. Many built-in R functions have an `na.rm =` argument through which you can specify how you want to handle `NA`s. Typically the default value is `na.rm = FALSE` and typical default behavior is to either let `NA`s propagate or to raise an error. Let's see how `quantile()` handles `NA`s:


```r
z <- gDat$lifeExp
z[3] <- NA
quantile(gDat$lifeExp)
##      0%     25%     50%     75%    100% 
## 23.5990 48.1980 60.7125 70.8455 82.6030
quantile(z)
## Error: missing values and NaN's not allowed if 'na.rm' is FALSE
quantile(z, na.rm = TRUE)
##     0%    25%    50%    75%   100% 
## 23.599 48.228 60.765 70.846 82.603
```

So `quantile()` simply will not operate in the presence of `NA`s unless `na.rm = TRUE`. How shall we modify our function?

If we wanted to hardwire `na.rm = TRUE`, we could. Focus on our call to `quantile()` inside our function definition.


```r
qdiff5 <- function(x, probs = c(0, 1)) {
  assert_that(is.numeric(x))
  the_quantiles <- quantile(x, probs, na.rm = TRUE)
  return(max(the_quantiles) - min(the_quantiles))
}
qdiff5(gDat$lifeExp)
## [1] 59.004
qdiff5(z)
## [1] 59.004
```

This works but it is dangerous to invert the default behavior of a well-known built-in function and to provide the user with no way to override this.

We could add an `na.rm =` argument to our own function. We might even enforce our preferred default -- but at least we're giving the user a way to control the behavior around `NA`s.


```r
qdiff6 <- function(x, probs = c(0, 1), na.rm = TRUE) {
  assert_that(is.numeric(x))
  the_quantiles <- quantile(x, probs, na.rm = na.rm)
  return(max(the_quantiles) - min(the_quantiles))
}
qdiff6(gDat$lifeExp)
## [1] 59.004
qdiff6(z)
## [1] 59.004
qdiff6(z, na.rm = FALSE)
## Error: missing values and NaN's not allowed if 'na.rm' is FALSE
```

### The useful but mysterious `...` argument

You probably could have lived a long and happy life without knowing there are at least 9 different algorithms for computing quantiles. [Go read about the `type` argument](http://www.rdocumentation.org/packages/stats/functions/quantile) of `quantile()`. TLDR: If a quantile is not unambiguously equal to an observed data point, you must somehow average two data points. You can weight this average different ways, depending on the rest of the data, and `type =` controls this.

Let's say we want to give the user of our function the ability to specify how the quantiles are computed, but we want to accomplish with as little fuss as possible. In fact, we don't even want to clutter our function's interface with this! This calls for the very special `...` argument.


```r
qdiff7 <- function(x, probs = c(0, 1), na.rm = TRUE, ...) {
  the_quantiles <- quantile(x = x, probs = probs, na.rm = na.rm, ...)
  return(max(the_quantiles) - min(the_quantiles))
}
```

The practical significance of the `type =` argument is vanishly small, so I have to cook up a specific example so you can even detect a difference due to different settings.


```r
set.seed(1234)
z <- rnorm(10)
quantile(z, type=1)
##         0%        25%        50%        75%       100% 
## -2.3456977 -0.8900378 -0.5644520  0.4291247  1.0844412
quantile(z, type=4)
##        0%       25%       50%       75%      100% 
## -2.345698 -1.048552 -0.564452  0.353277  1.084441
all.equal(quantile(z, type=1), quantile(z, type=4))
## [1] "Mean relative difference: 0.1776594"
```

Now we can call our function, requesting that quantiles be computed in different ways.


```r
qdiff7(z, probs = c(0.25, 0.75), type = 1)
## [1] 1.319163
qdiff7(z, probs = c(0.25, 0.75), type = 4)
## [1] 1.401829
```

Don't fret about the subtle difference in result. The point here is to marvel at the fact that we have passed `type = 1` through to `quantile()` *even though it was not a formal argument of our own function*.

The special argument `...` is very useful when you want the ability to pass arbitrary arguments down to another function, but without making them formal arguments to your function. This leaves you with a less cluttered function definition and give you great flexibility in the future to specify these arguments or not, depending on context.

You will also encounter the `...` argument in many built-in functions -- read up [on `c()`](http://www.rdocumentation.org/packages/base/functions/c) or [`list()`](http://www.rdocumentation.org/packages/base/functions/list) -- and now you have a better sense of what it does.

### Use `testthat` for formal unit tests

Until now, we've relied on informal tests of our evolving function. If you are going to use a function alot, especially if it is part of a package, it is wise to use formal unit tests.

The [`testthat` package](https://github.com/hadley/testthat) provides excellent facilities for this, with a distinct emphasis on automated unit testing of entire packages. However, we can take it out for a test drive even with our one measly function.

We will construct a test with `test_that()` and, within it, we put one or more *expectations* that check actual against expected results. You simply harden your informal, interactive tests into formal unit tests. Here are some examples of tests and indicative expectations.


```r
library(testthat)
test_that('invalid args are detected', {
  expect_error(qdiff7("eggplants are purple"))
  expect_error(qdiff7(iris))
  })
test_that('NA handling works', {
  expect_error(qdiff7(c(1:5, NA), na.rm = FALSE))
  expect_equal(qdiff7(c(1:5, NA)), 4)
})
```

No news is good news! Let's see what test failure would look like. Let's revert to a version of our function that does no `NA` handling, then test for proper `NA` handling. We can watch it fail.


```r
qdiff_no_NA <- function(x, probs = c(0, 1)) {
  the_quantiles <- quantile(x = x, probs = probs)
  return(max(the_quantiles) - min(the_quantiles))
}
test_that('NA handling works', {
  expect_that(qdiff_no_NA(c(1:5, NA)), equals(4))
})
## Error: Test failed: 'NA handling works'
## Not expected: missing values and NaN's not allowed if 'na.rm' is FALSE
## 1: withCallingHandlers(eval(code, new_test_environment), error = capture_calls)
## 2: eval(code, new_test_environment)
## 3: eval(expr, envir, enclos)
## 4: expect_that(qdiff_no_NA(c(1:5, NA)), equals(4)) at <text>:6
## 5: condition(object)
## 6: compare(expected, actual, ...)
## 7: compare.default(expected, actual, ...)
## 8: all.equal(x, y, ...)
## 9: all.equal.numeric(x, y, ...)
## 10: attr.all.equal(target, current, tolerance = tolerance, scale = scale, ...)
## 11: mode(current)
## 12: qdiff_no_NA(c(1:5, NA))
## 13: quantile(x = x, probs = probs) at <text>:2
## 14: quantile.default(x = x, probs = probs)
## 15: stop("missing values and NaN's not allowed if 'na.rm' is FALSE").
```

Similar to the advice to use `assertthat` in data analytical scripts, I recommend you use `testthat` to monitor the behavior of functions you (or others) will use often. If your tests cover the function's important behavior, then you can edit the internals freely. You'll rest easy in the knowledge that, if you broke anything important, the tests will fail and alert you to the problem.

<!--
### Return to `dplyr` SKIP THIS IN FAVOR OF PLYR


```r
library(dplyr)
## 
## Attaching package: 'dplyr'
## 
## The following object is masked from 'package:stats':
## 
##     filter
## 
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
gtbl <- gDat %>% tbl_df
by_continent <- gtbl %>%
  group_by(continent)
by_continent %>% do(data.frame(max(.$lifeExp)))
## Source: local data frame [5 x 2]
## Groups: continent
## 
##   continent max...lifeExp.
## 1    Africa         76.442
## 2  Americas         80.653
## 3      Asia         82.603
## 4    Europe         81.757
## 5   Oceania         81.235
```

### other content

match.arg()

defaulting to NULL then checking is.null() and take it from there

-->

### Resources

Packages

  * [`assertthat` package](https://github.com/hadley/assertthat)
  * [`ensurer` package](https://github.com/smbache/ensurer)
  * [`testthat` package](https://github.com/hadley/testthat)

Hadley Wickham's forthcoming book [Advanced R]((http://adv-r.had.co.nz)

  * Section on [defensive programming](http://adv-r.had.co.nz/Exceptions-Debugging.html#defensive-programming)
  
Hadley Wickham's forthcoming book [R packages](http://r-pkgs.had.co.nz)

  * [Testing chapter](http://r-pkgs.had.co.nz/tests.html)

  
