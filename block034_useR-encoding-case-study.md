---
title: "Character encoding case study: useR! 2019"
output:
  html_document:
    toc: true
    toc_depth: 4
---



## Character encoding: other STAT 545 resources

  * Main page about character data: [Character vectors](block028_character-data.html)
  * General overview of character encoding, with links to external resources: [Encoding in R](block032_character-encoding.html)
  
This article assumes you are familiar with the material linked above.

## The useR! 2019 Speaker List

The last time I taught character encoding I vowed to develop a small case study the next time I encountered a suitable example in the wild. And, lo, the list of talks accepted for [useR! 2019](https://user2019.r-project.org/program_overview/) provides a great example of the real world encoding problems faced routinely by data analysts.

Let me be clear: I direct no criticism towards the organizers of useR! 2019. It's very easy for these sorts of problems to creep in whenever multiple humans fling strings around the internet, using diverse operating systems, locales, and software. It was very thoughtful of them to share this information publicly before the full program is published. And I thank them for a great expository example.

Here's how I downloaded the original csv file, which I store inside this repo to make this case study more future-proof:


```r
curl::curl_download(
  "http://www.user2019.fr/static/uploads/accepted-submissions_2019-04-16.csv",
  destfile = "useR-2019-accepted-talks.csv"
)
```

## What is the encoding of the file?

Analysts are always admonished to specify the correct encoding whenever they import data.

**Reality Check #1**: How the heck are you supposed to know what the encoding is? In the real world, data providers rarely provide this precious information.

Mercifully, the useR! organizers are on the ball and actually do describe the file:

> The list of accepted talks can be downloaded here (CSV file, separated by semi-colon, ISO-8859-15 encoded).

This is fantastic. And incredibly rare. So how would you determine this otherwise?

If you're on some flavor of *nix, you can probably use the `file` command to get some info (I executed this in a bash shell on macOS):


```bash
file -I useR-2019-accepted-talks.csv
#> useR-2019-accepted-talks.csv: text/plain; charset=iso-8859-1
```

The putative encoding returned by `file -I` is ISO-8859-1, which is wrong but close and probably close enough. In these situations, you are thankful for any shred of information.

There are many other ways to do this sort of detective work. For example, within R, you might use the `stri_enc_detect()` function from the [stringi package](http://www.gagolewski.com/software/stringi/):


```r
library(stringi)
x <- rawToChar(readBin("useR-2019-accepted-talks.csv", "raw", 100000))
stri_enc_detect(x)
#> [[1]]
#>     Encoding Language Confidence
#> 1 ISO-8859-1       en       0.75
#> 2 ISO-8859-2       ro       0.18
#> 3   UTF-16BE                0.10
#> 4   UTF-16LE                0.10
#> 5 ISO-8859-9       tr       0.10
```

Again, we get the implication that this file is encoded as ISO-8859-1, which is a good guess, but wrong. Again, this is a realistic tutorial.

Let's now assume you know the encoding. Or, well ... you think you do.

## Import the data

Use your favorite method of importing a delimited file. I use `readr::read_csv2()`, where the "2" signals that the semicolon `;` is the field delimiter. We also specify the ISO-8859-15 encoding we were advised to use. I load the tidyverse meta-package, because this exposition makes use of readr, dplyr, purrr, and the pipe `%>%` operator.


```r
library(tidyverse)
user <- read_csv2(
  "useR-2019-accepted-talks.csv",
  locale = locale(encoding = "ISO-8859-15")
)
#> Using ',' as decimal and '.' as grouping mark. Use read_delim() for more control.
#> Parsed with column specification:
#> cols(
#>   CREATEUSERID = col_character(),
#>   TITLE = col_character(),
#>   ABSTRACT = col_character(),
#>   TYPDOC = col_character()
#> )
```

## Tricky rows

Having inspected this file closely, allow me to draw your attention to a few specific names (format is "Lastname Firstname"):




```r
user[c(34, 43, 61, 107, 212, 336), "CREATEUSERID"]
#> # A tibble: 6 x 1
#>   CREATEUSERID      
#>   <chr>             
#> 1 Gallopin Mélina   
#> 2 Robin Geneviève   
#> 3 Fontez BÃ©nÃ©dicte
#> 4 Sauder CÃ©cile    
#> 5 Mørk Kristoffer   
#> 6 Rey Jean-François
```

We've got two examples where we've clearly had some sort of encoding mishap (entries 3 and 4), mixed in with other strings with non-ASCII characters that look just fine. Hmm, that's peculiar.

If you are curious, I found these non-ASCII strings by looking for the elements of `user$CREATEUSERID` where the declared encoding, reported by `Encoding()`, was not "unknown".

## Try another encoding

Again, with my head start, allow me to show you something else. What if I import this file with UTF-8 encoding?


```r
please_work <- readr::read_csv2(
  "useR-2019-accepted-talks.csv",
  locale = readr::locale(encoding = "UTF-8")
)
#> Using ',' as decimal and '.' as grouping mark. Use read_delim() for more control.
#> Parsed with column specification:
#> cols(
#>   CREATEUSERID = col_character(),
#>   TITLE = col_character(),
#>   ABSTRACT = col_character(),
#>   TYPDOC = col_character()
#> )
please_work[c(34, 43, 61, 107, 212, 336), "CREATEUSERID"]
#> # A tibble: 6 x 1
#>   CREATEUSERID          
#>   <chr>                 
#> 1 "Gallopin M\xe9lina"  
#> 2 "Robin Genevi\xe8ve"  
#> 3 Fontez Bénédicte      
#> 4 Sauder Cécile         
#> 5 "M\xf8rk Kristoffer"  
#> 6 "Rey Jean-Fran\xe7ois"
```

Sad. We've correctly imported the problematic names, at the cost of garbling the other four.

**Reality Check #2**: It an ideal world there is One True Encoding for any given file. Yes, that is how it is supposed to be. And yet it is not how it is.

## Unraveling a mixed encoding

So, what happened to this file? Its declared encoding is ISO-8859-1 but it's got some strings that need to be ingested as UTF-8.

The good news is you get to learn a delightful word for an unsavory phenomenon: **mojibake**:

> Mojibake is the garbled text that is the result of text being decoded using an unintended character encoding. The result is a systematic replacement of symbols with completely unrelated ones, often from a different writing system. -- [Wikipedia](https://en.wikipedia.org/wiki/Mojibake)

Used in a sentence:

> We have an ISO-8859-1 encoded, semicolon-delimited CSV, with a touch of mojibake.

At this point, I can't tell you how to catch this systematically. I can only say that with experience you get pretty good at knowing mojibake when you see it, forming a hypothesis about what went wrong, and fixing it. Remember the [Encoding in R](block032_character-encoding.html) page links to external resources, such as debugging tables that juxtapose intended and actual characters for the most common encoding fiascos.

## Diagnosis

The fact that we've got strings that import correctly when interpreted as UTF-8 (contradicting the nominal encoding) is the critical clue.

At some point, strings made it into this database that were UTF-8 encoded, although the intended encoding is ISO-8859-15. Then, when `readr::read_csv2()` ingests these allegedly ISO-8859-15 bytes and re-encodes them as UTF-8, we get the dreaded mojibake.

*Remember: I'm assuming you understand this problem space at the level presented in [Encoding in R](block032_character-encoding.html), i.e., you basically understand that characters are represented as bytes and different encodings are different systems for mapping between Unicode code points and 1 or more bytes.*

Let's look at the (correct) bytes that represent our target first names in UTF-8, which is the default for my OS (macOS) and what readr always returns. These are the bytes we *should* be seeing for these names.


```r
correct <- c("Bénédicte", "Cécile")
iconv(correct, from = "UTF-8", toRaw = TRUE)
#> [[1]]
#>  [1] 42 c3 a9 6e c3 a9 64 69 63 74 65
#> 
#> [[2]]
#> [1] 43 c3 a9 63 69 6c 65
```

This is hard to parse as a human, so I'm going to present richer output I got with the aid of a GitHub-only package, [ThinkR-open/utf8splain](https://github.com/ThinkR-open/utf8splain#readme).


```r
library(utf8splain)
runes("Bénédicte")
```


| id|description                     |rune   |utf8_bytes |
|--:|:-------------------------------|:------|:----------|
|  1|Latin Capital Letter B          |U+0042 |42         |
|  2|Latin Small Letter E with Acute |U+00E9 |C3 A9      |
|  3|Latin Small Letter N            |U+006E |6E         |
|  4|Latin Small Letter E with Acute |U+00E9 |C3 A9      |
|  5|Latin Small Letter D            |U+0064 |64         |
|  6|Latin Small Letter I            |U+0069 |69         |
|  7|Latin Small Letter C            |U+0063 |63         |
|  8|Latin Small Letter T            |U+0074 |74         |
|  9|Latin Small Letter E            |U+0065 |65         |

You'll notice the `utf8_bytes` reported here for "Bénédicte" match those returned by the `iconv()` call above, but the other columns help orient you to what else is going on:

  * `id` basically corresponds to what we perceive as "which character?" within the string
  * `description` is self-explanatory
  * `rune` identifies the associated Unicode code point
  * `utf8_bytes` are the literal bytes used to represent this code point in the UTF-8 encoding

Recall my claim that these specific strings were represented by UTF-8 bytes, in a file that is nominally ISO-8859-15, and were then garbled at ingest. We can reproduce the problem exactly.


```r
## 1. take UTF-8 encoded strings
c("Bénédicte", "Cécile") %>%
  ## 2. tell your converter to treat them as ISO-8859-15,
  ##    i.e. convert from ISO-8858-15 to UTF-8 and give you the bytes
  iconv(from = "ISO-8859-15", to = "UTF-8", toRaw = TRUE) -> my_bytes

my_bytes
#> [[1]]
#>  [1] 42 c3 83 c2 a9 6e c3 83 c2 a9 64 69 63 74 65
#> 
#> [[2]]
#> [1] 43 c3 83 c2 a9 63 69 6c 65

## 3. convert these raw (allegendly UTF-8) bytes back to strings
map_chr(my_bytes, rawToChar)
#> [1] "BÃ©nÃ©dicte" "CÃ©cile"
```

And that explains the mojibake we saw after the initial import:


```r
user[c(61, 107), "CREATEUSERID"]
#> # A tibble: 2 x 1
#>   CREATEUSERID      
#>   <chr>             
#> 1 Fontez BÃ©nÃ©dicte
#> 2 Sauder CÃ©cile
```

## Treatment

How do we fix this? For the affected strings, we:

  * Assert they are UTF-8 encoded.
  * Ask these bytes to be converted to ISO-8859-1.
  * Insert these new byte representations into the existing (implicitly UTF-8) character vector.
  
First, I'll practice on one of our affected strings, revealing the gory details of what's going on with the bytes:


```r
(x <- "CÃ©cile")
#> [1] "CÃ©cile"
iconv(x, from = "UTF-8", toRaw = TRUE)
#> [[1]]
#> [1] 43 c3 83 c2 a9 63 69 6c 65
(x_re_encoded <- iconv(x, from = "UTF-8", to = "ISO-8859-15", toRaw = TRUE))
#> [[1]]
#> [1] 43 c3 a9 63 69 6c 65
rawToChar(x_re_encoded[[1]])
#> [1] "Cécile"
```

Now we apply this repair formula to the affected strings in our useR! data frame:
  

```r
fixme <- c(61, 107)

iconv(user$CREATEUSERID[fixme], from = "UTF-8", to = "ISO-8859-15")
#> [1] "Fontez Bénédicte" "Sauder Cécile"

user$CREATEUSERID[fixme] <- iconv(
  user$CREATEUSERID[fixme],
  from = "UTF-8", to = "ISO-8859-15"
)
```

We revisit the original 6 specimens to confirm that we've corrected the strings that needed repair, without disturbing those that did not.


```r
user[c(34, 43, 61, 107, 212, 336), c("CREATEUSERID", "TITLE")]
#> # A tibble: 6 x 2
#>   CREATEUSERID     TITLE                                                   
#>   <chr>            <chr>                                                   
#> 1 Gallopin Mélina  Appinetwork : Analysis of Protein-Protein Interaction N…
#> 2 Robin Geneviève  R package lori: A new multiple imputation method for co…
#> 3 Fontez Bénédicte Use of sentinel-2 images in Agriculture                 
#> 4 Sauder Cécile    BibliographeR : a set of tools to help your bibliograph…
#> 5 Mørk Kristoffer  Estimate, Estimator, Estimand?                          
#> 6 Rey Jean-Franço… R package development using GitLab CI/CD pipeline
```

Success!

You will notice that this was a highly manual process and I'm afraid that is quite realistic, when something that should never happen -- mixed encoding -- actually happens. In my experience, it is typical to stumble across the problem, hope you can systematically identify the affected data, and then apply a targeted fix.
