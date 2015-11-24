---
title: "Building your own R package"
output:
  html_document:
    toc: true
    toc_depth: 3
---

**NOTE: From 2014 and not used in 2015. Original number was hw10.**

## Big picture

In class we developed the package `gameday` and showed how to

+ set up the directory structure for a package using `devtools::create()`
+ populate the `DESCRIPTION` file
+ document the functions of your package and the package itself with `roxygen2` comments and `devtools::document()`
+ use a function from another package via the `Imports` field of `DESCRIPTION` and syntax like `foopkg::foofunction()`
+ build, install, and load your developing package with RStudio's "Build and Reload" or to fake doing that with `devtools::load_all()`
+ add and render a vignette with `devtools::use_vignette()` and `devtools::build_vignettes()`
+ configure your package to use `testthat` for unit testing with `devtools::use_testthat()` and run your tests with `devtools::test()`
+ publish your package on GitHub so that `devtools::install_github()` works

The [landing page for all the package material](packages00_index.html) contains lots of [links](packages00_index.html#resources) with extra technical information and general inspiration.

In this homework you will either continue developing the `gameday` package or create your own package (inspiration given below).

Below we outline follow-up tasks for `gameday`. If you develop your own package, it must include the following elements:

+ Export at least two functions, i.e. make them visible to and usable by a user.
+ Give function arguments sensible defaults, if at all possible.
+ Document exported functions and the package itself, e.g. a user must be able to get help via `?`
    - documentation for exported functions must include `@param`, `@return`, `@examples`, at least.
+ Include at least one helper function that is NOT exported but is used by other function(s) in the package
    - this means function is not callable directly by the user; you will know this function is NOT exported if, when user tries to call it, she gets `Error: could not find function`
+ Include at least three tests for every function that is exported,
    - use `testthat` for your testing.
+ Add a validity check to at least one argument and throw an error if the input is invalid
    - revisit our [block on writing your own functions](block011_write-your-own-function-01.html) for a refresher,
    - use `assertthat` for this validity check and import the `assertthat` package correctly, as we did for `RCurl`
    - make sure one of your tests verifies that invalid input does indeed trigger the error, using `testthat::expect_error()`.
+ Your package must pass `devtools::check()` without errors (warnings and notes are OK).
+ Write a vignette where you describe why your package is useful, what functions it provides and how they can be combined to provide answer a simple sample question. Your vignette is the main prose document for this homework, so that's where your reflections on the process should go, even though that would be weird for a real vignette!
+ Upload your package to a **public** repository on GitHub. Add a minimal `README.md` that shows how to install your package, a minimal example how it works, and links to the vignette. *(If you are uncomfortable making your homework public to the world please contact Jenny and we can find a way around that. This may require some fiddling but is doable.)*

### Due date

Submit an issue with a link to your package sometime on ~~Friday November 21~~ *if you need the weekend, submit before class on Monday November 24*.

## Template

+ In case things went sideways for you during the in-class activity, you can obtain `gameday` as it should have been at the end of class from [Bernhard's Github](https://github.com/BernhardKonrad/gameday). Use your mad Git skilz to get it or simply [unzip this file](https://github.com/BernhardKonrad/gameday/archive/master.zip).

The only difference from the class activity is that this version is a better R citizen with respect to namespace and imports. The `RCurl` dependency has been moved from `Depends` to `Imports` and we call `getURL()` like so: `RCurl::getURL`. Go [here for more explanation on this detail](packages03_activity_part2.html).

## Please just tell me what to do

If you don't feel like developing your own package, here's a `gameday` blueprint that is a respectable way to complete the assignment. You are welcome to remix R code already written by someone, student or JB, in this class, but credit/link appropriately, e.g. in comments or your vignette. Take full advantage of [office hours](https://github.com/STAT545-UBC/Discussion/issues/47) and the [Discussion board](https://github.com/STAT545-UBC/Discussion/issues)!

If you can't do all of this, do what you can. Make sure to include the vignette and push to GitHub, since that is needed for peer review and marking. Jenny took a crack at some parts of this homework and [has some hints](hw10_package_jenny-hints.html).


+ Rename the first argument `team.name` to `team` and provide the default value `"canucks"`. Update the documentation, examples and tests accordingly.
+ Add a second argument `date` that defaults to `Sys.Date()` and gives the user the option to see whether their team plays or played on a particular day. Include this test of the new date functionality:

    ```
    test_that("Vancouver Canucks had a game against Nashville Predators on 2014-11-02", {
      expect_true(gday(team = "canucks",   date = "2014-11-02"))
      expect_true(gday(team = "predators", date = "2014-11-02"))
})
    ```

+ Use `expect_false()` to develop a similar test that a certain team did not have a game on a certain day.
+ Kill your internet connection and use `gday()`. What happens? Make this failure more graceful and informative for the user. To help with this, we'll add a helper function `internet_connection()` that takes no argument. This function should NOT be exported, that is, it should not be callable directly when `gameday` is loaded. The `internet_connection()` function below returns a logical that is only `TRUE` if an internet connection can be established:

    ```
    internet_connection <- function() {
      tryCatch({RCurl::getURL("www.google.com"); TRUE},
        error = function(err) FALSE)
    }
    ```
Use this helper function in `gday()` to check for an internet connection *before* trying to get info from the web. If there is is no internet connection, explain this failure to the user.
+ Add an unexported helper function `check_date()` that performs a validity check on argument `date` and returns a logical that is only `TRUE` when `date` is a valid date. You can check the value of `as.Date(date)` for that. Add at least one `expect_true()` and `expect_false()` test for `check_date`.
+ Use your function `check_date()` to throw an error in `gday()` if the provided date does not have the right format. A date like `201-411-07` should throw an error early. Use `assertthat` to throw the error. This requires that the `assertthat` package is imported (copy what we did for `RCurl`). Then add a test with `testthat::expect_error()` to confirm that invalid date input triggers the error.
+ Add another function `scores()` that takes `date` and returns a data.frame with information about the games on `date`. Use your helper functions to confirm an internet connection and a valid date. The R code below can be used as fodder for your function.

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
+ Export `scores()` so that the user can access it when `gameday` is loaded. Also add a documentation that provides `@param`, `@return` and `@examples`. Then add a handful of tests.
+ Write a vignette that can be used as a manual to your package and its functions. Provide at least one use-case where the output of `gday` or `scores` can be used to gain some insight. For example, to list all winning teams of a certain hockey day (you can use friends like `dplyr` or `ggplot` if you want to be fancy).
+ Finally, update the Version number to `1.0.0` and upload your package to a **public** repository on GitHub. Add a minimal `README.md` that explains how to install your package, a minimal example how it works, and points to the vignette. *(If you are uncomfortable making your homework public to the world please contact Jenny and we can find a way around that. This may require some fiddling but is doable.)*

## I want to aim higher! gameday version

+ Use `testthat::context(...)` to separate your tests into logical chunks.
+ Extend the data.frame that `scores` returns by capturing more fields. Depending on what you want to do this may call for more helper functions or more functions that are exported. Document your new functions, add tests, and extend the vignette. Below is a description of what fields are available in the data.

```
field                  datatype      description 
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
gs                     int           game status? 1=scheduled, 3= in progress, 5=finished 
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
+ Add a `data` directory that provides a data.frame of all team names with the corresponding city and name of their home arena. Do not read this data from the web, you can [download this data file here](r_package_data/arena_team.tsv). Here is a short intro on [how to add data to your R package](http://r-pkgs.had.co.nz/data.html).
+ Use the data in [arena_team.tsv](r_package_data/arena_team.tsv) to add a validity check for `team` in the function `gday()`. Return an error if this team is not listed in the data.frame (that is, if the city does not have an NHL team or if the team name has a typo). Write a test that triggers this error with `testthat::expect_error()`.
+ Use the data to generalize `gday()` so that it works if the user requests info for the "Canucks" or "Vancouver."

## I want to aim higher! blue sky version

Do you want to write your very own package and ditch `gameday`? Here are some ideas.

  * Re-implement and expand on [`cats`](https://github.com/hilaryparker/cats) with your favorite animal.
  *  Personal package of utility functions. Examples from Jenny's life:
    - `peek()`: kind of like `head()` and `tail()` but uses a random sample instead of the first few or last elements
    - wrapper around `write.table()` that, by default, sets `row.names = FALSE`, `quote = FALSE` and `sep =` to tab or comma
  * `NA` sleuth to provide a report and perhaps visual info on how many `NA`s are in a data.frame, afflicting which variables, in which rows
  * `factorboss`
    - heatmap-style visual overview of factor levels in a data.frame (Gapminder would work well as practice dataset ... how easy can you make it to spot that data comes in 12 row clumps by country?)
    - detect factors that should be character because # unique values = length
    - write a version of reorder() that uses `desc()` a la `(d)plyr`
    - write a version of `factor()` that sets levels to the order in which they appear in the data, i.e. set the levels "as is"
    - functions to write and read data.frames to plain text delimited files while retaining factor levels; maybe by writing/reading a companion file?

## Rubric

Your peer reviewer will try to install your package from GitHub and use it! They will follow your instructions from `README.md` and might even try stuff from your vignette.

Check minus: Package does not install. Or installation seemed go OK but one or more of the functions don't work. Or you do something that seems totally natural (probably copied from `README.md` or vignette) and get odd behavior.

Check: Hits most/all the elements. No obvious technical difficulties. Package pleasant to use. `README.md` and vignette are pleasant to read and provide accessible examples of usage. No heroic detective work required. Good work!

Check plus: Exceeded the requirements in number of dimensions. Took `gameday` farther than was required. Wrote a new package from scratch. Experience of installation and usage was dreamy because of excellent documentation and high functionality. You learned something new from reviewing their work and you’re eager to incorporate it into your work. Wow!

Recall the [general homework rubric](http://stat545-ubc.github.io/peer-review01_marking-rubric.html).

## Authors

Written by [Bernhard Konrad][] and [Jenny Bryan][].

[Bernhard Konrad]: https://twitter.com/BernhardKonrad
[Jenny Bryan]: http://www.stat.ubc.ca/~jenny/
