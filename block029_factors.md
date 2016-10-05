# Be the boss of your factors



*Under development*

### Factors: where they fit in

We've spent alot of time working with big, beautiful data frame, like the Gapminder data. But we also need to manage the individual variables housed within.

Factors are the variable type that useRs love to hate. It is how we store truly categorical information in R. The values a factor can take on are called the **levels**. For example, the levels of the factor `continent` in Gapminder are are "Africa", "Americas", etc. and this is what's usually presented to your eyeballs by R. In general, the levels are friendly human-readable character strings, like "male/female" and "control/treated". But *never ever ever* forget that, under the hood, R is really storing integer codes 1, 2, 3, etc.

This [Janus](http://en.wikipedia.org/wiki/Janus)-like nature of factors means they are rich with booby traps for the unsuspecting but they are a necessary evil. I recommend you learn how to be the boss of your factors. The pros far outweigh the cons. Specifically in modelling and figure-making, factors are anticipated and accommodated by the functions and packages you will want to exploit.

The worst kind of factor is the stealth factor. The variable that you think of as character, but that is actually a factor (numeric!!). This is one of the classic gotchas in R. Check your variable types explicitly when things seem weird. Where do stealth factors come from? Base R has a burning desire to turn character information into factor. The most common place this happens is at data import via `read.table()` and friends. To shut this down, use `stringsAsFactors = FALSE` or -- even better -- use the tidyverse functions `read_csv()`, `read_tsv()`, etc.

Good articles about how the factor fiasco came to be:

  * [stringsAsFactors: An unauthorized biography](http://simplystatistics.org/2015/07/24/stringsasfactors-an-unauthorized-biography/) by Roger Peng
  * [stringsAsFactors = <sigh>](http://notstatschat.tumblr.com/post/124987394001/stringsasfactors-sigh) by Thomas Lumley

### The forcats package

This is a reboot of the [STAT 545 factor material from 2015 and before](block014_factors.html), in light of the very recent birth of the [forcats](https://blog.rstudio.org/2016/08/31/forcats-0-1-0/) package. 

forcats is a non-core package in the tidyverse. It is installed via `install.packages("tidyverse")`, but not loaded via `library(tidyverse)`. Load it yourself as needed via `library(forcats)`. Main functions start with `fct_`. There really is no coherent family of base functions that forcats replaces -- that's why it's such a welcome addition.

Currently this lesson will be mostly code vs prose. See the previous lesson for more discussion during the transition.

### Load tidyverse, forcats, gapminder


```r
library(tidyverse)
#> Loading tidyverse: ggplot2
#> Loading tidyverse: tibble
#> Loading tidyverse: tidyr
#> Loading tidyverse: readr
#> Loading tidyverse: purrr
#> Loading tidyverse: dplyr
#> Conflicts with tidy packages ----------------------------------------------
#> filter(): dplyr, stats
#> lag():    dplyr, stats
library(forcats)
library(gapminder)
```

### Factor inspection

Get to know your factor before you start touching it! It's polite.


```r
gapminder
#> # A tibble: 1,704 × 6
#>        country continent  year lifeExp      pop gdpPercap
#>         <fctr>    <fctr> <int>   <dbl>    <int>     <dbl>
#> 1  Afghanistan      Asia  1952  28.801  8425333  779.4453
#> 2  Afghanistan      Asia  1957  30.332  9240934  820.8530
#> 3  Afghanistan      Asia  1962  31.997 10267083  853.1007
#> 4  Afghanistan      Asia  1967  34.020 11537966  836.1971
#> 5  Afghanistan      Asia  1972  36.088 13079460  739.9811
#> 6  Afghanistan      Asia  1977  38.438 14880372  786.1134
#> 7  Afghanistan      Asia  1982  39.854 12881816  978.0114
#> 8  Afghanistan      Asia  1987  40.822 13867957  852.3959
#> 9  Afghanistan      Asia  1992  41.674 16317921  649.3414
#> 10 Afghanistan      Asia  1997  41.763 22227415  635.3414
#> # ... with 1,694 more rows
str(gapminder)
#> Classes 'tbl_df', 'tbl' and 'data.frame':	1704 obs. of  6 variables:
#>  $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
#>  $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
#>  $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
#>  $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
#>  $ pop      : int  8425333 9240934 10267083 11537966 13079460 14880372 12881816 13867957 16317921 22227415 ...
#>  $ gdpPercap: num  779 821 853 836 740 ...
str(gapminder$continent)
#>  Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
levels(gapminder$continent)
#> [1] "Africa"   "Americas" "Asia"     "Europe"   "Oceania"
nlevels(gapminder$continent)
#> [1] 5
class(gapminder$continent)
#> [1] "factor"
summary(gapminder$continent)
#>   Africa Americas     Asia   Europe  Oceania 
#>      624      300      396      360       24
```

Get a result similar to `dplyr::count()` but on a naked factor.


```r
gapminder %>% 
  count(continent)
#> # A tibble: 5 × 2
#>   continent     n
#>      <fctr> <int>
#> 1    Africa   624
#> 2  Americas   300
#> 3      Asia   396
#> 4    Europe   360
#> 5   Oceania    24
fct_count(gapminder$continent)
#> # A tibble: 5 × 2
#>          f     n
#>     <fctr> <int>
#> 1   Africa   624
#> 2 Americas   300
#> 3     Asia   396
#> 4   Europe   360
#> 5  Oceania    24
```


### Dropping unused levels

`droplevels()` for operating on factors living in a data frame (or on a single factor).  
`fct_drop()` for operating on a factor directly.


```r
h_countries <- c("Egypt", "Haiti", "Romania", "Thailand", "Venezuela")
h_gap <- gapminder %>%
  filter(country %in% h_countries)
h_gap %>% str()
#> Classes 'tbl_df', 'tbl' and 'data.frame':	60 obs. of  6 variables:
#>  $ country  : Factor w/ 142 levels "Afghanistan",..: 39 39 39 39 39 39 39 39 39 39 ...
#>  $ continent: Factor w/ 5 levels "Africa","Americas",..: 1 1 1 1 1 1 1 1 1 1 ...
#>  $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
#>  $ lifeExp  : num  41.9 44.4 47 49.3 51.1 ...
#>  $ pop      : int  22223309 25009741 28173309 31681188 34807417 38783863 45681811 52799062 59402198 66134291 ...
#>  $ gdpPercap: num  1419 1459 1693 1815 2024 ...
nlevels(h_gap$country)
#> [1] 142

## in data frame context
h_gap_dropped <- h_gap %>% 
  droplevels()
nlevels(h_gap_dropped$country)
#> [1] 5

## in a factor vector context
h_gap$country %>% levels()
#>   [1] "Afghanistan"              "Albania"                 
#>   [3] "Algeria"                  "Angola"                  
#>   [5] "Argentina"                "Australia"               
#>   [7] "Austria"                  "Bahrain"                 
#>   [9] "Bangladesh"               "Belgium"                 
#>  [11] "Benin"                    "Bolivia"                 
#>  [13] "Bosnia and Herzegovina"   "Botswana"                
#>  [15] "Brazil"                   "Bulgaria"                
#>  [17] "Burkina Faso"             "Burundi"                 
#>  [19] "Cambodia"                 "Cameroon"                
#>  [21] "Canada"                   "Central African Republic"
#>  [23] "Chad"                     "Chile"                   
#>  [25] "China"                    "Colombia"                
#>  [27] "Comoros"                  "Congo, Dem. Rep."        
#>  [29] "Congo, Rep."              "Costa Rica"              
#>  [31] "Cote d'Ivoire"            "Croatia"                 
#>  [33] "Cuba"                     "Czech Republic"          
#>  [35] "Denmark"                  "Djibouti"                
#>  [37] "Dominican Republic"       "Ecuador"                 
#>  [39] "Egypt"                    "El Salvador"             
#>  [41] "Equatorial Guinea"        "Eritrea"                 
#>  [43] "Ethiopia"                 "Finland"                 
#>  [45] "France"                   "Gabon"                   
#>  [47] "Gambia"                   "Germany"                 
#>  [49] "Ghana"                    "Greece"                  
#>  [51] "Guatemala"                "Guinea"                  
#>  [53] "Guinea-Bissau"            "Haiti"                   
#>  [55] "Honduras"                 "Hong Kong, China"        
#>  [57] "Hungary"                  "Iceland"                 
#>  [59] "India"                    "Indonesia"               
#>  [61] "Iran"                     "Iraq"                    
#>  [63] "Ireland"                  "Israel"                  
#>  [65] "Italy"                    "Jamaica"                 
#>  [67] "Japan"                    "Jordan"                  
#>  [69] "Kenya"                    "Korea, Dem. Rep."        
#>  [71] "Korea, Rep."              "Kuwait"                  
#>  [73] "Lebanon"                  "Lesotho"                 
#>  [75] "Liberia"                  "Libya"                   
#>  [77] "Madagascar"               "Malawi"                  
#>  [79] "Malaysia"                 "Mali"                    
#>  [81] "Mauritania"               "Mauritius"               
#>  [83] "Mexico"                   "Mongolia"                
#>  [85] "Montenegro"               "Morocco"                 
#>  [87] "Mozambique"               "Myanmar"                 
#>  [89] "Namibia"                  "Nepal"                   
#>  [91] "Netherlands"              "New Zealand"             
#>  [93] "Nicaragua"                "Niger"                   
#>  [95] "Nigeria"                  "Norway"                  
#>  [97] "Oman"                     "Pakistan"                
#>  [99] "Panama"                   "Paraguay"                
#> [101] "Peru"                     "Philippines"             
#> [103] "Poland"                   "Portugal"                
#> [105] "Puerto Rico"              "Reunion"                 
#> [107] "Romania"                  "Rwanda"                  
#> [109] "Sao Tome and Principe"    "Saudi Arabia"            
#> [111] "Senegal"                  "Serbia"                  
#> [113] "Sierra Leone"             "Singapore"               
#> [115] "Slovak Republic"          "Slovenia"                
#> [117] "Somalia"                  "South Africa"            
#> [119] "Spain"                    "Sri Lanka"               
#> [121] "Sudan"                    "Swaziland"               
#> [123] "Sweden"                   "Switzerland"             
#> [125] "Syria"                    "Taiwan"                  
#> [127] "Tanzania"                 "Thailand"                
#> [129] "Togo"                     "Trinidad and Tobago"     
#> [131] "Tunisia"                  "Turkey"                  
#> [133] "Uganda"                   "United Kingdom"          
#> [135] "United States"            "Uruguay"                 
#> [137] "Venezuela"                "Vietnam"                 
#> [139] "West Bank and Gaza"       "Yemen, Rep."             
#> [141] "Zambia"                   "Zimbabwe"
h_gap$country %>% fct_drop() %>% levels()
#> [1] "Egypt"     "Haiti"     "Romania"   "Thailand"  "Venezuela"
```

### Change order of the levels, principled

Default order is alphabetical. Which is practically random, when you think about it! It is preferable to order the levels according to some principle:

  * Frequency. Make the most common level the first and so on.
  * Another variable. Order factor levels according to a summary statistic for another variable. Example: order Gapminder countries by life expectancy.

Order by frequency, forwards and backwards. Motivated by the downstream need to make tables and figures, esp. frequency barplots.


```r
## order by frequency
gapminder$continent %>%
  levels()
#> [1] "Africa"   "Americas" "Asia"     "Europe"   "Oceania"
gapminder$continent %>% 
  fct_infreq() %>%
  levels() %>% head()
#> [1] "Africa"   "Asia"     "Europe"   "Americas" "Oceania"
## backwards!
gapminder$continent %>% 
  fct_infreq() %>%
  fct_rev() %>% 
  levels() %>% head()
#> [1] "Oceania"  "Americas" "Europe"   "Asia"     "Africa"
```

Order by another variable, forwards and backwards. This other variable is usually quantitative and you will order the factor accoding to a grouped summary. The factor is the grouping variable and the default summarizing function is `median()`.


```r
fct_reorder(gapminder$country, gapminder$lifeExp) %>% 
  levels() %>% head()
#> [1] "Sierra Leone"  "Guinea-Bissau" "Afghanistan"   "Angola"       
#> [5] "Somalia"       "Guinea"
## order accoring to minimum life exp instead of median
fct_reorder(gapminder$country, gapminder$lifeExp, min) %>% 
  levels() %>% head()
#> [1] "Rwanda"       "Afghanistan"  "Gambia"       "Angola"      
#> [5] "Sierra Leone" "Cambodia"
## backwards!
fct_reorder(gapminder$country, gapminder$lifeExp, .desc = TRUE) %>% 
  levels() %>% head()
#> [1] "Iceland"     "Japan"       "Sweden"      "Switzerland" "Netherlands"
#> [6] "Norway"
```

Example of why we reorder factor levels: often makes plots much better! When a factor is mapped to x or y, it should almost always be reordered by the quantitative variable you are mapping to the other one.




```r
gap_asia_2007 <- gapminder %>% filter(year == 2007, continent == "Asia")
ggplot(gap_asia_2007, aes(x = lifeExp, y = country)) + geom_point()
ggplot(gap_asia_2007, aes(x = lifeExp, y = fct_reorder(country, lifeExp))) +
  geom_point()
```

<img src="block029_factors_files/figure-html/alpha-order-silly-1.png" width="49%" /><img src="block029_factors_files/figure-html/alpha-order-silly-2.png" width="49%" />


Use `fct_reorder2()` when you have a line chart of a quantitative x against another quantitative y and your factor provides the color. This way the legend appears in some order as the data!


```r
h_countries <- c("Egypt", "Haiti", "Romania", "Thailand", "Venezuela")
h_gap <- gapminder %>%
  filter(country %in% h_countries) %>% 
  droplevels()
ggplot(h_gap, aes(x = year, y = lifeExp, color = country)) +
  geom_line()
ggplot(h_gap, aes(x = year, y = lifeExp,
                  color = fct_reorder2(country, year, lifeExp))) +
  geom_line() +
  labs(color = "country")
```

<img src="block029_factors_files/figure-html/legends-made-for-humans-1.png" width="49%" /><img src="block029_factors_files/figure-html/legends-made-for-humans-2.png" width="49%" />

### Change order of the levels, "because I said so"

Sometimes you just want to hoist one or more level to the front. Because I said so. This resembles what we do when we move variables to the front with `dplyr::select(var1, var, everything())`.


```r
h_gap$country %>% levels()
#> [1] "Egypt"     "Haiti"     "Romania"   "Thailand"  "Venezuela"
h_gap$country %>% fct_relevel("Romania", "Haiti") %>% levels()
#> [1] "Romania"   "Haiti"     "Egypt"     "Thailand"  "Venezuela"
```

### Recode the levels


```r
i_gap <- gapminder %>% 
  filter(country %in% c("United States", "Sweden", "Australia")) %>% 
  droplevels()
i_gap$country %>% levels()
#> [1] "Australia"     "Sweden"        "United States"
## oops United States is giving me trouble
i_gap$country %>%
  fct_recode("USA" = "United States", "Oz" = "Australia")%>% levels()
#> [1] "Oz"     "Sweden" "USA"

fct_count(gapminder$continent)
#> # A tibble: 5 × 2
#>          f     n
#>     <fctr> <int>
#> 1   Africa   624
#> 2 Americas   300
#> 3     Asia   396
#> 4   Europe   360
#> 5  Oceania    24
```

