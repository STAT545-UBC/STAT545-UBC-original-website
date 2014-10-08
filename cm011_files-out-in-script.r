## get into correct Project and working directory

## clean out the workspace, restart R

## open a new R script and save with a good name

## load packages: probably ggplot2 and dplyr?

## bring in Gapminder data

## optional: subset the Gapminder data drastically ... maybe use same 5 countries from the factor reordering demo?

## use write.table() to write this to file

## at first, use no arguments ... do you like what you see?
## do again with quote = FALSE, sep = "\t", row.names = FALSE

## invertibility and internal consistency dilemma
## - plain text files
## - modularity: output of script i is input for script i + 1
## - be factor boss = order the levels in a principled way
## - avoid duplication of code and data

## my compromise: I save plain text (often ordered meaningfully) AND R-specific files

## optional: subset the Gapminder data drastically ... maybe use same 5 countries from the factor reordering demo?

## inspect the levels of country

## reorder country according to one of the summary stats we've played with
##  - intercept or slope from a regression
##  - max life expectancy, min, etc.
##  - pop in 2007
##  - you get the idea? pick something, anything

## re-inspect the levels
## HAVE THEY CHANGED?

## write to file with write.table()
## delete the R object from the workspace
## re-import the R object FROM FILE with read.table()

## did your new factor levels "stick"? NO

## re-reorder the country factor
## re-inspect the levels ... confirm they are not merely alphabetical

## write to file with saveRDS()
## delete the R object from the workspace
## re-import the R object with readRDS()

## did your new factor levels "stick"? YES

## re-inspect the levels ... confirm they are not merely alphabetical

## write to file with dput()
## inspect that thing ... not meant for human eyeballs but is plain text
## delete the R object from the workspace
## re-import the R object with dget()
## did your new factor levels "stick"? YES

