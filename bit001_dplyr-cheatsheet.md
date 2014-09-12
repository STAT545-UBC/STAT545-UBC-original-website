# Cheatsheet for dplyr join functions
Jenny Bryan  
11 September, 2014  

#### Why the cheatsheet

Examples for those of us who don't speak SQL so good. There are lots of [Venn diagrams re: SQL joins on the interwebs](http://images.google.com/images?q=sql+join), but I wanted R examples.

[Full documentation](http://www.rdocumentation.org/packages/dplyr) for the `dplyr` package, which is developed by Hadley Wickham and Romain Francois on [GitHub](https://github.com/hadley/dplyr).

Working with two small data.frames, `superheroes` and `publishers`.


```r
suppressPackageStartupMessages(library(dplyr))

superheroes <-
  c("    name, alignment, gender,         publisher",
    " Magneto,       bad,   male,            Marvel",
    "   Storm,      good, female,            Marvel",
    "Mystique,       bad, female,            Marvel",
    "  Batman,      good,   male,                DC",
    "   Joker,       bad,   male,                DC",
    "Catwoman,       bad, female,                DC",
    " Hellboy,      good,   male, Dark Horse Comics")
superheroes <- read.csv(text = superheroes, strip.white = TRUE)

publishers <- 
  c("publisher, yr_founded",
    "       DC,       1934",
    "   Marvel,       1939",
    "    Image,       1992")
publishers <- read.csv(text = publishers, strip.white = TRUE)
```

Sorry, cheat sheet does not illustrate "multiple match" situations terribly well.

Sub-plot: watch the row and variable order of the join results for a healthy reminder of why it's dangerous to rely on any of that in an analysis.

#### inner_join(superheroes, publishers)

> inner_join(x, y): return all rows from x where there are matching values in y, and all columns from x and y. If there are multiple matches between x and y, all combination of the matches are returned


```r
(ijsp <- inner_join(superheroes, publishers))
```

```
## Joining by: "publisher"
```

```
##       name alignment gender publisher yr_founded
## 1  Magneto       bad   male    Marvel       1939
## 2    Storm      good female    Marvel       1939
## 3 Mystique       bad female    Marvel       1939
## 4   Batman      good   male        DC       1934
## 5    Joker       bad   male        DC       1934
## 6 Catwoman       bad female        DC       1934
```

We lose Hellboy in the join because, although he appears in `x = superheroes`, his publisher Dark Horse Comics does not appear in `y = publishers`. The join result has all variables from `x = superheroes` plus `yr_founded`, from `y`.

<table border = 1>
<tr>
<td valign="top">
  superheroes
  
  |name     |alignment |gender |publisher         |
  |:--------|:---------|:------|:-----------------|
  |Magneto  |bad       |male   |Marvel            |
  |Storm    |good      |female |Marvel            |
  |Mystique |bad       |female |Marvel            |
  |Batman   |good      |male   |DC                |
  |Joker    |bad       |male   |DC                |
  |Catwoman |bad       |female |DC                |
  |Hellboy  |good      |male   |Dark Horse Comics |
</td>
<td valign="top">
  publishers
  
  |publisher | yr_founded|
  |:---------|----------:|
  |DC        |       1934|
  |Marvel    |       1939|
  |Image     |       1992|
</td>
<td valign="top">
  inner_join(x = superheroes, y = publishers)
  
  |name     |alignment |gender |publisher | yr_founded|
  |:--------|:---------|:------|:---------|----------:|
  |Magneto  |bad       |male   |Marvel    |       1939|
  |Storm    |good      |female |Marvel    |       1939|
  |Mystique |bad       |female |Marvel    |       1939|
  |Batman   |good      |male   |DC        |       1934|
  |Joker    |bad       |male   |DC        |       1934|
  |Catwoman |bad       |female |DC        |       1934|
</td>
</tr>
</table>
  
#### semi_join(superheroes, publishers)

> semi_join(x, y): return all rows from x where there are matching values in y, keeping just columns from x. A semi join differs from an inner join because an inner join will return one row of x for each matching row of y, where a semi join will never duplicate rows of x.


```r
(sjsp <- semi_join(superheroes, publishers))
```

```
## Joining by: "publisher"
```

```
##       name alignment gender publisher
## 1   Batman      good   male        DC
## 2    Joker       bad   male        DC
## 3 Catwoman       bad female        DC
## 4  Magneto       bad   male    Marvel
## 5    Storm      good female    Marvel
## 6 Mystique       bad female    Marvel
```

We get a similar result as with `inner_join()` but the join result contains only the variables originally found in `x = superheroes`.

<table border = 1>
  <tr>
  <td valign="top">
  superheroes
  
  |name     |alignment |gender |publisher         |
  |:--------|:---------|:------|:-----------------|
  |Magneto  |bad       |male   |Marvel            |
  |Storm    |good      |female |Marvel            |
  |Mystique |bad       |female |Marvel            |
  |Batman   |good      |male   |DC                |
  |Joker    |bad       |male   |DC                |
  |Catwoman |bad       |female |DC                |
  |Hellboy  |good      |male   |Dark Horse Comics |
</td>
  <td valign="top">
  publishers
  
  |publisher | yr_founded|
  |:---------|----------:|
  |DC        |       1934|
  |Marvel    |       1939|
  |Image     |       1992|
</td>
  <td valign="top">
  semi-join(x = superheroes, y = publishers)
  
  |name     |alignment |gender |publisher |
  |:--------|:---------|:------|:---------|
  |Batman   |good      |male   |DC        |
  |Joker    |bad       |male   |DC        |
  |Catwoman |bad       |female |DC        |
  |Magneto  |bad       |male   |Marvel    |
  |Storm    |good      |female |Marvel    |
  |Mystique |bad       |female |Marvel    |
</td>
</tr>
</table>

#### left_join(superheroes, publishers)

> left_join(x, y): return all rows from x, and all columns from x and y. If there are multiple matches between x and y, all combination of the matches are returned


```r
(ljsp <- left_join(superheroes, publishers))
```

```
## Joining by: "publisher"
```

```
##       name alignment gender         publisher yr_founded
## 1  Magneto       bad   male            Marvel       1939
## 2    Storm      good female            Marvel       1939
## 3 Mystique       bad female            Marvel       1939
## 4   Batman      good   male                DC       1934
## 5    Joker       bad   male                DC       1934
## 6 Catwoman       bad female                DC       1934
## 7  Hellboy      good   male Dark Horse Comics         NA
```

We basically get `x = superheroes` back, but with the addition of variable `yr_founded`, which is unique to `y = publishers`. Hellboy, whose publisher does not appear in `y = publishers`, has an `NA` for `yr_founded`.

<table border = 1>
  <tr>
  <td valign="top">
  superheroes
  
  |name     |alignment |gender |publisher         |
  |:--------|:---------|:------|:-----------------|
  |Magneto  |bad       |male   |Marvel            |
  |Storm    |good      |female |Marvel            |
  |Mystique |bad       |female |Marvel            |
  |Batman   |good      |male   |DC                |
  |Joker    |bad       |male   |DC                |
  |Catwoman |bad       |female |DC                |
  |Hellboy  |good      |male   |Dark Horse Comics |
</td>
  <td valign="top">
  publishers
  
  |publisher | yr_founded|
  |:---------|----------:|
  |DC        |       1934|
  |Marvel    |       1939|
  |Image     |       1992|
</td>
  <td valign="top">
  left_join(superheroes, publishers)
  
  |name     |alignment |gender |publisher         | yr_founded|
  |:--------|:---------|:------|:-----------------|----------:|
  |Magneto  |bad       |male   |Marvel            |       1939|
  |Storm    |good      |female |Marvel            |       1939|
  |Mystique |bad       |female |Marvel            |       1939|
  |Batman   |good      |male   |DC                |       1934|
  |Joker    |bad       |male   |DC                |       1934|
  |Catwoman |bad       |female |DC                |       1934|
  |Hellboy  |good      |male   |Dark Horse Comics |         NA|
</td>
</tr>
</table>

#### anti_join(superheroes, publishers)

> anti_join(x, y): return all rows from x where there are not matching values in y, keeping just columns from x


```r
(ajsp <- anti_join(superheroes, publishers))
```

```
## Joining by: "publisher"
```

```
##      name alignment gender         publisher
## 1 Hellboy      good   male Dark Horse Comics
```

We keep __only__ Hellboy now (and do not get `yr_founded`).

<table border = 1>
  <tr>
  <td valign="top">
  superheroes
  
  |name     |alignment |gender |publisher         |
  |:--------|:---------|:------|:-----------------|
  |Magneto  |bad       |male   |Marvel            |
  |Storm    |good      |female |Marvel            |
  |Mystique |bad       |female |Marvel            |
  |Batman   |good      |male   |DC                |
  |Joker    |bad       |male   |DC                |
  |Catwoman |bad       |female |DC                |
  |Hellboy  |good      |male   |Dark Horse Comics |
</td>
  <td valign="top">
  publishers
  
  |publisher | yr_founded|
  |:---------|----------:|
  |DC        |       1934|
  |Marvel    |       1939|
  |Image     |       1992|
</td>
  <td valign="top">
  anti_join(superheroes, publishers)
  
  |name    |alignment |gender |publisher         |
  |:-------|:---------|:------|:-----------------|
  |Hellboy |good      |male   |Dark Horse Comics |
</td>
</tr>
</table>

#### inner_join(publishers, superheroes)

> inner_join(x, y): return all rows from x where there are matching values in y, and all columns from x and y. If there are multiple matches between x and y, all combination of the matches are returned


```r
(ijps <- inner_join(publishers, superheroes))
```

```
## Joining by: "publisher"
```

```
##   publisher yr_founded     name alignment gender
## 1    Marvel       1939  Magneto       bad   male
## 2    Marvel       1939    Storm      good female
## 3    Marvel       1939 Mystique       bad female
## 4        DC       1934   Batman      good   male
## 5        DC       1934    Joker       bad   male
## 6        DC       1934 Catwoman       bad female
```

In a way, this does illustrate multiple matches, if you think about it from the `x = publishers` direction. Every publisher that has a match in `y = superheroes` appears multiple times in the result, once for each match. In fact, we're getting the same result as with `inner_join(superheroes, publishers)`, up to variable order (which you should also never rely on in an analysis).

<table border = 1>
<tr>
<td valign="top">
  superheroes
  
  |publisher | yr_founded|
  |:---------|----------:|
  |DC        |       1934|
  |Marvel    |       1939|
  |Image     |       1992|
</td>
<td valign="top">
  publishers
  
  |name     |alignment |gender |publisher         |
  |:--------|:---------|:------|:-----------------|
  |Magneto  |bad       |male   |Marvel            |
  |Storm    |good      |female |Marvel            |
  |Mystique |bad       |female |Marvel            |
  |Batman   |good      |male   |DC                |
  |Joker    |bad       |male   |DC                |
  |Catwoman |bad       |female |DC                |
  |Hellboy  |good      |male   |Dark Horse Comics |
</td>
<td valign="top">
  inner_join(x = publishers, y = superheroes)
  
  |publisher | yr_founded|name     |alignment |gender |
  |:---------|----------:|:--------|:---------|:------|
  |Marvel    |       1939|Magneto  |bad       |male   |
  |Marvel    |       1939|Storm    |good      |female |
  |Marvel    |       1939|Mystique |bad       |female |
  |DC        |       1934|Batman   |good      |male   |
  |DC        |       1934|Joker    |bad       |male   |
  |DC        |       1934|Catwoman |bad       |female |
</td>
</tr>
</table>
  
#### semi_join(superheroes, publishers)

> semi_join(x, y): return all rows from x where there are matching values in y, keeping just columns from x. A semi join differs from an inner join because an inner join will return one row of x for each matching row of y, where a semi join will never duplicate rows of x.


```r
(sjps <- semi_join(publishers, superheroes))
```

```
## Joining by: "publisher"
```

```
##   publisher yr_founded
## 1    Marvel       1939
## 2        DC       1934
```

Now the effects of switching the `x` and `y` roles is more clear. The result resembles `x = publishers`, but the publisher Image is lost, because there are no observations where `publisher == "Image"` in `y = superheroes`.

<table border = 1>
  <tr>
  <td valign="top">
  superheroes
  
  |publisher | yr_founded|
  |:---------|----------:|
  |DC        |       1934|
  |Marvel    |       1939|
  |Image     |       1992|
</td>
  <td valign="top">
  publishers
  
  |name     |alignment |gender |publisher         |
  |:--------|:---------|:------|:-----------------|
  |Magneto  |bad       |male   |Marvel            |
  |Storm    |good      |female |Marvel            |
  |Mystique |bad       |female |Marvel            |
  |Batman   |good      |male   |DC                |
  |Joker    |bad       |male   |DC                |
  |Catwoman |bad       |female |DC                |
  |Hellboy  |good      |male   |Dark Horse Comics |
</td>
  <td valign="top">
  semi-join(x = publishers, y = superheroes)
  
  |publisher | yr_founded|
  |:---------|----------:|
  |Marvel    |       1939|
  |DC        |       1934|
</td>
</tr>
</table>

#### left_join(superheroes, publishers)

> left_join(x, y): return all rows from x, and all columns from x and y. If there are multiple matches between x and y, all combination of the matches are returned


```r
(ljps <- left_join(publishers, superheroes))
```

```
## Joining by: "publisher"
```

```
##   publisher yr_founded     name alignment gender
## 1        DC       1934   Batman      good   male
## 2        DC       1934    Joker       bad   male
## 3        DC       1934 Catwoman       bad female
## 4    Marvel       1939  Magneto       bad   male
## 5    Marvel       1939    Storm      good female
## 6    Marvel       1939 Mystique       bad female
## 7     Image       1992     <NA>      <NA>   <NA>
```

We get a similar result as with `inner_join()` but the publisher Image survives in the join, even though no superheroes from Image appear in `y = superheroes`. As a result, Image has `NA`s for `name`, `alignment`, and `gender`.

<table border = 1>
  <tr>
  <td valign="top">
  publishers
  
  |publisher | yr_founded|
  |:---------|----------:|
  |DC        |       1934|
  |Marvel    |       1939|
  |Image     |       1992|
</td>
  <td valign="top">
  superheroes
  
  |name     |alignment |gender |publisher         |
  |:--------|:---------|:------|:-----------------|
  |Magneto  |bad       |male   |Marvel            |
  |Storm    |good      |female |Marvel            |
  |Mystique |bad       |female |Marvel            |
  |Batman   |good      |male   |DC                |
  |Joker    |bad       |male   |DC                |
  |Catwoman |bad       |female |DC                |
  |Hellboy  |good      |male   |Dark Horse Comics |
</td>
  <td valign="top">
  left_join(publishers, superheroes)
  
  |publisher | yr_founded|name     |alignment |gender |
  |:---------|----------:|:--------|:---------|:------|
  |DC        |       1934|Batman   |good      |male   |
  |DC        |       1934|Joker    |bad       |male   |
  |DC        |       1934|Catwoman |bad       |female |
  |Marvel    |       1939|Magneto  |bad       |male   |
  |Marvel    |       1939|Storm    |good      |female |
  |Marvel    |       1939|Mystique |bad       |female |
  |Image     |       1992|NA       |NA        |NA     |
</td>
</tr>
</table>

#### anti_join(superheroes, publishers)

> anti_join(x, y): return all rows from x where there are not matching values in y, keeping just columns from x


```r
(ajps <- anti_join(publishers, superheroes))
```

```
## Joining by: "publisher"
```

```
##   publisher yr_founded
## 1     Image       1992
```

We keep __only__ publisher Image now (and the variables found in `x = publishers`).

<table border = 1>
  <tr>
  <td valign="top">
  publishers
  
  |publisher | yr_founded|
  |:---------|----------:|
  |DC        |       1934|
  |Marvel    |       1939|
  |Image     |       1992|
</td>
  <td valign="top">
  superheroes
  
  |name     |alignment |gender |publisher         |
  |:--------|:---------|:------|:-----------------|
  |Magneto  |bad       |male   |Marvel            |
  |Storm    |good      |female |Marvel            |
  |Mystique |bad       |female |Marvel            |
  |Batman   |good      |male   |DC                |
  |Joker    |bad       |male   |DC                |
  |Catwoman |bad       |female |DC                |
  |Hellboy  |good      |male   |Dark Horse Comics |
</td>
  <td valign="top">
  anti_join(publishers, superheroes)
  
  |publisher | yr_founded|
  |:---------|----------:|
  |Image     |       1992|
</td>
</tr>
</table>
