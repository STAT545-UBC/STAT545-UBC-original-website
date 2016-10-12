# Date-times



*Under development ... really just a placeholder / collection of links*

### Date-time vectors: where they fit in

We've spent alot of time working with big, beautiful data frames. That are clean and wholesome, like the Gapminder data. With crude temporal information like, "THE YEAR IS 1952".

But real life will be much nastier. This information will come to you with much greater precision, reported to the last second or worse, complicated by time zones and daylight savings time idiosyncrasies. Or in some weird format.

Here we discuss common remedial tasks for dealing with date-times.

### Resources

I start with this because we cannot possibly do this topic justice in a short amount of time. Our goal is to make you aware of specific problems and solutions. Once you have a character problem in real life, these resources will be extremely helpful as you delve deeper.

[Dates and times](http://r4ds.had.co.nz/dates-and-times.html) chapter from [R for Data Science](http://r4ds.had.co.nz) by Hadley Wickham and Garrett Grolemund. See also the subsection on dates and times in the [Data import chapter](http://r4ds.had.co.nz/data-import.html).

The [lubridate](https://cran.r-project.org/package=lubridate) package. [Main vignette](https://cran.r-project.org/web/packages/lubridate/vignettes/lubridate.html).

Grolemund, G., & Wickham, H. (2011). Dates and Times Made Easy with lubridate. Journal of Statistical Software, 40(3), 1 - 25. <http://dx.doi.org/10.18637/jss.v040.i03>

Exercises to push you to learn [lubridate](https://cran.r-project.org/web/packages/lubridate/index.html): [part 1](http://r-exercises.com/2016/08/15/dates-and-times-simple-and-easy-with-lubridate-part-1/), [part 2](http://r-exercises.com/2016/08/29/dates-and-times-simple-and-easy-with-lubridate-exercises-part-2/), [part 3](http://r-exercises.com/2016/10/04/dates-and-times-simple-and-easy-with-lubridate-exercises-part-3/) *posts include links to answers!*

### Load the tidyverse and lubridate


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
library(lubridate)
#> 
#> Attaching package: 'lubridate'
#> The following object is masked from 'package:base':
#> 
#>     date
```


### Get your hands on some dates or date-times

Use base `Sys.Date()` or lubridate's `today()` to get today's date, without any time.


```r
Sys.Date()
#> [1] "2016-10-12"
today()
#> [1] "2016-10-12"
```

They both give you something of class `Date`.


```r
str(Sys.Date())
#>  Date[1:1], format: "2016-10-12"
class(Sys.Date())
#> [1] "Date"
str(today())
#>  Date[1:1], format: "2016-10-12"
class(today())
#> [1] "Date"
```

Use base `Sys.time()` or lubridate's `now()` to get RIGHT NOW, meaning the date and the time.


```r
Sys.time()
#> [1] "2016-10-12 08:46:55 PDT"
now()
#> [1] "2016-10-12 08:46:55 PDT"
```

They both give you something of class `POSIXct` in R jargon.


```r
str(Sys.time())
#>  POSIXct[1:1], format: "2016-10-12 08:46:55"
class(Sys.time())
#> [1] "POSIXct" "POSIXt"
str(now())
#>  POSIXct[1:1], format: "2016-10-12 08:46:55"
class(now())
#> [1] "POSIXct" "POSIXt"
```

### Get date or date-time from character

One of the main ways dates and date-times come into your life:

<http://r4ds.had.co.nz/dates-and-times.html#creating-datetimes#from-strings>

### Build date or date-time from parts

Second most common way dates and date-times come into your life:

<http://r4ds.had.co.nz/dates-and-times.html#creating-datetimes#from-individual-components>

Once you have dates, you might want to edit them in a non-annoying way:

<http://r4ds.had.co.nz/dates-and-times.html#setting-components>

### Get parts from date or date-time

<http://r4ds.had.co.nz/dates-and-times.html#date-time-components#getting-components>

### Arithmetic with date or date-time

<http://r4ds.had.co.nz/dates-and-times.html#time-spans>

### Get character from date or date-time

Eventually you will need to print this stuff in, say, a report.

*I always use `format()` but assumed lubridate had something else/better. Am I missing something here? Probably. For now, read the help: `?format.POSIXct`.*
