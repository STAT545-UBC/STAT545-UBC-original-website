## decent account of our hands-on computing during class

## started as a scaffold with only the comments, then got populated with code
## "live"

## get into correct Project and working directory
## clean out the workspace, restart R

## open a new R script and save with a good name

## load packages: probably ggplot2 and dplyr?
library(ggplot2)
library(dplyr)

## new-ish package for reading data
library(readr)

## bring in Gapminder data
library(gapminder)
gap_tsv <- system.file("gapminder.tsv", package = "gapminder")
gDat <- read.delim(gap_tsv)
gDat2 <- read_tsv(gap_tsv)  ## some problems()
dim(gDat)

## optional: subset the Gapminder data drastically ... maybe use same 5
## countries from the factor reordering demo?
h_countries <-
  c("Egypt", "Haiti", "Romania", "Thailand", "Venezuela")
hDat <- gDat %>%
  filter(country %in% h_countries) %>%
  droplevels
## non pipe-y way to do this FYI:
## droplevels(subset(gDat, country %in% h_countries))
hDat %>% dim
table(hDat$country)
levels(hDat$country)

## use write.table() to write this to file
write.table(hDat, "hDat.txt")

## at first, use no arguments ... do you like what you see?
## probably not ... use those arguments people!
write.table(hDat, "hDat.csv", sep = ",", row.names = FALSE,
            quote = FALSE)

## try readr
write_csv(hDat, "hDat.csv")

## Jenny talking ...
## invertibility and internal consistency dilemma
## - plain text files
## - modularity: output of script i is input for script i + 1
## - be factor boss = order the levels in a principled way
## - avoid duplication of code and data

## my compromise: I save plain text (often ordered meaningfully) AND R-specific
## files

## inspect the levels of country
levels(hDat$country)

## reorder country according to one of the summary stats we've played with
iDat <- hDat %>%
  mutate(country = reorder(country, lifeExp, max))
data.frame(levels(hDat$country), levels(iDat$country))
## re-inspect the levels
## HAVE THEY CHANGED? YES

## write to file with write.table()
write.table(iDat, "iDat.csv", sep = ",", row.names = FALSE,
            quote = FALSE)
## use readr
write_csv(iDat, "iDat2.csv")
## delete the R object from the workspace
rm(iDat)
iDat ## is it truly gone? YES
## re-import the R object FROM FILE with read.table()
iDat <- read.csv("iDat.csv")
iDat2 <- read_csv("iDat2.csv")
identical(iDat, iDat2)  # gdpPercap not the same decimal places
## did your new factor levels "stick"? NO
levels(iDat$country)


## re-reorder the country factor
iDat <- hDat %>%
  mutate(country = reorder(country, lifeExp, max))
data.frame(levels(hDat$country), levels(iDat$country))
## re-inspect the levels ... confirm they are NOT merely alphabetical

## write to file with saveRDS()
saveRDS(iDat, "iDat.rds")
## delete the R object from the workspace
rm(iDat)
iDat
## re-import the R object with readRDS()
iDat <- readRDS("iDat.rds")
## did your new factor levels "stick"? YES
str(iDat)
levels(iDat$country)
## re-inspect the levels ... confirm they are not merely alphabetical

## write to file with dput()
dput(iDat, "iDat-dput.txt")
## inspect that thing ... not meant for human eyeballs but is plain text
rm(iDat)
iDat
## delete the R object from the workspace
iDat <- dget('iDat-dput.txt')
## re-import the R object with dget()
## did your new factor levels "stick"? YES
str(iDat)
levels(iDat$country)

## tidy up all the temporary files we've written
delete_me <- list.files(pattern = "[hi]Dat*")
delete_me
file.remove(delete_me)
