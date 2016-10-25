# Character data



## Character vectors: where they fit in

We've spent alot of time working with big, beautiful data frames. That are clean and wholesome, like the Gapminder data.

But real life will be much nastier. You will bring data into R from the outside world and discover there are problems. You might think: how hard can it be to deal with character data? And the answer is: it can be very hard!

  * [Stack Exchange outage](http://stackstatus.net/post/147710624694/outage-postmortem-july-20-2016)
  * [Regexes to validate/match email addresses](http://emailregex.com)
  * [Fixing an Atom bug](http://davidvgalbraith.com/how-i-fixed-atom/)

Here we discuss common remedial tasks for cleaning and transforming character data, also known as "strings". A data frame or tibble will consist of one or more *atomic vectors* of a certain class. This lesson deals with things you can do with vectors of class `character`.

## Resources

I start with this because we cannot possibly do this topic justice in a short amount of time. Our goal is to make you aware of broad classes of problems and their respective solutions. Once you have a character problem in real life, these resources will be extremely helpful as you delve deeper.

#### Manipulating character vectors

  * [stringr package](https://cran.r-project.org/web/packages/stringr/index.html)
    - A non-core package in the tidyverse. It is installed via `install.packages("tidyverse")`, but not loaded via `library(tidyverse)`. Load it as needed via `library(stringr)`.
    - Main functions start with `str_`. Auto-complete is your friend.
    - Replacements for base functions re: string manipulation and regular expressions (see below).
    - Main advantagse over base functions: greater consistency about inputs and outputs. Outputs are more ready for your next analytical task. 
  * [tidyr package](https://cran.r-project.org/web/packages/tidyr/index.html)
    - Especially useful for functions that split 1 character vector into many and *vice versa*: `separate()`, `unite()`, `extract()`.
  * Base functions: `nchar()`, `strsplit()`, `substr()`, `paste()`, `paste0()`.

#### Regular expressions

A God-awful and powerful language for expressing patterns to match in text or for search-and-replace. Frequently described as "write only", because regular expressions are easier to write than to read/understand. And they are not particularly easy to write.

  * We again prefer the [stringr package](https://cran.r-project.org/web/packages/stringr/index.html) over base functions. Why?
    - Wraps [stringi](https://cran.r-project.org/web/packages/stringi/index.html), which is a great place to look if stringr isn't powerful enough.
    - Standardized on [ICU regular expressions](http://userguide.icu-project.org/strings/regexp), so you can stop toggling `perl = TRUE/FALSE` at random.
    - Results come back in a form that is much friendlier for downstream work.
  * The [Strings chapter](http://r4ds.had.co.nz/strings.html) of [R for Data Science](http://r4ds.had.co.nz) is a great resource.
  * Older STAT 545 lessons on regular expressions have some excellent content. This lesson draws on them, but makes more rigorous use of stringr and uses example data that is easier to support long-term.
    -  [2014 Intro to regular expressions](block022_regular-expression.html) by TA Gloria Li.
    - [2015 Regular expressions and character data in R](block027_regular-expressions.html) by TA Kieran Samuk.
  * RStudio Cheat Sheet on [Regular Expressions in R](https://www.rstudio.com/wp-content/uploads/2016/09/RegExCheatsheet.pdf)
  * Regex testers
    - [regex101.com](https://regex101.com)
    - [regexr.com](http://regexr.com)
  * [rex R package](https://github.com/kevinushey/rex): make regular expression from human readable expressions
  * Base functions: `grep()` and friends.

#### Character encoding

  * [Strings subsection of data import chapter](http://r4ds.had.co.nz/data-import.html#readr-strings) in R for Data Science
  * Screeds on the Minimum Everyone Needs to Know about encoding
    - [The Absolute Minimum Every Software Developer Absolutely, Positively Must Know About Unicode and Character Sets (No Excuses!)](http://www.joelonsoftware.com/articles/Unicode.html)
    - [What Every Programmer Absolutely, Positively Needs To Know About Encodings And Character Sets To Work With Text](http://kunststube.net/encoding/)
  * I've translated this blog post [Guide to fixing encoding problems in Ruby](http://www.justinweiss.com/articles/3-steps-to-fix-encoding-problems-in-ruby/) into R as the first step to developing a lesson: [Encoding in R](block032_character-encoding.html)

#### Character vectors that live in a data frame

  * Certain operations are facilitated by `tidyr`. These are described below.
  * For a general discussion of how to work on variables that live in a data frame, see [Vectors versus tibbles](block031_vector-tibble-relations.html)

## Load stringr and the core tidyverse


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

## Regex-free string manipulation with stringr and tidyr

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

### Detect or filter on a target string

Determine presence/absence of a literal string with `str_detect()`. Spoiler: later we see `str_detect()` also detects regular expressions.

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

### String splitting by delimiter

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

If you are willing to commit to the number of pieces, you can use `str_split_fixed()` and get a character matrix. You're welcome!


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

### Substring extraction (and replacement) by position

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

The `start` and `end` arguments are vectorised. Example: a sliding 3-character window.


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

### Collapse a vector

You can collapse a character vector of length `n > 1` to a single string with `str_c()`, which also has other uses (see next section).


```r
head(fruit) %>% 
  str_c(collapse = ", ")
#> [1] "apple, apricot, avocado, banana, bell pepper, bilberry"
```

### Create a character vector by catenating multiple vectors

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

### Substring replacement

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

And that concludes our treatment of regex-free manipulations of character data!

## Regular expressions with stringr

![](img/regexbytrialanderror-big-smaller.png)

### Load Gapminder

The country names in the gapminder dataset are convenient for examples. Load it now and store the 142 unique country names to the object `countries`.


```r
library(gapminder)
countries <- levels(gapminder$country)
```

### Characters with special meaning

Frequently your string tasks cannot be expressed in terms of a fixed string, but can be described in terms of a **pattern**. Regular expressions, aka "regexes", are the standard way to specify these patterns. In regexes, specific characters and constructs take on special meaning in order to match multiple strings.

The first metacharacter is the period `.`, which stands for any single character, except a newline (which by the way, is represented by `\n`). The regex `a.b` will match all countries that have an `a`, followed by any single character, followed by `b`. Yes, regexes are case sensitive, i.e. "Italy" does not match.


```r
str_subset(countries, "i.a")
#>  [1] "Argentina"                "Bosnia and Herzegovina"  
#>  [3] "Burkina Faso"             "Central African Republic"
#>  [5] "China"                    "Costa Rica"              
#>  [7] "Dominican Republic"       "Hong Kong, China"        
#>  [9] "Jamaica"                  "Mauritania"              
#> [11] "Nicaragua"                "South Africa"            
#> [13] "Swaziland"                "Taiwan"                  
#> [15] "Thailand"                 "Trinidad and Tobago"
```

Notice that `i.a` matches "ina", "ica", "ita", and more.

**Anchors** can be included to express where the expression must occur within the string. The `^` indicates the beginning of string and `$` indicates the end.

Note how the regex `i.a$` matches many fewer countries than `i.a` alone. Likewise, more elements of `my_fruit` match `d` than `^d`, which requires "d" at string start.


```r
str_subset(countries, "i.a$")
#> [1] "Argentina"              "Bosnia and Herzegovina"
#> [3] "China"                  "Costa Rica"            
#> [5] "Hong Kong, China"       "Jamaica"               
#> [7] "South Africa"
str_subset(my_fruit, "d")
#> [1] "breadfruit"  "dragonfruit"
str_subset(my_fruit, "^d")
#> [1] "dragonfruit"
```

The metacharacter `\b` indicates a **word boundary** and `\B` indicates NOT a word boundary. This is our first encounter with something called "escaping" and right now I just want you at accept that we need to prepend a second backslash to use these sequences in regexes in R. We'll come back to this tedious point later.


```r
str_subset(fruit, "melon")
#> [1] "canary melon" "rock melon"   "watermelon"
str_subset(fruit, "\\bmelon")
#> [1] "canary melon" "rock melon"
str_subset(fruit, "\\Bmelon")
#> [1] "watermelon"
```

### Character classes

Characters can be specified via classes. You can make them explicitly "by hand" or use some pre-existing ones.  The [2014 STAT 545 regex lesson](block022_regular-expression.html) has a good list of character classes. Character classes are usually given inside square brackets, `[]` but a few come up so often that we have a metacharacter for them, such as `\d` for a single digit.

Here we match `ia` at the end of the country name, preceded by one of the characters in the class. Or, in the negated class, preceded by anything but one of those characters.


```r
## make a class "by hand"
str_subset(countries, "[nls]ia$")
#>  [1] "Albania"    "Australia"  "Indonesia"  "Malaysia"   "Mauritania"
#>  [6] "Mongolia"   "Romania"    "Slovenia"   "Somalia"    "Tanzania"  
#> [11] "Tunisia"
## use ^ to negate the class
str_subset(countries, "[^nls]ia$")
#>  [1] "Algeria"      "Austria"      "Bolivia"      "Bulgaria"    
#>  [5] "Cambodia"     "Colombia"     "Croatia"      "Ethiopia"    
#>  [9] "Gambia"       "India"        "Liberia"      "Namibia"     
#> [13] "Nigeria"      "Saudi Arabia" "Serbia"       "Syria"       
#> [17] "Zambia"
```

Here we revisit splitting `my_fruit` with two more general ways to match whitespace: the `\s` metacharacter and the POSIX class `[:space:]`. Notice that we must prepend an extra backslash `\` to escape `\s` and the POSIX class has to be surrounded by two sets of square brackets.


```r
## remember this?
# str_split_fixed(fruit, " ", 2)
## alternatives
str_split_fixed(my_fruit, "\\s", 2)
#>      [,1]           [,2]   
#> [1,] "breadfruit"   ""     
#> [2,] "dragonfruit"  ""     
#> [3,] "grapefruit"   ""     
#> [4,] "jackfruit"    ""     
#> [5,] "kiwi"         "fruit"
#> [6,] "passionfruit" ""     
#> [7,] "star"         "fruit"
#> [8,] "ugli"         "fruit"
str_split_fixed(my_fruit, "[[:space:]]", 2)
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

Let's see the country names that contain punctuation.


```r
str_subset(countries, "[[:punct:]]")
#> [1] "Congo, Dem. Rep." "Congo, Rep."      "Cote d'Ivoire"   
#> [4] "Guinea-Bissau"    "Hong Kong, China" "Korea, Dem. Rep."
#> [7] "Korea, Rep."      "Yemen, Rep."
```

### Quantifiers

You can decorate characters (and other constructs, like metacharacters and classes) with information about how many characters they are allowed to match.

| quantifier | meaning   | quantifier | meaning                    |
|------------|-----------|------------|----------------------------|
| *          | 0 or more | {n}        | exactly n                  |
| +          | 1 or more | {n,}       | at least n                 |
| ?          | 0 or 1    | {,m}       | at most m                  |
|            |           | {n,m}      | between n and m, inclusive |

Explore these by inspecting matches for `l` followed by `e`, allowing for various numbers of characters in between.

`l.*e` will match strings with 0 or more characters in between, i.e. any string with an `l` eventually followed by an `e`. This is the most inclusive regex for this example, so we store the result as `matches` to use as a baseline for comparison.


```r
(matches <- str_subset(fruit, "l.*e"))
#>  [1] "apple"             "bell pepper"       "bilberry"         
#>  [4] "blackberry"        "blood orange"      "blueberry"        
#>  [7] "cantaloupe"        "chili pepper"      "clementine"       
#> [10] "cloudberry"        "elderberry"        "huckleberry"      
#> [13] "lemon"             "lime"              "lychee"           
#> [16] "mulberry"          "olive"             "pineapple"        
#> [19] "purple mangosteen" "salal berry"
```

Change the quantifier from `*` to `+` to require at least one intervening character. The strings that no longer match: all have a literal `le` with no preceding `l` and no following `e`.


```r
list(match = intersect(matches, str_subset(fruit, "l.+e")),
     no_match = setdiff(matches, str_subset(fruit, "l.+e")))
#> $match
#>  [1] "bell pepper"       "bilberry"          "blackberry"       
#>  [4] "blood orange"      "blueberry"         "cantaloupe"       
#>  [7] "chili pepper"      "clementine"        "cloudberry"       
#> [10] "elderberry"        "huckleberry"       "lime"             
#> [13] "lychee"            "mulberry"          "olive"            
#> [16] "purple mangosteen" "salal berry"      
#> 
#> $no_match
#> [1] "apple"     "lemon"     "pineapple"
```

Change the quantifier from `*` to `?` to require at most one intervening character. In the strings that no longer match, the shortest gap between `l` and following `e` is at least two characters.


```r
list(match = intersect(matches, str_subset(fruit, "l.?e")),
     no_match = setdiff(matches, str_subset(fruit, "l.?e")))
#> $match
#>  [1] "apple"             "bilberry"          "blueberry"        
#>  [4] "clementine"        "elderberry"        "huckleberry"      
#>  [7] "lemon"             "mulberry"          "pineapple"        
#> [10] "purple mangosteen"
#> 
#> $no_match
#>  [1] "bell pepper"  "blackberry"   "blood orange" "cantaloupe"  
#>  [5] "chili pepper" "cloudberry"   "lime"         "lychee"      
#>  [9] "olive"        "salal berry"
```

Finally, we remove the quantifier and allow for no intervening characters. The strings that no longer match lack a literal `le`.


```r
list(match = intersect(matches, str_subset(fruit, "le")),
     no_match = setdiff(matches, str_subset(fruit, "le")))
#> $match
#> [1] "apple"             "clementine"        "huckleberry"      
#> [4] "lemon"             "pineapple"         "purple mangosteen"
#> 
#> $no_match
#>  [1] "bell pepper"  "bilberry"     "blackberry"   "blood orange"
#>  [5] "blueberry"    "cantaloupe"   "chili pepper" "cloudberry"  
#>  [9] "elderberry"   "lime"         "lychee"       "mulberry"    
#> [13] "olive"        "salal berry"
```

### Escaping

You've probably caught on by now that there are certain characters with special meaning in regexes, including `$ * + . ? [ ] ^ { } | ( ) \`.

What if you really need the plus sign to be a literal plus sign and not a regex quantifier? You will need to *escape* it by prepending a backslash. But wait ... there's more! Before a regex is interpreted as a regular expression, it is also interpreted by R as a string. And backslash is used to escape there as well. So, in the end, you need to preprend two backslashes in order to match a literal plus sign in a regex.

This will be more clear with examples!

#### Escapes in plain old strings

Here is routine, non-regex use of backslash `\` escapes in plain vanilla R strings. We intentionally use `cat()` instead of `print()` here.

  * To escape quotes inside quotes:
    
    ```r
    cat("Do you use \"airquotes\" much?")
    #> Do you use "airquotes" much?
    ```
    Sidebar: eliminating the need for these escapes is exactly why people use double quotes inside single quotes and *vice versa*.
  * To insert newline (`\n`) or tab (`\t`):
    
    ```r
    cat("before the newline\nafter the newline")
    #> before the newline
    #> after the newline
    cat("before the tab\tafter the tab")
    #> before the tab	after the tab
    ```

#### Escapes in regular expressions

Examples of using escapes in regexes to match characters that would otherwise have a special interpretation.

We know several Gapminder country names contain a period. How do we isolate them? Although it's tempting, this command `str_subset(countries, ".")` won't work!


```r
## cheating using a POSIX class ;)
str_subset(countries, "[[:punct:]]")
#> [1] "Congo, Dem. Rep." "Congo, Rep."      "Cote d'Ivoire"   
#> [4] "Guinea-Bissau"    "Hong Kong, China" "Korea, Dem. Rep."
#> [7] "Korea, Rep."      "Yemen, Rep."
## using two backslashes to escape the period
str_subset(countries, "\\.")
#> [1] "Congo, Dem. Rep." "Congo, Rep."      "Korea, Dem. Rep."
#> [4] "Korea, Rep."      "Yemen, Rep."
```

A last example that matches an actual square bracket.


```r
(x <- c("whatever", "X is distributed U[0,1]"))
#> [1] "whatever"                "X is distributed U[0,1]"
str_subset(x, "\\[")
#> [1] "X is distributed U[0,1]"
```

### Groups and backreferences

Your first use of regex is likely to be simple matching: detecting or isolating strings that match a pattern.

But soon you will want to use regexes to transform the strings in character vectors. That means you need a way to address specific parts of the matching strings and to operate on them.

You can use parentheses inside regexes to define *groups* and you can refer to those groups later with *backreferences*.

For now, this lesson will refer you to other place to read up on this:

  * STAT 545 [2014 Intro to regular expressions](block022_regular-expression.html) by TA Gloria Li.
  * The [Strings chapter](http://r4ds.had.co.nz/strings.html) of [R for Data Science](http://r4ds.had.co.nz).
