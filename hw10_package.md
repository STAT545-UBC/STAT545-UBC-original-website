---
title: "Building your own R package"
output:
  html_document:
    toc: true
    toc_depth: 2
---

# Big picture

In class we have developed the package `gameday` and showed

+ how to set up the directory structure for a package `devtools::create()`
+ what is the `DESCRIPTION` file
+ how to document functions of your package with `roxygen2` comments and `devtools::document()`
+ how to document the package itself with `roxygen2` comments and `devtools::document()`
+ how to add a vignette with `devtools::use_vignette()`
+ how to add `testthat` tests with `devtools::use_testthat()`
+ how to publish your package on GitHub so that `devtools::install_github()` works


In this homework you will either continue developing the `gameday` package or create your own package of helper functions (e.g. to work with `gapminder`, or other functions that you find useful).

Below we sketch the task for `gameday`. If you develop your own package, it must include the following:

+ Export at least two functions.
+ Every function that is exported (visible to the user) must be documented using `@param`, `@return`, `@examples`.
+ The package itself needs to be documented.
+ The package must include at least one helper function that is not exported (i.e. not callable directly even when the package is loaded (`Error: could not find function`)).
+ Include at least three tests (using `testthat`) for every function that is exported.
+ Add a validity check to at least one argument and throw an error early in the function if the input does not have the expected format (use `assertthat` and **import** the `assertthat` package correctly, as we did for `RCurl`). Add a test using `testthat::test_error()` that triggers this behavior.
+ Must pass `devtools::check()` without errors (warnings are ok).
+ Write a vignette where you describe why your package is useful, what functions it provides and how they can be combined to provide new insight to a sample question.
+ Upload your package to a **public** repository on GitHub. Add a minimal `README.md` that explains how to install your package, a minimal example how it works, and points to the vignette. *(If you are uncomfortable making your homework public to the world please contact Jenny and we can find a way around that. This may require some fiddling but is doable.)*


# Template

+ The version at the end of the class activity can be downloaded from [Bernhard's Github](https://github.com/BernhardKonrad/gameday), simply [unzip this file](https://github.com/BernhardKonrad/gameday/archive/master.zip).

The only difference from the class activity is that this version is a better *R* citizen with respect to namespace and imports. The `RCurl` dependency is moved from `Depends` to `Imports` (to avoid cluttering the namespace with `RCurl` function when loading `gameday`), and that instead of `getULR()` we use `RCurl::getURL` (see [here for more explanation on this detail](packages03_activity_part2.html)).



# Please just tell me what to do

If you don't feel like developing your own package, here's a `gameday` blueprint that is a minimal but respectable way to complete the assignment. You are welcome to remix R code already written by someone, student or JB, in this class, but credit/link appropriately, e.g. in comments or your vignette.


+ Rename the first argument `team.name` to `team` and provide the default value `"canucks"`. Update the documentation, examples and tests accordingly.
+ Add a second argument `date` that defaults to `Sys.Date()` and gives the user the option to see whether their team plays or played on a particular day. This test must pass:

```
test_that("Vancouver Canucks had a game against Nashville Predators on 2014-11-02", {
  expect_true(gday(team="canucks", date="2014-11-02"))
  expect_true(gday(team="predators", date="2014-11-02"))
})
```
+ Use `expect_false()` to check that a certain team did not have a game on a certain day.
+ Let `gday()` throw an error if there is not internet connection. For that, add a helper function `internet_connection` that takes no argument. This function should not be exported, that is, it should not be callable directly when `gameday` is loaded. The helper function below returns a logical that is only `TRUE` if an internet connection can be established:

```
internet_connection <- function(){
  tryCatch({RCurl::getURL("www.google.com"); TRUE},
    error = function(err) FALSE)
}
```
+ Add a helper function `check_date` that performs a validity check on `date` and returns a logical that is only `TRUE` when `date` is a valid date. You can check the value of `as.Date(date)` for that. Add at least one `expect_true` and `expect_false` test for `check_date`.
+ Use your function `check_date` to throw an error in `gday` if the provided date does not have the right format. A date like `201-411-07` should throw an error early. Use `assertthat` to throw the error. This requires that the `assertthat` package is imported (copy what we did for `RCurl`). Then add a test with `testthat::expect_error()` to trigger the error.
+ Add another function `scores` that takes `date` (use `check_date` to make sure the date is valid) and returns a data frame with information about the games on `date`. The *R code* below can be used as a blueprint for your function.

```
url  <- paste0('http://live.nhle.com/GameData/GCScoreboard/',
               date, '.jsonp')
raw <- RCurl::getURL(url)
json <- gsub('([a-zA-Z_0-9\\.]*\\()|(\\);?$)', "", raw, perl = TRUE)
data <- jsonlite::fromJSON(json)$games
with(data,
    data.frame(home = paste(htn, htcommon),
               away = paste(atn, atcommon),
               home_score = hts,
               away_score = ats))
```
+ Export `scores` so that the user can access it when `gameday` is loaded. Also add a documentation that provides `@param`, `@return` and `@examples`. Then add a handful of tests.
+ Write a vignette that can be used as a manual to your package and its functions. Provide at least one use-case where the output of `gday` or `scores` can be used to gain some insight. For example, to list all winning teams of a certain hockey day (you can use friends like `dplyr` or `ggplot` if you want to be fancy).
+ Finally, update the Version number to `1.0.0` and upload your package to a **public** repository on GitHub. Add a minimal `README.md` that explains how to install your package, a minimal example how it works, and points to the vignette. *(If you are uncomfortable making your homework public to the world please contact Jenny and we can find a way around that. This may require some fiddling but is doable.)*



# I want to aim higher!

+ Use `testthat::context(...)` to separate your tests into logical chuncks.
+ Extend the data.frame that `scores` returns by capturing more fields. Depending on what you want to do this may call for more helper functions or more functions that are exported. Document your new functions, add tests, and extend the vignette. Below is a description of what fields available in the data.

```
field                  datatype      descriptipon 
ata                    char(3)       Away team acronym, 3 letter short name 
atc                    text          Before: blank During: "progress" After: "winner" if away team wins 
atcommon               text          away team common name 
atn                    text          away team city name 
ats                    int           away team score 
atsog                  int           Before: null During and After: away team shots on goal 
bs                     time/text     Before: start time (unsure if local or EST) During: 05:10 2nd, eg After: "FINAL", "FINAL OT" etc 
bsc                    text          Before: blank During: "progress" After: "final" 
canationalbroadcasts   text          Canadian TV broadcasters, comma separated list 
gcl                    Bool          gamecenter live? 
gcll                   bool          gamecenter live? 
gs                     int           game status? 1=secheduled, 3= in progress, 5=finished 
hta                    char(3)       home team acronym 
htc                    text          Before: blank During: "progress" After: "winner" if home team wins 
htcommon               text          home team common name 
htn                    text          home team city name 
hts                    int           home team score 
htsog                  int           Before: null During and After: home team shots on goal 
id                     int           game ID 
rl                     Bool          true after game completed 
usnationalbroadcasts   text          US tv broadcasters, comma separated list  
```
+ Add a `data` directory that provides a list of all team names with the corresponding city and name of their home arena. Do not read this data from the web, you can [download this data file here](r_package_data/arena_team.tsv). Here is a short intro on [how to add data to your R package](http://r-pkgs.had.co.nz/data.html).
+ Use the data file [arena_team.tsv](r_package_data/arena_team.tsv) to add a validity check for `team` in the function `gday`. Return an error if this team is not listed in the data file (that is, if the city does not have an NHL team or if the team name has a typo). Write a test that triggers this error with `expect_error`.

# Authors

Written by [Bernhard Konrad][] and [Jenny Bryan][].

[Bernhard Konrad]: https://twitter.com/BernhardKonrad
[Jenny Bryan]: http://www.stat.ubc.ca/~jenny/
[CC BY 3.0]: http://creativecommons.org/licenses/by/3.0/
