# Stat 545 getting data from the Web
Andrew MacDonald and Dr. Jenny Bryan  
2014-11-11  


```r
library(dplyr)
library(knitr)
library(devtools)
```

# Introduction

There are many ways to obtain data from the Internet; let's consider four categories:

* *click-and-download* on the internet as a "flat" file, such as .csv, .xls
* *install-and-play* published in a repository which has an API , which has been wrapped
* *API-query* published with an unwrapped API
* *Scraping* implicit in an html website

# Click-and-Download
We're not going to consider data that needs to be downloaded to your hard drive first, and which may require filling out a form etc. For example [World Value Survey]() or [gapminder]()

# install-and-play

Many web data sources provide a structured way of requesting and presenting data. A set of rules controls how computer programs ("clients") can make requests of the server, and how the server will respond. These rules are called **A**pplication **P**rogramming **I**nterfaces (API).

Many common web services and APIs have been "wrapped", i.e. R functions have been written around them which send your query to the server and format the response.

Why do we want this?

* provenance
* reproducible
* updating
* ease
* scaling

## Sightings of birds: `rebird`

[Rebird](https://github.com/ropensci/rebird) is an R interface for the [ebird]() database. Ebird lets birders upload sightings of birds, and allows everyone access to those data.


```r
install.packages("rebird")
```

```r
library(rebird)
```

Find out *WHEN* a bird has been seen in a certain place!


```r
ebirdgeo(species = 'spinus tristis', lat = 42, lng = -76)
```

rebird **knows where you are**:

```r
ebirdgeo(species = 'Buteo lagopus')
```

Get a list for an area. (Note that South and West are negative):


```r
vanbirds <- ebirdgeo(lat = 49.2500, lng = -123.1000)
vanbirds %>%
	head %>%
	kable
```



|comName                | howMany|   lat|    lng|locID    |locName        |locationPrivate |obsDt            |obsReviewed |obsValid |sciName            |
|:----------------------|-------:|-----:|------:|:--------|:--------------|:---------------|:----------------|:-----------|:--------|:------------------|
|Common Merganser       |      10| 49.17| -122.9|L1140384 |Annacis Island |FALSE           |2014-11-23 15:45 |FALSE       |TRUE     |Mergus merganser   |
|Northwestern Crow      |      20| 49.17| -122.9|L1140384 |Annacis Island |FALSE           |2014-11-23 15:45 |FALSE       |TRUE     |Corvus caurinus    |
|Mallard                |      20| 49.17| -122.9|L1140384 |Annacis Island |FALSE           |2014-11-23 15:45 |FALSE       |TRUE     |Anas platyrhynchos |
|Great Blue Heron       |       1| 49.17| -122.9|L1140384 |Annacis Island |FALSE           |2014-11-23 15:45 |FALSE       |TRUE     |Ardea herodias     |
|Golden-crowned Kinglet |       1| 49.17| -122.9|L1140384 |Annacis Island |FALSE           |2014-11-23 15:45 |FALSE       |TRUE     |Regulus satrapa    |
|Green-winged Teal      |      25| 49.17| -122.9|L1140384 |Annacis Island |FALSE           |2014-11-23 15:45 |FALSE       |TRUE     |Anas crecca        |

Check the defaults on this function. e.g. radius of circle, time of year.

Birds in a region:

```r
ebirdregion("AI")
```
(note that the link in the help file leads to a dead link (as I write this on 24 Nov) but you can probably use the codes from geonames, below)


## Searching geographic info: `geonames`

```r
#install.packages("rjson")
#install_github("ropensci/geonames")

library(geonames)
```

There are two things we need to do to be able to use this package to access the geonames API

1. go to [the geonames site](www.geonames.org/login/) and register an account. 
2. click [here](http://www.geonames.org/enablefreewebservice)
3. Tell R your geonames username:


```r
options(geonamesUsername="aammd")
```

What can we do? get access to lots of geographical information via the various "web services" see [here](http://www.geonames.org/export/ws-overview.html)


```r
countryInfo <- GNcountryInfo()
```


```r
countryInfo %>%
	head %>%
	kable
```



|continent |capital          |languages         |geonameId |south            |isoAlpha3 |north            |fipsCode |population |east             |isoNumeric |areaInSqKm |countryCode |west             |countryName                     |continentName |currencyCode |
|:---------|:----------------|:-----------------|:---------|:----------------|:---------|:----------------|:--------|:----------|:----------------|:----------|:----------|:-----------|:----------------|:-------------------------------|:-------------|:------------|
|EU        |Andorra la Vella |ca                |3041565   |42.4284925987684 |AND       |42.6560438963    |AN       |84000      |1.78654277783198 |020        |468.0      |AD          |1.40718671411128 |Principality of Andorra         |Europe        |EUR          |
|AS        |Abu Dhabi        |ar-AE,fa,en,hi,ur |290557    |22.6333293914795 |ARE       |26.0841598510742 |AE       |4975593    |56.3816604614258 |784        |82880.0    |AE          |51.5833282470703 |United Arab Emirates            |Asia          |AED          |
|AS        |Kabul            |fa-AF,ps,uz-AF,tk |1149361   |29.377472        |AFG       |38.483418        |AF       |29121286   |74.879448        |004        |647500.0   |AF          |60.478443        |Islamic Republic of Afghanistan |Asia          |AFN          |
|NA        |Saint John’s     |en-AG             |3576396   |16.996979        |ATG       |17.729387        |AC       |86754      |-61.672421       |028        |443.0      |AG          |-61.906425       |Antigua and Barbuda             |North America |XCD          |
|NA        |The Valley       |en-AI             |3573511   |18.166815        |AIA       |18.283424        |AV       |13254      |-62.971359       |660        |102.0      |AI          |-63.172901       |Anguilla                        |North America |XCD          |
|EU        |Tirana           |sq,el             |783754    |39.648361        |ALB       |42.665611        |AL       |2986952    |21.068472        |008        |28748.0    |AL          |19.293972        |Republic of Albania             |Europe        |ALL          |

This country info dataset is very helpful for accessing the rest of the data, because it gives us the standardized codes for country and language.  

What are the cities of France?

```r
countryInfo %>%
	filter(countryName == "France") %>%
	GNcities(north = .$north, east = .$east, south = .$south, west = .$west, maxRows = 500) %>%
	ungroup %>%
	head %>%
	kable
```



|lng               |geonameId |countrycode |name         |fclName           |toponymName  |fcodeName                     |wikipedia                                   |lat              |fcl |population |fcode |
|:-----------------|:---------|:-----------|:------------|:-----------------|:------------|:-----------------------------|:-------------------------------------------|:----------------|:---|:----------|:-----|
|2.3488            |2988507   |FR          |Paris        |city, village,... |Paris        |capital of a political entity |en.wikipedia.org/wiki/Paris                 |48.85341         |P   |2138551    |PPLC  |
|4.34878349304199  |2800866   |BE          |Brusela      |city, village,... |Brussels     |capital of a political entity |en.wikipedia.org/wiki/City_of_Brussels      |50.8504450552593 |P   |1019022    |PPLC  |
|7.44744300842285  |2661552   |CH          |Berna        |city, village,... |Bern         |capital of a political entity |en.wikipedia.org/wiki/Bern                  |46.9480943365053 |P   |121631     |PPLC  |
|6.13              |2960316   |LU          |Luxenburgo   |city, village,... |Luxembourg   |capital of a political entity |en.wikipedia.org/wiki/Luxembourg_%28city%29 |49.6116667       |P   |76684      |PPLC  |
|7.4166667         |2993458   |MC          |Monaco       |city, village,... |Monaco       |capital of a political entity |en.wikipedia.org/wiki/Monaco                |43.7333333       |P   |32965      |PPLC  |
|-2.10491180419922 |3042091   |JE          |Saint Helier |city, village,... |Saint Helier |capital of a political entity |en.wikipedia.org/wiki/Saint_Helier          |49.1880427659223 |P   |28000      |PPLC  |

How many birds have been seen in France?


```r
francebirds <- countryInfo %>%
	filter(countryName == "France") %>%
	group_by(countryName) %>%
	do(allbirds = ebirdregion(.$countryCode))  ## or perhaps fipsCode?

francebirds %>%
	summarize(nbirds = nrow(allbirds)) %>%
	ungroup %>%
	kable
```



| nbirds|
|------:|
|    156|


Geonames also helps us search Wikipedia!

```r
GNwikipediaSearch("London") %>%
	select(-summary) %>%
	head %>%
	kable
```



|elevation |geoNameId |feature |lng                 |countryCode |rank |thumbnailImg                                                      |lang |title                                  |lat               |wikipediaUrl                                                 |
|:---------|:---------|:-------|:-------------------|:-----------|:----|:-----------------------------------------------------------------|:----|:--------------------------------------|:-----------------|:------------------------------------------------------------|
|2         |2643741   |city    |-0.07857            |GB          |100  |http://www.geonames.org/img/wikipedia/43000/thumb-42715-100.jpg   |en   |London                                 |51.504872         |en.wikipedia.org/wiki/London                                 |
|262       |6058560   |city    |-81.2497            |CA          |100  |http://www.geonames.org/img/wikipedia/58000/thumb-57388-100.jpg   |en   |London, Ontario                        |42.9837           |en.wikipedia.org/wiki/London%2C_Ontario                      |
|60        |1006984   |city    |27.9036078333333    |ZA          |100  |http://www.geonames.org/img/wikipedia/138000/thumb-137098-100.jpg |en   |East London, Eastern Cape              |-33.0145668333333 |en.wikipedia.org/wiki/East_London%2C_Eastern_Cape            |
|14        |NA        |adm1st  |-0.0159638888888889 |GB          |98   |http://www.geonames.org/img/wikipedia/157000/thumb-156609-100.jpg |en   |London Borough of Lewisham             |51.4568777777778  |en.wikipedia.org/wiki/London_Borough_of_Lewisham             |
|27        |4839416   |NA      |-72.1008333333333   |US          |100  |http://www.geonames.org/img/wikipedia/160000/thumb-159123-100.jpg |en   |New London, Connecticut                |41.3555555555556  |en.wikipedia.org/wiki/New_London%2C_Connecticut              |
|13        |NA        |adm1st  |-0.303547222222222  |GB          |100  |http://www.geonames.org/img/wikipedia/146000/thumb-145782-100.jpg |en   |London Borough of Richmond upon Thames |51.4613416666667  |en.wikipedia.org/wiki/London_Borough_of_Richmond_upon_Thames |


We can use geonames to search for georeferenced Wikipedia articles! here are those within 20 Km of Rio de Janerio:

```r
rio_english <- GNfindNearbyWikipedia(lat = -22.9083, lng = -43.1964, radius = 20, lang = "en", maxRows = 500)
rio_portuguese <- GNfindNearbyWikipedia(lat = -22.9083, lng = -43.1964, radius = 20, lang = "pt", maxRows = 500)

nrow(rio_english)
```

```
## [1] 305
```

```r
nrow(rio_portuguese)
```

```
## [1] 349
```


## Searching the Public Library of Science: `rplos`
PLOS ONE is an open-access journal. They allow access to an impressive range of search tools, and allow you to obtain the full text of their articles. 


```r
install.packages("rplos")
## Do this only once:
```


```r
library(rplos)
```

```
## Loading required package: ggplot2
## 
## 
##  New to rplos? Tutorial at http://ropensci.org/tutorials/rplos_tutorial.html. Use suppressPackageStartupMessages() to suppress these startup messages in the future
```
Immediately we get a message. It's a link to the [tutorial on the Ropensci website!](http://ropensci.org/tutorials/rplos_tutorial.html). How nice :)

* We also get instructions to create a PLOS account: https://register.plos.org/ambra-registration/register.action
* Then go to Article Level Metrics http://alm.plos.org/
* click on your name to find your key.


```r
Sys.setenv(PlosApiKey = "Paste your Key in here!!")
key <-  Sys.getenv("PlosApiKey")
```


### alternate strategy for keeping keys: `.Rprofile`
**Remember to protect your key! it is important for your privacy. You know, like a key**
Now we follow the ROpenSci [tutorial on API keys](https://github.com/ropensci/rOpenSci/wiki/Installation-and-use-of-API-keys)
Make a `.rprofile` file [windows tips](http://cran.r-project.org/bin/windows/rw-FAQ.html#What-are-HOME-and-working-directories_003f) [mac tips](http://cran.r-project.org/bin/macosx/RMacOSX-FAQ.html#The-R-Console)
Write the following in it:

```r
options(PlosApiKey= "YOUR_KEY")
```

## Searching PLOS
Let's do some searches:

```r
searchplos(q= "Helianthus", fl= "id", limit = 5, key = key)
```


```r
searchplos("materials_and_methods:France", fl = "title, materials_and_methods", key = key)
lat <- searchplos("materials_and_methods:study site", fl = "title, materials_and_methods", key = key)
aff <- searchplos("*:*", fl = "title, author_affiliate", key = key)
aff$author_affiliate[[2]]
searchplos("*:*", fl = "id", key = key)
```

here is a list of [options for the search](http://api.plos.org/solr/search-fields/)
or can do `data(plosfields); plosfields`

### take a highbrow look!


```r
out <- highplos(q='alcohol', hl.fl = 'abstract', rows=10, , key = key)
highbrow(out)
```

## plots over time

```r
plot_throughtime(terms = "phylogeny", limit = 200, key = key)
```

![plot of chunk unnamed-chunk-22](./webdata02_activity_files/figure-html/unnamed-chunk-22.png) 


## is it a boy or a girl? `gender` throughout US history


```r
devtools::install_github("lmullen/gender-data-pkg")
devtools::install_github("ropensci/gender")
```

The gender package allows you access to American data on the gender of names. Because names change gender over the years, the probability of a name belonging to a man or a woman also depends on the *year*:


```r
library(gender)
gender("Kelsey")
```

```
## $name
## [1] "Kelsey"
## 
## $proportion_male
## [1] 0.0314
## 
## $proportion_female
## [1] 0.9686
## 
## $gender
## [1] "female"
## 
## $year_min
## [1] 1932
## 
## $year_max
## [1] 2012
```

```r
gender("Kelsey", years = 1940)
```

```
## $name
## [1] "Kelsey"
## 
## $proportion_male
## [1] 1
## 
## $proportion_female
## [1] 0
## 
## $gender
## [1] "male"
## 
## $year_min
## [1] 1940
## 
## $year_max
## [1] 1940
```


