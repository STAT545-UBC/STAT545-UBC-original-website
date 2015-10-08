# Write your own R functions, part 2



### Where were we? Where are we going?

In [part 1](block011_write-your-own-function-01.html) we wrote our first R function to compute the difference between the max and min of a numeric vector. We checked the validity of the function's only argument and, informally, we verified that it worked pretty well.

In this part, we generalize this function, learn more technical details about R functions, and set default values for some arguments.

### Load the Gapminder data

As usual, load the Gapminder excerpt.


```r
library(gapminder)
```

### Restore our max minus min function

Let's keep our previous function around as a baseline.


```r
mmm <- function(x) {
  stopifnot(is.numeric(x))
  max(x) - min(x)
}
```

### Generalize our function to other quantiles

The max and the min are special cases of a __quantile__. Here are other special cases you may have heard of:

  * median = 0.5 quantile
  * 1st quartile = 0.25 quantile
  * 3rd quartile = 0.75 quantile
  
If you're familiar with [box plots](http://en.wikipedia.org/wiki/Box_plot), the rectangle typically runs from the 1st quartile to the 3rd quartile, with a line at the median.

If $q$ is the $p$-th quantile of a set of $n$ observations, what does that mean? Approximately $pn$ of the observations are less than $q$ and $(1 - p)n$ are greater than $q$. Yeah, you need to worry about rounding to an integer and less/greater than or equal to, but these details aren't critical here.

Let's generalize our function to take the difference between any two quantiles. We can still consider the max and min, if we like, but we're not limited to that.

### Get something that works, again

The eventual inputs to our new function will be the data `x` and two probabilities.

First, play around with the `quantile()` function. Convince yourself you know how to use it, for example, by cross-checking your results with other built-in functions.


```r
quantile(gapminder$lifeExp)
##      0%     25%     50%     75%    100% 
## 23.5990 48.1980 60.7125 70.8455 82.6030
quantile(gapminder$lifeExp, probs = 0.5)
##     50% 
## 60.7125
median(gapminder$lifeExp)
## [1] 60.7125
quantile(gapminder$lifeExp, probs = c(0.25, 0.75))
##     25%     75% 
## 48.1980 70.8455
boxplot(gapminder$lifeExp, plot = FALSE)$stats
##         [,1]
## [1,] 23.5990
## [2,] 48.1850
## [3,] 60.7125
## [4,] 70.8460
## [5,] 82.6030
```

Now write a code snippet that takes the difference between two quantiles.


```r
the_probs <- c(0.25, 0.75)
the_quantiles <- quantile(gapminder$lifeExp, probs = the_probs)
max(the_quantiles) - min(the_quantiles)
## [1] 22.6475
IQR(gapminder$lifeExp) # hey, we've reinvented IQR
## [1] 22.6475
```

### Turn the working interactive code into a function, again

I'll use `qdiff` as the base of our function's name. I copy the overall structure from our previous "max minus min" work but replace the guts of the function with the more general code we just developed.


```r
qdiff1 <- function(x, probs) {
  stopifnot(is.numeric(x))
  the_quantiles <- quantile(x = x, probs = probs)
  max(the_quantiles) - min(the_quantiles)
}
qdiff1(gapminder$lifeExp, probs = c(0.25, 0.75))
## [1] 22.6475
qdiff1(gapminder$lifeExp, probs = c(0, 1))
## [1] 59.004
mmm(gapminder$lifeExp)
## [1] 59.004
```

Again we do some informal tests against familiar results.

### Argument names: freedom and conventions

I want you to understand the importance of argument names.

I can name my arguments almost anything I like. Proof:


```r
qdiff2 <- function(zeus, hera) {
  stopifnot(is.numeric(zeus))
  the_quantiles <- quantile(x = zeus, probs = hera)
  return(max(the_quantiles) - min(the_quantiles))
}
qdiff2(zeus = gapminder$lifeExp, hera = 0:1)
## [1] 59.004
```

While I can name my arguments after Greek gods, it's usually a bad idea. Take all opportunities to make things more self-explanatory via meaningful names.

This is better:


```r
qdiff3 <- function(my_x, my_probs) {
 stopifnot(is.numeric(my_x))
  the_quantiles <- quantile(x = my_x, probs = my_probs)
  return(max(the_quantiles) - min(the_quantiles))
}
qdiff3(my_x = gapminder$lifeExp, my_probs = 0:1)
## [1] 59.004
```

If you are going to pass the arguments of your function as arguments of a built-in function, consider copying the argument names. Again, the reason is to reduce your cognitive load. This is what I've been doing all along and now you know why:


```r
qdiff1
## function(x, probs) {
##   stopifnot(is.numeric(x))
##   the_quantiles <- quantile(x = x, probs = probs)
##   max(the_quantiles) - min(the_quantiles)
## }
```

We took this detour so you could see there is no *structural* relationship between my arguments (`x` and `probs`) and those of `quantile()` (also `x` and `probs`). The similarity or equivalence of the names __accomplishes nothing__ as far as R is concerned; it is solely for the benefit of humans reading, writing, and using the code. Which is very important!

### What a function returns

By this point, I expect someone will have asked about the last line in my function's body. Look above for a reminder of the function's definition.

By default, a function returns the result of the last line of the body. I am just letting that happen with the line `max(the_quantiles) - min(the_quantiles)`. However, there is an explicit function for this: `return()`. I could just as easily make this the last line of my function's body:


```r
return(max(the_quantiles) - min(the_quantiles))
```

You absolutely must use `return()` if you want to return early based on some condition, i.e. before execution gets to the last line of the body. Otherwise, you can decide your own conventions about when you use `return()` and when you don't.

### Default values: freedom to NOT specify the arguments

What happens if we call our function but neglect to specify the probabilities?


```r
qdiff1(gapminder$lifeExp)
## Error in quantile.default(x = x, probs = probs): argument "probs" is missing, with no default
```

Oops! At the moment, this causes a fatal error. It can be nice to provide some reasonable default values for certain arguments. In our case, it would be crazy to specify a default value for the primary input `x`, but very kind to specify a default for `probs`.

We started by focusing on the max and the min, so I think those make reasonable defaults. Here's how to specify that in a function definition.


```r
qdiff4 <- function(x, probs = c(0, 1)) {
  stopifnot(is.numeric(x))
  the_quantiles <- quantile(x, probs)
  return(max(the_quantiles) - min(the_quantiles))
}
```

Again we check how the function works, in old examples and new, specifying the `probs` argument and not.


```r
qdiff4(gapminder$lifeExp)
## [1] 59.004
mmm(gapminder$lifeExp)
## [1] 59.004
qdiff4(gapminder$lifeExp, c(0.1, 0.9))
## [1] 33.5862
```

### Check the validity of arguments, again

EXERCISE FOR THE READER: upgrade our argument validity checks in light of the new argument `probs`


```r
## problems identified during class
## we're not checking that probs is numeric
## we're not checking that probs is length 2
## we're not checking that probs are in [0,1]
```

### Wrap-up and what's next?

Here's the function we've written so far:


```r
qdiff4
## function(x, probs = c(0, 1)) {
##   stopifnot(is.numeric(x))
##   the_quantiles <- quantile(x, probs)
##   return(max(the_quantiles) - min(the_quantiles))
## }
```

What we've accomplished:

  * we've generalized our first function to take a difference between arbitrary quantiles
  * we've specified default values for the probabilities that set the quantiles
  
Where to next? In [Part 3](block011_write-your-own-function-03.html), we tackle `NA`s, the special `...` argument, and formal unit testing.
