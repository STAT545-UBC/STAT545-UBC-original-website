## indicative of some of the live coding done in
## cm005 and cm006
## on 2016-09-20 and 2016-09-22
library(tidyverse)
library(gapminder)

gapminder
str(gapminder)
glimpse(gapminder)

head(gapminder)
tail(gapminder)

filter(gapminder, country == "Canada")

## I got tugged in various directions by some good questions
filter(gapminder, year > 2000)
filter(gapminder, continent == "Europe", year == 2007)
filter(gapminder, country == "Bulgaria" | year == 2007)
filter(gapminder, country == "Bulgaria" | country == "Albania")
filter(gapminder, country %in% c("Bulgaria", "Albania"))
filter(gapminder, grepl("^F", country))
(canada <- filter(gapminder, country == "Canada"))

select(gapminder, year, lifeExp)

select(filter(gapminder, country == "Canada"), year, lifeExp)

select(
  filter(
    gapminder,
    country == "Canada"
  ),
  year,
  lifeExp
)

## looked at some %>% slides here

gapminder %>%
  filter(country == "Canada")

gapminder %>%
  select(year, lifeExp)

gapminder %>%
  filter(country == "Canada") %>%
  select(year, lifeExp)

gapminder %>%
  select(starts_with("co"))

## info about the data frame as a whole
names(gapminder)
colnames(gapminder)
ncol(gapminder)
length(gapminder)
dim(gapminder)
nrow(gapminder)

## shift from describing basic object to variables inside
summary(gapminder)

gapminder$country
gapminder[["country"]]
## use str() on the above; what are we getting back? are we getting same thing back?
## what if we use single bracket?
## store a variable name in a variable and then try to use it with $ and [[ and [
## what happens?
## apply summary to individual variables by hand
## what happens for different variables? what's the pattern by variable type?

## remember I have the "flavors of objects" slides
## and the ones about different modes of working with R

summary(gapminder)
## main way to get 1 variable: use $
gapminder$lifeExp
## another way to get 1 variable: use [[ ]]
gapminder[["gdpPercap"]]
## a way to get several variables: use [ ]
gapminder[c("year", "country")]

my_favorite_variable <- "country"
gapminder[[my_favorite_variable]]
gapminder$my_favorite_variable

str(gapminder$lifeExp)
str(gapminder["lifeExp"])
str(gapminder[c("year", "country")])

gapminder
gapminder$country
summary(gapminder$country)
table(gapminder$country)
class(gapminder$country)
levels(gapminder$country)
nlevels(gapminder$country)
## notice the hint re: integer codes under the hood
str(gapminder)

gapminder$continent
barplot(table(gapminder$continent))

gapminder$lifeExp
summary(gapminder$lifeExp)
hist(gapminder$lifeExp)

## we ended with a quick start on ggplot2 stuff
## slides then some scatterplotting
## https://github.com/jennybc/ggplot2-tutorial/blob/master/gapminder-ggplot2-scatterplot.r
