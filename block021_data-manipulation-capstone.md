# Exercises to test and solidy your data manipulation skills

*NOTE: Not completed or used. It is a start on a set of data manipulation challenges, but I lost too much time tracking down a puzzle in the `spread()` example. It turned out to be a bug in `dplyr`. See [this issue](https://github.com/hadley/tidyr/issues/32) or [the one I opened and closed](https://github.com/hadley/tidyr/issues/42).*




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
library(reshape2)
library(tidyr)
gdat <- read.delim("gapminderDataFiveYear.tsv")
```


### Aggregate or summarize

From this input:


```r
(hdat <- gdat %>%
   filter(country %in% c('France', 'Belgium', 'Nigeria', 'Japan'),
          year > 1996) %>%
   select(country, year, continent, lifeExp) %>%
   filter( (country == 'Japan') |
             (country == 'Belgium' & year == 2002) |
             (country == 'France' & year < 2005) |
             (country == 'Nigeria' & year > 2002)))
##   country year continent lifeExp
## 1 Belgium 2002    Europe  78.320
## 2  France 1997    Europe  78.640
## 3  France 2002    Europe  79.590
## 4   Japan 1997      Asia  80.690
## 5   Japan 2002      Asia  82.000
## 6   Japan 2007      Asia  82.603
## 7 Nigeria 2007    Africa  46.859
```

Make this output:




country   continent    nrows   max_year   min_lifeExp
--------  ----------  ------  ---------  ------------
Belgium   Europe           1       2002        78.320
France    Europe           2       2002        78.640
Japan     Asia             3       2007        80.690
Nigeria   Africa           1       2007        46.859

### Cross-tabulate with holes

From `hdat` (code to produce given above)

```r
hdat
##   country year continent lifeExp
## 1 Belgium 2002    Europe  78.320
## 2  France 1997    Europe  78.640
## 3  France 2002    Europe  79.590
## 4   Japan 1997      Asia  80.690
## 5   Japan 2002      Asia  82.000
## 6   Japan 2007      Asia  82.603
## 7 Nigeria 2007    Africa  46.859
```

Make this output (it should be a data.frame):




continent    1997   2002   2007
----------  -----  -----  -----
Africa         NA     NA      1
Asia            1      1      1
Europe          1      2     NA
