# cm009 Notes and Exercises: Table Joins
2017-10-03  


```r
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(gapminder))
```


After going through the `dplyr` [vignette](https://cran.r-project.org/web/packages/dplyr/vignettes/two-table.html) on "two-table verbs", we'll work on the following exercises.


Consider the following areas of countries, in hectares:


```r
(areas <- data.frame(country=c("Canada", "United States", "India", "Vatican City"),
                     area=c(998.5*10^6, 983.4*10^6, 328.7*10^6, 44)) %>% 
     as.tbl)
```

```
## # A tibble: 4 × 2
##         country      area
##          <fctr>     <dbl>
## 1        Canada 998500000
## 2 United States 983400000
## 3         India 328700000
## 4  Vatican City        44
```


1. To the `gapminder` dataset, add an `area` variable using the `areas` tibble. Be sure to preserve all the rows of the original `gapminder` dataset.


```r
left_join(gapminder, areas)
```

```
## Joining, by = "country"
```

```
## Warning in left_join_impl(x, y, by$x, by$y, suffix$x, suffix$y): joining
## factors with different levels, coercing to character vector
```

```
## # A tibble: 1,704 × 7
##        country continent  year lifeExp      pop gdpPercap  area
##          <chr>    <fctr> <int>   <dbl>    <int>     <dbl> <dbl>
## 1  Afghanistan      Asia  1952  28.801  8425333  779.4453    NA
## 2  Afghanistan      Asia  1957  30.332  9240934  820.8530    NA
## 3  Afghanistan      Asia  1962  31.997 10267083  853.1007    NA
## 4  Afghanistan      Asia  1967  34.020 11537966  836.1971    NA
## 5  Afghanistan      Asia  1972  36.088 13079460  739.9811    NA
## 6  Afghanistan      Asia  1977  38.438 14880372  786.1134    NA
## 7  Afghanistan      Asia  1982  39.854 12881816  978.0114    NA
## 8  Afghanistan      Asia  1987  40.822 13867957  852.3959    NA
## 9  Afghanistan      Asia  1992  41.674 16317921  649.3414    NA
## 10 Afghanistan      Asia  1997  41.763 22227415  635.3414    NA
## # ... with 1,694 more rows
```


2. To the `gapminder` dataset, add an `area` variable using the `areas` tibble, but only keeping obervations for which areas are available. 


```r
inner_join(gapminder, areas)
```

```
## Joining, by = "country"
```

```
## Warning in inner_join_impl(x, y, by$x, by$y, suffix$x, suffix$y): joining
## factors with different levels, coercing to character vector
```

```
## # A tibble: 36 × 7
##    country continent  year lifeExp      pop gdpPercap      area
##      <chr>    <fctr> <int>   <dbl>    <int>     <dbl>     <dbl>
## 1   Canada  Americas  1952   68.75 14785584  11367.16 998500000
## 2   Canada  Americas  1957   69.96 17010154  12489.95 998500000
## 3   Canada  Americas  1962   71.30 18985849  13462.49 998500000
## 4   Canada  Americas  1967   72.13 20819767  16076.59 998500000
## 5   Canada  Americas  1972   72.88 22284500  18970.57 998500000
## 6   Canada  Americas  1977   74.21 23796400  22090.88 998500000
## 7   Canada  Americas  1982   75.76 25201900  22898.79 998500000
## 8   Canada  Americas  1987   76.86 26549700  26626.52 998500000
## 9   Canada  Americas  1992   77.95 28523502  26342.88 998500000
## 10  Canada  Americas  1997   78.61 30305843  28954.93 998500000
## # ... with 26 more rows
```

3. Use a `_join` function to output the rows in `areas` corresponding to countries that _are not_ found in the `gapminder` dataset. 


```r
anti_join(areas, gapminder)
```

```
## Joining, by = "country"
```

```
## # A tibble: 1 × 2
##        country  area
##         <fctr> <dbl>
## 1 Vatican City    44
```


4. Use a `_join` function to output the rows in `areas` corresponding to countries that _are_ found in the `gapminder` dataset. 


```r
semi_join(areas, gapminder, by="country")
```

```
## # A tibble: 3 × 2
##         country      area
##          <fctr>     <dbl>
## 1        Canada 998500000
## 2         India 328700000
## 3 United States 983400000
```

5. Construct a tibble that joins `gapminder` and `areas`, so that all rows found in each original tibble are also found in the final tibble. 


```r
full_join(areas, gapminder)
```

```
## Joining, by = "country"
```

```
## Warning in full_join_impl(x, y, by$x, by$y, suffix$x, suffix$y): joining
## factors with different levels, coercing to character vector
```

```
## # A tibble: 1,705 × 7
##    country      area continent  year lifeExp      pop gdpPercap
##      <chr>     <dbl>    <fctr> <int>   <dbl>    <int>     <dbl>
## 1   Canada 998500000  Americas  1952   68.75 14785584  11367.16
## 2   Canada 998500000  Americas  1957   69.96 17010154  12489.95
## 3   Canada 998500000  Americas  1962   71.30 18985849  13462.49
## 4   Canada 998500000  Americas  1967   72.13 20819767  16076.59
## 5   Canada 998500000  Americas  1972   72.88 22284500  18970.57
## 6   Canada 998500000  Americas  1977   74.21 23796400  22090.88
## 7   Canada 998500000  Americas  1982   75.76 25201900  22898.79
## 8   Canada 998500000  Americas  1987   76.86 26549700  26626.52
## 9   Canada 998500000  Americas  1992   77.95 28523502  26342.88
## 10  Canada 998500000  Americas  1997   78.61 30305843  28954.93
## # ... with 1,695 more rows
```

```r
full_join(gapminder, areas)
```

```
## Joining, by = "country"
```

```
## Warning in full_join_impl(x, y, by$x, by$y, suffix$x, suffix$y): joining
## factors with different levels, coercing to character vector
```

```
## # A tibble: 1,705 × 7
##        country continent  year lifeExp      pop gdpPercap  area
##          <chr>    <fctr> <int>   <dbl>    <int>     <dbl> <dbl>
## 1  Afghanistan      Asia  1952  28.801  8425333  779.4453    NA
## 2  Afghanistan      Asia  1957  30.332  9240934  820.8530    NA
## 3  Afghanistan      Asia  1962  31.997 10267083  853.1007    NA
## 4  Afghanistan      Asia  1967  34.020 11537966  836.1971    NA
## 5  Afghanistan      Asia  1972  36.088 13079460  739.9811    NA
## 6  Afghanistan      Asia  1977  38.438 14880372  786.1134    NA
## 7  Afghanistan      Asia  1982  39.854 12881816  978.0114    NA
## 8  Afghanistan      Asia  1987  40.822 13867957  852.3959    NA
## 9  Afghanistan      Asia  1992  41.674 16317921  649.3414    NA
## 10 Afghanistan      Asia  1997  41.763 22227415  635.3414    NA
## # ... with 1,695 more rows
```

Here are the rows containing the Vatican City:


```r
full_join(areas, gapminder) %>% 
    filter(country=="Vatican City")
```

```
## Joining, by = "country"
```

```
## Warning in full_join_impl(x, y, by$x, by$y, suffix$x, suffix$y): joining
## factors with different levels, coercing to character vector
```

```
## # A tibble: 1 × 7
##        country  area continent  year lifeExp   pop gdpPercap
##          <chr> <dbl>    <fctr> <int>   <dbl> <int>     <dbl>
## 1 Vatican City    44        NA    NA      NA    NA        NA
```


6. Subset the `gapminder` dataset to have countries that are only found in the `areas` data frame. 


```r
semi_join(gapminder, areas)
```

```
## Joining, by = "country"
```

```
## # A tibble: 36 × 6
##    country continent  year lifeExp      pop gdpPercap
##     <fctr>    <fctr> <int>   <dbl>    <int>     <dbl>
## 1   Canada  Americas  1952   68.75 14785584  11367.16
## 2   Canada  Americas  1957   69.96 17010154  12489.95
## 3   Canada  Americas  1962   71.30 18985849  13462.49
## 4   Canada  Americas  1967   72.13 20819767  16076.59
## 5   Canada  Americas  1972   72.88 22284500  18970.57
## 6   Canada  Americas  1977   74.21 23796400  22090.88
## 7   Canada  Americas  1982   75.76 25201900  22898.79
## 8   Canada  Americas  1987   76.86 26549700  26626.52
## 9   Canada  Americas  1992   77.95 28523502  26342.88
## 10  Canada  Americas  1997   78.61 30305843  28954.93
## # ... with 26 more rows
```

7. Subset the `gapminder` dataset to have countries that are _not_ found in the `areas` data frame. 


```r
anti_join(gapminder, areas)
```

```
## Joining, by = "country"
```

```
## # A tibble: 1,668 × 6
##    country continent  year lifeExp     pop gdpPercap
##     <fctr>    <fctr> <int>   <dbl>   <int>     <dbl>
## 1   Zambia    Africa  1952  42.038 2672000  1147.389
## 2   Zambia    Africa  1957  44.077 3016000  1311.957
## 3   Zambia    Africa  1962  46.023 3421000  1452.726
## 4   Zambia    Africa  1967  47.768 3900000  1777.077
## 5   Zambia    Africa  1972  50.107 4506497  1773.498
## 6   Zambia    Africa  1977  51.386 5216550  1588.688
## 7   Zambia    Africa  1982  51.821 6100407  1408.679
## 8   Zambia    Africa  1987  50.821 7272406  1213.315
## 9   Zambia    Africa  1992  46.100 8381163  1210.885
## 10  Zambia    Africa  1997  40.238 9417789  1071.354
## # ... with 1,658 more rows
```

Let's check.... Canada should not be in there:


```r
anti_join(gapminder, areas) %>% 
    filter(country=="Canada")
```

```
## Joining, by = "country"
```

```
## # A tibble: 0 × 6
## # ... with 6 variables: country <fctr>, continent <fctr>, year <int>,
## #   lifeExp <dbl>, pop <int>, gdpPercap <dbl>
```

