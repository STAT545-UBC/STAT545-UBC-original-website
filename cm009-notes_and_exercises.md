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

2. To the `gapminder` dataset, add an `area` variable using the `areas` tibble, but only keeping obervations for which areas are available. 

3. Use a `_join` function to output the rows in `areas` corresponding to countries that _are not_ found in the `gapminder` dataset. 

4. Use a `_join` function to output the rows in `areas` corresponding to countries that _are_ found in the `gapminder` dataset. 

5. Construct a tibble that joins `gapminder` and `areas`, so that all rows found in each original tibble are also found in the final tibble. 


6. Subset the `gapminder` dataset to have countries that are only found in the `areas` data frame. 


7. Subset the `gapminder` dataset to have countries that are _not_ found in the `areas` data frame. 
