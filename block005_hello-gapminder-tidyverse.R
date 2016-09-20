library(tidyverse)
library(gapminder)

gapminder
str(gapminder)
glimpse(gapminder)

head(gapminder)
tail(gapminder)

filter(gapminder, country == "Canada")
select(gapminder, year, lifeExp)
select(filter(gapminder, country == "Canada"), year, lifeExp)

gapminder %>%
  filter(country == "Canada")

gapminder %>%
  select(year, lifeExp)

gapminder %>%
  filter(country == "Canada") %>%
  select(year, lifeExp)

## show %>% slides here

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

## intro to dplyr
filter(gapminder, lifeExp < 29)
filter(gapminder, country == "Rwanda")
filter(gapminder, country %in% c("Rwanda", "Afghanistan"))
## FAQ / puzzle
filter(gapminder, country == c("Rwanda", "Afghanistan"))
