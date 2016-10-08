# Character data



*Under development*

### Character vectors: where they fit in

We've spent alot of time working with big, beautiful data frames. That are clean and wholesome, like the Gapminder data.

But real life will be much nastier. You will bring data into R from the outside world and discover there are problems. You might think: how hard can it be to deal with character data? And the answer is: it can be very hard!

  * [Stack Exchange outage](http://stackstatus.net/post/147710624694/outage-postmortem-july-20-2016)
  * [Regexes to validate/match email addresses](http://emailregex.com)
  * [Fixing an Atom bug](http://davidvgalbraith.com/how-i-fixed-atom/)

Here we discuss common remedial tasks for cleaning and transforming character data, also known as "strings". A data frame or tibble will consist of one or more *atomic vectors* of a certain class. This lesson deals with things you can do with vectors of class `character`.

### Resources

I start with this because we cannot possibly do this topic justice in a short amount of time. Our goal is to make you aware of broad classes of problems and their respective solutions. Once you have a character problem in real life, these resources will be extremely helpful as you delve deeper.

Manipulating character vectors

  * [stringr package](https://cran.r-project.org/web/packages/stringr/index.html)
    - A non-core package in the tidyverse. It is installed via `install.packages("tidyverse")`, but not loaded via `library(tidyverse)`. Load it as needed via `library(stringr)`.
    - Main functions start with `str_`. Auto-complete is your friend.
    - Replacements for base functions re: string manipulation and regular expressions (see below).
    - Main advantage over base functions: greater consistency about inputs and outputs. Outputs are more ready for your next analytical task.
    - Wraps [stringi](https://cran.r-project.org/web/packages/stringi/index.html), which is a great place to look if stringr isn't powerful enough.
  * [tidyr package](https://cran.r-project.org/web/packages/tidyr/index.html)
    - Especially useful for functions that split 1 character vector into many and *vice versa*: `separate()`, `unite()`, `extract()`.
  * Base functions: `nchar()`, `strsplit()`, `substr()`, `paste()`, `paste0()`.

Regular expressions: a God-awful and powerful language for expressing patterns to match in text or for search-and-replace. Frequently described as "write only", because regular expressions are easier to write than to read/understand. And they are not particularly easy to write.

  * The [Strings chapter](http://r4ds.had.co.nz/strings.html) of [R for Data Science](http://r4ds.had.co.nz) is excellent.
  * STAT 545 lessons on regular expressions:
    -  [2014 Intro to regular expressions](block022_regular-expression.html) by TA Gloria Li.
    - [2015 Regular expressions and character data in R](block027_regular-expressions.html) by TA Kieran Samuk.
    - Excellent content in both. Why am I redeveloping, then? To be more consistent re: using stringr and to use examples whose availability is easier for me to support long-term.
  * RStudio Cheat Sheet on [Regular Expressions in R](https://www.rstudio.com/wp-content/uploads/2016/09/RegExCheatsheet.pdf)
  * Regex testers
    - [regex101.com](https://regex101.com)
    - [regexr.com](http://regexr.com)
  * [rex R package](https://github.com/kevinushey/rex): make regular expression from human readable expressions

![](img/regexbytrialanderror-big-smaller.png)

Encoding

  * [Strings subsection of data import chapter](http://r4ds.had.co.nz/data-import.html#readr-strings) in R for Data Science
  * Screeds on the Minimum Everyone Needs to Know about encoding
    - [The Absolute Minimum Every Software Developer Absolutely, Positively Must Know About Unicode and Character Sets (No Excuses!)](http://www.joelonsoftware.com/articles/Unicode.html)
    - [What Every Programmer Absolutely, Positively Needs To Know About Encodings And Character Sets To Work With Text](http://kunststube.net/encoding/)
  * [Guide to fixing encoding problems in Ruby](http://www.justinweiss.com/articles/3-steps-to-fix-encoding-problems-in-ruby/) *parking here temporariliy ... looks useful but, obviously, it's about Ruby not R*
    
### Load stringr and the core tidyverse


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
library(stringr)
```

### Basic string manipulation with stringr and tidyr

Basic string manipulation tasks:

  * Study a single character vector
    - How long are the strings?
    - Presence/absence of a literal string
  * Operate on a single character vector
    - Keep/discard elements that contain a literal string
    - Split into two or more character vectors using a fixed delimiter    
    - Snip out pieces of the strings based on character position
    - Collapse into a single string
  * Operate on two or more character vectors
    - Glue them together element-wise to get a new character vector.

*`fruit`, `words`, and `sentences` are character vectors that ship with `stringr` for practicing.*

#### Detect or filter on a target string

Determine presence/absence of a literal string with `str_detect()`. Spoiler: this will also work for regular expressions (see below).

Which fruits actually use the word "fruit"?


```r
str_detect(fruit, "fruit")
#>  [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
#> [12]  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
#> [23] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
#> [34] FALSE  TRUE FALSE FALSE FALSE  TRUE FALSE FALSE  TRUE FALSE FALSE
#> [45] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
#> [56] FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
#> [67] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
#> [78] FALSE  TRUE FALSE
```

What's the easiest way to get the actual fruits that match? Use `str_subset()` to keep only the matching elements. Note we are storing this new vector `my_fruit` to use in later examples!


```r
(my_fruit <- str_subset(fruit, "fruit"))
#> [1] "breadfruit"   "dragonfruit"  "grapefruit"   "jackfruit"   
#> [5] "kiwi fruit"   "passionfruit" "star fruit"   "ugli fruit"
```

#### String splitting by pattern

Use `stringr::str_split()` to split strings on a delimiter. Some of our fruits are compound words, like "grapefruit", but some have two words, like "ugli fruit". Here we split on a single space `" "`, but show use of a regular expression later. 


```r
str_split(my_fruit, " ")
#> [[1]]
#> [1] "breadfruit"
#> 
#> [[2]]
#> [1] "dragonfruit"
#> 
#> [[3]]
#> [1] "grapefruit"
#> 
#> [[4]]
#> [1] "jackfruit"
#> 
#> [[5]]
#> [1] "kiwi"  "fruit"
#> 
#> [[6]]
#> [1] "passionfruit"
#> 
#> [[7]]
#> [1] "star"  "fruit"
#> 
#> [[8]]
#> [1] "ugli"  "fruit"
```

It's bummer that we get a *list* back. But it must be so! In full generality, split strings must return list, because who knows how many pieces there will be?

If you are willing to commit to the number of items, you can use `str_split_fixed()` and get a character matrix. You're welcome!


```r
str_split_fixed(my_fruit, " ", n = 2)
#>      [,1]           [,2]   
#> [1,] "breadfruit"   ""     
#> [2,] "dragonfruit"  ""     
#> [3,] "grapefruit"   ""     
#> [4,] "jackfruit"    ""     
#> [5,] "kiwi"         "fruit"
#> [6,] "passionfruit" ""     
#> [7,] "star"         "fruit"
#> [8,] "ugli"         "fruit"
```

If the to-be-split variable lives in a data frame, `tidyr::separate()` will split it into 2 or more variables.


```r
my_fruit_df <- tibble(my_fruit)
my_fruit_df %>% 
  separate(my_fruit, into = c("pre", "post"), sep = " ")
#> Warning: Too few values at 5 locations: 1, 2, 3, 4, 6
#> # A tibble: 8 × 2
#>            pre  post
#> *        <chr> <chr>
#> 1   breadfruit  <NA>
#> 2  dragonfruit  <NA>
#> 3   grapefruit  <NA>
#> 4    jackfruit  <NA>
#> 5         kiwi fruit
#> 6 passionfruit  <NA>
#> 7         star fruit
#> 8         ugli fruit
```

#### Substring extraction (and replacement) by position

Count characters in your strings with `str_length()`. Note this is different from the length of the character vector itself.


```r
length(my_fruit)
#> [1] 8
str_length(my_fruit)
#> [1] 10 11 10  9 10 12 10 10
```

You can snip out substrings based on character position with `str_sub()`.


```r
head(fruit) %>% 
  str_sub(1, 3)
#> [1] "app" "apr" "avo" "ban" "bel" "bil"
```

The `start` and `end` arguments are vectorised.


```r
tibble(fruit) %>% 
  head() %>% 
  mutate(snip = str_sub(fruit, 1:6, 3:8))
#> # A tibble: 6 × 2
#>         fruit  snip
#>         <chr> <chr>
#> 1       apple   app
#> 2     apricot   pri
#> 3     avocado   oca
#> 4      banana   ana
#> 5 bell pepper    pe
#> 6    bilberry   rry
```

Finally, `str_sub()` also works for assignment, i.e. on the left hand side of `<-`.


```r
x <- head(fruit, 3)
str_sub(x, 1, 3) <- "AAA"
x
#> [1] "AAAle"   "AAAicot" "AAAcado"
```

#### Collapse a vector

You can collapse a character of length `n > 1` to a single string with `str_c()`, which also has other uses (see next section).


```r
head(fruit) %>% 
  str_c(collapse = ", ")
#> [1] "apple, apricot, avocado, banana, bell pepper, bilberry"
```

#### Create a character vector by catenating multiple vectors

If you have two or more character vectors of the same length, you can glue them together element-wise, to get a new vector of that length. Here are some ... awful smoothie flavors?


```r
str_c(fruit[1:4], fruit[5:8], sep = " & ")
#> [1] "apple & bell pepper"   "apricot & bilberry"    "avocado & blackberry" 
#> [4] "banana & blackcurrant"
```

Element-wise catenation can be combined with collapsing.


```r
str_c(fruit[1:4], fruit[5:8], sep = " & ", collapse = ", ")
#> [1] "apple & bell pepper, apricot & bilberry, avocado & blackberry, banana & blackcurrant"
```

If the to-be-combined vectors are variables in a data frame, you can use `tidyr::unite()` to make a single new variable from them


```r
fruit_df <- tibble(fruit1 = fruit[1:4], fruit2 = fruit[5:8])
fruit_df %>% 
  unite("flavor_combo", fruit1, fruit2, sep = " & ")
#> # A tibble: 4 × 1
#>            flavor_combo
#> *                 <chr>
#> 1   apple & bell pepper
#> 2    apricot & bilberry
#> 3  avocado & blackberry
#> 4 banana & blackcurrant
```

#### Substring replacement

You can replace a pattern with `str_replace()`. Here we use an explicit string-to-replace, but later we revisit with a regular expression.


```r
str_replace(my_fruit, "fruit", "THINGY")
#> [1] "breadTHINGY"   "dragonTHINGY"  "grapeTHINGY"   "jackTHINGY"   
#> [5] "kiwi THINGY"   "passionTHINGY" "star THINGY"   "ugli THINGY"
```

A special case that comes up alot is replacing `NA`, for which there is `str_replace_na()`.


```r
melons <- str_subset(fruit, "melon")
melons[2] <- NA
melons
#> [1] "canary melon" NA             "watermelon"
str_replace_na(melons, "UNKNOWN MELON")
#> [1] "canary melon"  "UNKNOWN MELON" "watermelon"
```

If the `NA`-afflicted variable lives in a data frame, you can use `tidyr::replace_na()`.


```r
tibble(melons) %>% 
  replace_na(replace = list(melons = "UNKNOWN MELON"))
#> # A tibble: 3 × 1
#>          melons
#>           <chr>
#> 1  canary melon
#> 2 UNKNOWN MELON
#> 3    watermelon
```

### Regular expression with stringr

[2014 STAT 545 lesson an regular expressions](block022_regular-expression.html) has good coverage of characters with special meaning in regex and escape sequences.


```r
library(gapminder)
```

We've been doing this already: looking for exact strings.


```r
countries <- levels(gapminder$country)
str_subset(countries, "land")
#> [1] "Finland"     "Iceland"     "Ireland"     "Netherlands" "New Zealand"
#> [6] "Poland"      "Swaziland"   "Switzerland" "Thailand"
```

The period `.` is a placeholder that matches anything but newline.


```r
str_subset(countries, "a.b")
#> [1] "Cambodia"   "Gambia"     "Mozambique" "Zambia"
```

Anchors indicate the beginning `^` and end `$` of the string.


```r
str_subset(countries, "ia")
#>  [1] "Albania"                "Algeria"               
#>  [3] "Australia"              "Austria"               
#>  [5] "Bolivia"                "Bosnia and Herzegovina"
#>  [7] "Bulgaria"               "Cambodia"              
#>  [9] "Colombia"               "Croatia"               
#> [11] "Equatorial Guinea"      "Ethiopia"              
#> [13] "Gambia"                 "India"                 
#> [15] "Indonesia"              "Liberia"               
#> [17] "Malaysia"               "Mauritania"            
#> [19] "Mongolia"               "Namibia"               
#> [21] "Nigeria"                "Romania"               
#> [23] "Saudi Arabia"           "Serbia"                
#> [25] "Slovenia"               "Somalia"               
#> [27] "Syria"                  "Tanzania"              
#> [29] "Tunisia"                "Zambia"
str_subset(countries, "ia$")
#>  [1] "Albania"      "Algeria"      "Australia"    "Austria"     
#>  [5] "Bolivia"      "Bulgaria"     "Cambodia"     "Colombia"    
#>  [9] "Croatia"      "Ethiopia"     "Gambia"       "India"       
#> [13] "Indonesia"    "Liberia"      "Malaysia"     "Mauritania"  
#> [17] "Mongolia"     "Namibia"      "Nigeria"      "Romania"     
#> [21] "Saudi Arabia" "Serbia"       "Slovenia"     "Somalia"     
#> [25] "Syria"        "Tanzania"     "Tunisia"      "Zambia"
str_subset(fruit, "^a")
#> [1] "apple"   "apricot" "avocado"
str_subset(fruit, "a")
#>  [1] "apple"             "apricot"           "avocado"          
#>  [4] "banana"            "blackberry"        "blackcurrant"     
#>  [7] "blood orange"      "breadfruit"        "canary melon"     
#> [10] "cantaloupe"        "cherimoya"         "cranberry"        
#> [13] "currant"           "damson"            "date"             
#> [16] "dragonfruit"       "durian"            "eggplant"         
#> [19] "feijoa"            "grape"             "grapefruit"       
#> [22] "guava"             "jackfruit"         "jambul"           
#> [25] "kumquat"           "loquat"            "mandarine"        
#> [28] "mango"             "nectarine"         "orange"           
#> [31] "pamelo"            "papaya"            "passionfruit"     
#> [34] "peach"             "pear"              "physalis"         
#> [37] "pineapple"         "pomegranate"       "purple mangosteen"
#> [40] "raisin"            "rambutan"          "raspberry"        
#> [43] "redcurrant"        "salal berry"       "satsuma"          
#> [46] "star fruit"        "strawberry"        "tamarillo"        
#> [49] "tangerine"         "watermelon"
```

You can also indicate word boundary with `\b` and not a word boundary with `\B`. The backslash has to be "escaped" by adding another backslash.


```r
str_subset(fruit, "berry")
#>  [1] "bilberry"    "blackberry"  "blueberry"   "boysenberry" "cloudberry" 
#>  [6] "cranberry"   "elderberry"  "goji berry"  "gooseberry"  "huckleberry"
#> [11] "mulberry"    "raspberry"   "salal berry" "strawberry"
str_subset(fruit, "\\bberry")
#> [1] "goji berry"  "salal berry"
str_subset(fruit, "\\Bberry")
#>  [1] "bilberry"    "blackberry"  "blueberry"   "boysenberry" "cloudberry" 
#>  [6] "cranberry"   "elderberry"  "gooseberry"  "huckleberry" "mulberry"   
#> [11] "raspberry"   "strawberry"
```

Characters can be specified via classes. You make them "by hand" or use some pre-existing ones.  The [2014 STAT 545 regex lesson](block022_regular-expression.html) has detailed coverage of other classes.


```r
## making the class by hand
str_subset(countries, "[nls]ia$")
#>  [1] "Albania"    "Australia"  "Indonesia"  "Malaysia"   "Mauritania"
#>  [6] "Mongolia"   "Romania"    "Slovenia"   "Somalia"    "Tanzania"  
#> [11] "Tunisia"
## negation
str_subset(countries, "[^nls]ia$")
#>  [1] "Algeria"      "Austria"      "Bolivia"      "Bulgaria"    
#>  [5] "Cambodia"     "Colombia"     "Croatia"      "Ethiopia"    
#>  [9] "Gambia"       "India"        "Liberia"      "Namibia"     
#> [13] "Nigeria"      "Saudi Arabia" "Serbia"       "Syria"       
#> [17] "Zambia"
## remember this?
str_split_fixed(fruit, " ", 2)
#>       [,1]           [,2]        
#>  [1,] "apple"        ""          
#>  [2,] "apricot"      ""          
#>  [3,] "avocado"      ""          
#>  [4,] "banana"       ""          
#>  [5,] "bell"         "pepper"    
#>  [6,] "bilberry"     ""          
#>  [7,] "blackberry"   ""          
#>  [8,] "blackcurrant" ""          
#>  [9,] "blood"        "orange"    
#> [10,] "blueberry"    ""          
#> [11,] "boysenberry"  ""          
#> [12,] "breadfruit"   ""          
#> [13,] "canary"       "melon"     
#> [14,] "cantaloupe"   ""          
#> [15,] "cherimoya"    ""          
#> [16,] "cherry"       ""          
#> [17,] "chili"        "pepper"    
#> [18,] "clementine"   ""          
#> [19,] "cloudberry"   ""          
#> [20,] "coconut"      ""          
#> [21,] "cranberry"    ""          
#> [22,] "cucumber"     ""          
#> [23,] "currant"      ""          
#> [24,] "damson"       ""          
#> [25,] "date"         ""          
#> [26,] "dragonfruit"  ""          
#> [27,] "durian"       ""          
#> [28,] "eggplant"     ""          
#> [29,] "elderberry"   ""          
#> [30,] "feijoa"       ""          
#> [31,] "fig"          ""          
#> [32,] "goji"         "berry"     
#> [33,] "gooseberry"   ""          
#> [34,] "grape"        ""          
#> [35,] "grapefruit"   ""          
#> [36,] "guava"        ""          
#> [37,] "honeydew"     ""          
#> [38,] "huckleberry"  ""          
#> [39,] "jackfruit"    ""          
#> [40,] "jambul"       ""          
#> [41,] "jujube"       ""          
#> [42,] "kiwi"         "fruit"     
#> [43,] "kumquat"      ""          
#> [44,] "lemon"        ""          
#> [45,] "lime"         ""          
#> [46,] "loquat"       ""          
#> [47,] "lychee"       ""          
#> [48,] "mandarine"    ""          
#> [49,] "mango"        ""          
#> [50,] "mulberry"     ""          
#> [51,] "nectarine"    ""          
#> [52,] "nut"          ""          
#> [53,] "olive"        ""          
#> [54,] "orange"       ""          
#> [55,] "pamelo"       ""          
#> [56,] "papaya"       ""          
#> [57,] "passionfruit" ""          
#> [58,] "peach"        ""          
#> [59,] "pear"         ""          
#> [60,] "persimmon"    ""          
#> [61,] "physalis"     ""          
#> [62,] "pineapple"    ""          
#> [63,] "plum"         ""          
#> [64,] "pomegranate"  ""          
#> [65,] "pomelo"       ""          
#> [66,] "purple"       "mangosteen"
#> [67,] "quince"       ""          
#> [68,] "raisin"       ""          
#> [69,] "rambutan"     ""          
#> [70,] "raspberry"    ""          
#> [71,] "redcurrant"   ""          
#> [72,] "rock"         "melon"     
#> [73,] "salal"        "berry"     
#> [74,] "satsuma"      ""          
#> [75,] "star"         "fruit"     
#> [76,] "strawberry"   ""          
#> [77,] "tamarillo"    ""          
#> [78,] "tangerine"    ""          
#> [79,] "ugli"         "fruit"     
#> [80,] "watermelon"   ""
## another way to say 'a character of whitespace' (space, tab, newline)
str_split_fixed(fruit, "\\s", 2)
#>       [,1]           [,2]        
#>  [1,] "apple"        ""          
#>  [2,] "apricot"      ""          
#>  [3,] "avocado"      ""          
#>  [4,] "banana"       ""          
#>  [5,] "bell"         "pepper"    
#>  [6,] "bilberry"     ""          
#>  [7,] "blackberry"   ""          
#>  [8,] "blackcurrant" ""          
#>  [9,] "blood"        "orange"    
#> [10,] "blueberry"    ""          
#> [11,] "boysenberry"  ""          
#> [12,] "breadfruit"   ""          
#> [13,] "canary"       "melon"     
#> [14,] "cantaloupe"   ""          
#> [15,] "cherimoya"    ""          
#> [16,] "cherry"       ""          
#> [17,] "chili"        "pepper"    
#> [18,] "clementine"   ""          
#> [19,] "cloudberry"   ""          
#> [20,] "coconut"      ""          
#> [21,] "cranberry"    ""          
#> [22,] "cucumber"     ""          
#> [23,] "currant"      ""          
#> [24,] "damson"       ""          
#> [25,] "date"         ""          
#> [26,] "dragonfruit"  ""          
#> [27,] "durian"       ""          
#> [28,] "eggplant"     ""          
#> [29,] "elderberry"   ""          
#> [30,] "feijoa"       ""          
#> [31,] "fig"          ""          
#> [32,] "goji"         "berry"     
#> [33,] "gooseberry"   ""          
#> [34,] "grape"        ""          
#> [35,] "grapefruit"   ""          
#> [36,] "guava"        ""          
#> [37,] "honeydew"     ""          
#> [38,] "huckleberry"  ""          
#> [39,] "jackfruit"    ""          
#> [40,] "jambul"       ""          
#> [41,] "jujube"       ""          
#> [42,] "kiwi"         "fruit"     
#> [43,] "kumquat"      ""          
#> [44,] "lemon"        ""          
#> [45,] "lime"         ""          
#> [46,] "loquat"       ""          
#> [47,] "lychee"       ""          
#> [48,] "mandarine"    ""          
#> [49,] "mango"        ""          
#> [50,] "mulberry"     ""          
#> [51,] "nectarine"    ""          
#> [52,] "nut"          ""          
#> [53,] "olive"        ""          
#> [54,] "orange"       ""          
#> [55,] "pamelo"       ""          
#> [56,] "papaya"       ""          
#> [57,] "passionfruit" ""          
#> [58,] "peach"        ""          
#> [59,] "pear"         ""          
#> [60,] "persimmon"    ""          
#> [61,] "physalis"     ""          
#> [62,] "pineapple"    ""          
#> [63,] "plum"         ""          
#> [64,] "pomegranate"  ""          
#> [65,] "pomelo"       ""          
#> [66,] "purple"       "mangosteen"
#> [67,] "quince"       ""          
#> [68,] "raisin"       ""          
#> [69,] "rambutan"     ""          
#> [70,] "raspberry"    ""          
#> [71,] "redcurrant"   ""          
#> [72,] "rock"         "melon"     
#> [73,] "salal"        "berry"     
#> [74,] "satsuma"      ""          
#> [75,] "star"         "fruit"     
#> [76,] "strawberry"   ""          
#> [77,] "tamarillo"    ""          
#> [78,] "tangerine"    ""          
#> [79,] "ugli"         "fruit"     
#> [80,] "watermelon"   ""
## punctuation
str_subset(countries, ",")
#> [1] "Congo, Dem. Rep." "Congo, Rep."      "Hong Kong, China"
#> [4] "Korea, Dem. Rep." "Korea, Rep."      "Yemen, Rep."
str_subset(countries, "[[:punct:]]")
#> [1] "Congo, Dem. Rep." "Congo, Rep."      "Cote d'Ivoire"   
#> [4] "Guinea-Bissau"    "Hong Kong, China" "Korea, Dem. Rep."
#> [7] "Korea, Rep."      "Yemen, Rep."
```

You can modify with a quantifier:

  * `*` means "0 or more"
  * `+` means "1 or more"
  * `?` means "exactly 0 or 1"
  * `{n}` means "exactly n times"
  * `{n,}` means "at least n times"
  * `{,m}` means "at most m times"
  * `{n,m}` means "between n and m times"
  
  

```r
str_subset(countries, "e")
#>  [1] "Algeria"                  "Argentina"               
#>  [3] "Bangladesh"               "Belgium"                 
#>  [5] "Benin"                    "Bosnia and Herzegovina"  
#>  [7] "Cameroon"                 "Central African Republic"
#>  [9] "Chile"                    "Congo, Dem. Rep."        
#> [11] "Congo, Rep."              "Cote d'Ivoire"           
#> [13] "Czech Republic"           "Denmark"                 
#> [15] "Dominican Republic"       "Equatorial Guinea"       
#> [17] "Eritrea"                  "France"                  
#> [19] "Germany"                  "Greece"                  
#> [21] "Guatemala"                "Guinea"                  
#> [23] "Guinea-Bissau"            "Iceland"                 
#> [25] "Indonesia"                "Ireland"                 
#> [27] "Israel"                   "Kenya"                   
#> [29] "Korea, Dem. Rep."         "Korea, Rep."             
#> [31] "Lebanon"                  "Lesotho"                 
#> [33] "Liberia"                  "Mexico"                  
#> [35] "Montenegro"               "Mozambique"              
#> [37] "Nepal"                    "Netherlands"             
#> [39] "New Zealand"              "Niger"                   
#> [41] "Nigeria"                  "Peru"                    
#> [43] "Philippines"              "Puerto Rico"             
#> [45] "Reunion"                  "Sao Tome and Principe"   
#> [47] "Senegal"                  "Serbia"                  
#> [49] "Sierra Leone"             "Singapore"               
#> [51] "Slovak Republic"          "Slovenia"                
#> [53] "Sweden"                   "Switzerland"             
#> [55] "Turkey"                   "United Kingdom"          
#> [57] "United States"            "Venezuela"               
#> [59] "Vietnam"                  "West Bank and Gaza"      
#> [61] "Yemen, Rep."              "Zimbabwe"
str_subset(countries, "ee")
#> [1] "Greece"
str_subset(countries, "e{2}")
#> [1] "Greece"
str_subset(countries, ",")
#> [1] "Congo, Dem. Rep." "Congo, Rep."      "Hong Kong, China"
#> [4] "Korea, Dem. Rep." "Korea, Rep."      "Yemen, Rep."
```

Combine your new knowledge of regex with extraction, replacement, splitting.


```r
str_extract(countries, "lia")
#>   [1] NA    NA    NA    NA    NA    "lia" NA    NA    NA    NA    NA   
#>  [12] NA    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA   
#>  [23] NA    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA   
#>  [34] NA    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA   
#>  [45] NA    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA   
#>  [56] NA    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA   
#>  [67] NA    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA   
#>  [78] NA    NA    NA    NA    NA    NA    "lia" NA    NA    NA    NA   
#>  [89] NA    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA   
#> [100] NA    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA   
#> [111] NA    NA    NA    NA    NA    NA    "lia" NA    NA    NA    NA   
#> [122] NA    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA   
#> [133] NA    NA    NA    NA    NA    NA    NA    NA    NA    NA
str_extract(countries, "[dnlrst]ia")
#>   [1] NA    "nia" "ria" NA    NA    "lia" "ria" NA    NA    NA    NA   
#>  [12] NA    "nia" NA    NA    "ria" NA    NA    "dia" NA    NA    NA   
#>  [23] NA    NA    NA    NA    NA    NA    NA    NA    NA    "tia" NA   
#>  [34] NA    NA    NA    NA    NA    NA    NA    "ria" NA    NA    NA   
#>  [45] NA    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA   
#>  [56] NA    NA    NA    "dia" "sia" NA    NA    NA    NA    NA    NA   
#>  [67] NA    NA    NA    NA    NA    NA    NA    NA    "ria" NA    NA   
#>  [78] NA    "sia" NA    "nia" NA    NA    "lia" NA    NA    NA    NA   
#>  [89] NA    NA    NA    NA    NA    NA    "ria" NA    NA    NA    NA   
#> [100] NA    NA    NA    NA    NA    NA    NA    "nia" NA    NA    NA   
#> [111] NA    NA    NA    NA    NA    "nia" "lia" NA    NA    NA    NA   
#> [122] NA    NA    NA    "ria" NA    "nia" NA    NA    NA    "sia" NA   
#> [133] NA    NA    NA    NA    NA    NA    NA    NA    NA    NA
str_replace(countries, "[dnrlst]ia", "LAND")
#>   [1] "Afghanistan"              "AlbaLAND"                
#>   [3] "AlgeLAND"                 "Angola"                  
#>   [5] "Argentina"                "AustraLAND"              
#>   [7] "AustLAND"                 "Bahrain"                 
#>   [9] "Bangladesh"               "Belgium"                 
#>  [11] "Benin"                    "Bolivia"                 
#>  [13] "BosLAND and Herzegovina"  "Botswana"                
#>  [15] "Brazil"                   "BulgaLAND"               
#>  [17] "Burkina Faso"             "Burundi"                 
#>  [19] "CamboLAND"                "Cameroon"                
#>  [21] "Canada"                   "Central African Republic"
#>  [23] "Chad"                     "Chile"                   
#>  [25] "China"                    "Colombia"                
#>  [27] "Comoros"                  "Congo, Dem. Rep."        
#>  [29] "Congo, Rep."              "Costa Rica"              
#>  [31] "Cote d'Ivoire"            "CroaLAND"                
#>  [33] "Cuba"                     "Czech Republic"          
#>  [35] "Denmark"                  "Djibouti"                
#>  [37] "Dominican Republic"       "Ecuador"                 
#>  [39] "Egypt"                    "El Salvador"             
#>  [41] "EquatoLANDl Guinea"       "Eritrea"                 
#>  [43] "Ethiopia"                 "Finland"                 
#>  [45] "France"                   "Gabon"                   
#>  [47] "Gambia"                   "Germany"                 
#>  [49] "Ghana"                    "Greece"                  
#>  [51] "Guatemala"                "Guinea"                  
#>  [53] "Guinea-Bissau"            "Haiti"                   
#>  [55] "Honduras"                 "Hong Kong, China"        
#>  [57] "Hungary"                  "Iceland"                 
#>  [59] "InLAND"                   "IndoneLAND"              
#>  [61] "Iran"                     "Iraq"                    
#>  [63] "Ireland"                  "Israel"                  
#>  [65] "Italy"                    "Jamaica"                 
#>  [67] "Japan"                    "Jordan"                  
#>  [69] "Kenya"                    "Korea, Dem. Rep."        
#>  [71] "Korea, Rep."              "Kuwait"                  
#>  [73] "Lebanon"                  "Lesotho"                 
#>  [75] "LibeLAND"                 "Libya"                   
#>  [77] "Madagascar"               "Malawi"                  
#>  [79] "MalayLAND"                "Mali"                    
#>  [81] "MauritaLAND"              "Mauritius"               
#>  [83] "Mexico"                   "MongoLAND"               
#>  [85] "Montenegro"               "Morocco"                 
#>  [87] "Mozambique"               "Myanmar"                 
#>  [89] "Namibia"                  "Nepal"                   
#>  [91] "Netherlands"              "New Zealand"             
#>  [93] "Nicaragua"                "Niger"                   
#>  [95] "NigeLAND"                 "Norway"                  
#>  [97] "Oman"                     "Pakistan"                
#>  [99] "Panama"                   "Paraguay"                
#> [101] "Peru"                     "Philippines"             
#> [103] "Poland"                   "Portugal"                
#> [105] "Puerto Rico"              "Reunion"                 
#> [107] "RomaLAND"                 "Rwanda"                  
#> [109] "Sao Tome and Principe"    "Saudi Arabia"            
#> [111] "Senegal"                  "Serbia"                  
#> [113] "Sierra Leone"             "Singapore"               
#> [115] "Slovak Republic"          "SloveLAND"               
#> [117] "SomaLAND"                 "South Africa"            
#> [119] "Spain"                    "Sri Lanka"               
#> [121] "Sudan"                    "Swaziland"               
#> [123] "Sweden"                   "Switzerland"             
#> [125] "SyLAND"                   "Taiwan"                  
#> [127] "TanzaLAND"                "Thailand"                
#> [129] "Togo"                     "Trinidad and Tobago"     
#> [131] "TuniLAND"                 "Turkey"                  
#> [133] "Uganda"                   "United Kingdom"          
#> [135] "United States"            "Uruguay"                 
#> [137] "Venezuela"                "Vietnam"                 
#> [139] "West Bank and Gaza"       "Yemen, Rep."             
#> [141] "Zambia"                   "Zimbabwe"
str_split(countries, "\\W") ## \W mean 'not a word character'
#> [[1]]
#> [1] "Afghanistan"
#> 
#> [[2]]
#> [1] "Albania"
#> 
#> [[3]]
#> [1] "Algeria"
#> 
#> [[4]]
#> [1] "Angola"
#> 
#> [[5]]
#> [1] "Argentina"
#> 
#> [[6]]
#> [1] "Australia"
#> 
#> [[7]]
#> [1] "Austria"
#> 
#> [[8]]
#> [1] "Bahrain"
#> 
#> [[9]]
#> [1] "Bangladesh"
#> 
#> [[10]]
#> [1] "Belgium"
#> 
#> [[11]]
#> [1] "Benin"
#> 
#> [[12]]
#> [1] "Bolivia"
#> 
#> [[13]]
#> [1] "Bosnia"      "and"         "Herzegovina"
#> 
#> [[14]]
#> [1] "Botswana"
#> 
#> [[15]]
#> [1] "Brazil"
#> 
#> [[16]]
#> [1] "Bulgaria"
#> 
#> [[17]]
#> [1] "Burkina" "Faso"   
#> 
#> [[18]]
#> [1] "Burundi"
#> 
#> [[19]]
#> [1] "Cambodia"
#> 
#> [[20]]
#> [1] "Cameroon"
#> 
#> [[21]]
#> [1] "Canada"
#> 
#> [[22]]
#> [1] "Central"  "African"  "Republic"
#> 
#> [[23]]
#> [1] "Chad"
#> 
#> [[24]]
#> [1] "Chile"
#> 
#> [[25]]
#> [1] "China"
#> 
#> [[26]]
#> [1] "Colombia"
#> 
#> [[27]]
#> [1] "Comoros"
#> 
#> [[28]]
#> [1] "Congo" ""      "Dem"   ""      "Rep"   ""     
#> 
#> [[29]]
#> [1] "Congo" ""      "Rep"   ""     
#> 
#> [[30]]
#> [1] "Costa" "Rica" 
#> 
#> [[31]]
#> [1] "Cote"   "d"      "Ivoire"
#> 
#> [[32]]
#> [1] "Croatia"
#> 
#> [[33]]
#> [1] "Cuba"
#> 
#> [[34]]
#> [1] "Czech"    "Republic"
#> 
#> [[35]]
#> [1] "Denmark"
#> 
#> [[36]]
#> [1] "Djibouti"
#> 
#> [[37]]
#> [1] "Dominican" "Republic" 
#> 
#> [[38]]
#> [1] "Ecuador"
#> 
#> [[39]]
#> [1] "Egypt"
#> 
#> [[40]]
#> [1] "El"       "Salvador"
#> 
#> [[41]]
#> [1] "Equatorial" "Guinea"    
#> 
#> [[42]]
#> [1] "Eritrea"
#> 
#> [[43]]
#> [1] "Ethiopia"
#> 
#> [[44]]
#> [1] "Finland"
#> 
#> [[45]]
#> [1] "France"
#> 
#> [[46]]
#> [1] "Gabon"
#> 
#> [[47]]
#> [1] "Gambia"
#> 
#> [[48]]
#> [1] "Germany"
#> 
#> [[49]]
#> [1] "Ghana"
#> 
#> [[50]]
#> [1] "Greece"
#> 
#> [[51]]
#> [1] "Guatemala"
#> 
#> [[52]]
#> [1] "Guinea"
#> 
#> [[53]]
#> [1] "Guinea" "Bissau"
#> 
#> [[54]]
#> [1] "Haiti"
#> 
#> [[55]]
#> [1] "Honduras"
#> 
#> [[56]]
#> [1] "Hong"  "Kong"  ""      "China"
#> 
#> [[57]]
#> [1] "Hungary"
#> 
#> [[58]]
#> [1] "Iceland"
#> 
#> [[59]]
#> [1] "India"
#> 
#> [[60]]
#> [1] "Indonesia"
#> 
#> [[61]]
#> [1] "Iran"
#> 
#> [[62]]
#> [1] "Iraq"
#> 
#> [[63]]
#> [1] "Ireland"
#> 
#> [[64]]
#> [1] "Israel"
#> 
#> [[65]]
#> [1] "Italy"
#> 
#> [[66]]
#> [1] "Jamaica"
#> 
#> [[67]]
#> [1] "Japan"
#> 
#> [[68]]
#> [1] "Jordan"
#> 
#> [[69]]
#> [1] "Kenya"
#> 
#> [[70]]
#> [1] "Korea" ""      "Dem"   ""      "Rep"   ""     
#> 
#> [[71]]
#> [1] "Korea" ""      "Rep"   ""     
#> 
#> [[72]]
#> [1] "Kuwait"
#> 
#> [[73]]
#> [1] "Lebanon"
#> 
#> [[74]]
#> [1] "Lesotho"
#> 
#> [[75]]
#> [1] "Liberia"
#> 
#> [[76]]
#> [1] "Libya"
#> 
#> [[77]]
#> [1] "Madagascar"
#> 
#> [[78]]
#> [1] "Malawi"
#> 
#> [[79]]
#> [1] "Malaysia"
#> 
#> [[80]]
#> [1] "Mali"
#> 
#> [[81]]
#> [1] "Mauritania"
#> 
#> [[82]]
#> [1] "Mauritius"
#> 
#> [[83]]
#> [1] "Mexico"
#> 
#> [[84]]
#> [1] "Mongolia"
#> 
#> [[85]]
#> [1] "Montenegro"
#> 
#> [[86]]
#> [1] "Morocco"
#> 
#> [[87]]
#> [1] "Mozambique"
#> 
#> [[88]]
#> [1] "Myanmar"
#> 
#> [[89]]
#> [1] "Namibia"
#> 
#> [[90]]
#> [1] "Nepal"
#> 
#> [[91]]
#> [1] "Netherlands"
#> 
#> [[92]]
#> [1] "New"     "Zealand"
#> 
#> [[93]]
#> [1] "Nicaragua"
#> 
#> [[94]]
#> [1] "Niger"
#> 
#> [[95]]
#> [1] "Nigeria"
#> 
#> [[96]]
#> [1] "Norway"
#> 
#> [[97]]
#> [1] "Oman"
#> 
#> [[98]]
#> [1] "Pakistan"
#> 
#> [[99]]
#> [1] "Panama"
#> 
#> [[100]]
#> [1] "Paraguay"
#> 
#> [[101]]
#> [1] "Peru"
#> 
#> [[102]]
#> [1] "Philippines"
#> 
#> [[103]]
#> [1] "Poland"
#> 
#> [[104]]
#> [1] "Portugal"
#> 
#> [[105]]
#> [1] "Puerto" "Rico"  
#> 
#> [[106]]
#> [1] "Reunion"
#> 
#> [[107]]
#> [1] "Romania"
#> 
#> [[108]]
#> [1] "Rwanda"
#> 
#> [[109]]
#> [1] "Sao"      "Tome"     "and"      "Principe"
#> 
#> [[110]]
#> [1] "Saudi"  "Arabia"
#> 
#> [[111]]
#> [1] "Senegal"
#> 
#> [[112]]
#> [1] "Serbia"
#> 
#> [[113]]
#> [1] "Sierra" "Leone" 
#> 
#> [[114]]
#> [1] "Singapore"
#> 
#> [[115]]
#> [1] "Slovak"   "Republic"
#> 
#> [[116]]
#> [1] "Slovenia"
#> 
#> [[117]]
#> [1] "Somalia"
#> 
#> [[118]]
#> [1] "South"  "Africa"
#> 
#> [[119]]
#> [1] "Spain"
#> 
#> [[120]]
#> [1] "Sri"   "Lanka"
#> 
#> [[121]]
#> [1] "Sudan"
#> 
#> [[122]]
#> [1] "Swaziland"
#> 
#> [[123]]
#> [1] "Sweden"
#> 
#> [[124]]
#> [1] "Switzerland"
#> 
#> [[125]]
#> [1] "Syria"
#> 
#> [[126]]
#> [1] "Taiwan"
#> 
#> [[127]]
#> [1] "Tanzania"
#> 
#> [[128]]
#> [1] "Thailand"
#> 
#> [[129]]
#> [1] "Togo"
#> 
#> [[130]]
#> [1] "Trinidad" "and"      "Tobago"  
#> 
#> [[131]]
#> [1] "Tunisia"
#> 
#> [[132]]
#> [1] "Turkey"
#> 
#> [[133]]
#> [1] "Uganda"
#> 
#> [[134]]
#> [1] "United"  "Kingdom"
#> 
#> [[135]]
#> [1] "United" "States"
#> 
#> [[136]]
#> [1] "Uruguay"
#> 
#> [[137]]
#> [1] "Venezuela"
#> 
#> [[138]]
#> [1] "Vietnam"
#> 
#> [[139]]
#> [1] "West" "Bank" "and"  "Gaza"
#> 
#> [[140]]
#> [1] "Yemen" ""      "Rep"   ""     
#> 
#> [[141]]
#> [1] "Zambia"
#> 
#> [[142]]
#> [1] "Zimbabwe"
```

File listing is more good practice.
