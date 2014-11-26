# Stat 545 getting data from the Web -- part 2
Andrew MacDonald and Dr. Jenny Bryan  
2014-11-26  


```r
library("knitr")
```


## Interacting with an API

On Monday we experimented with several packages that "wrapped" APIs.  That is, they handled the creation of the request and the formatting of the output. Today we're going to look at (part of) what these functions were doing.

First we're going to examine the structure of API requests via the  [Open Movie Database](http://www.omdbapi.com/). OMDb is very similar to IMDB, except it has a nice, simple API. We can go to the website, input some search parameters, and obtain both the XML query and the response from it. 

**EXERCISE** determine the shape of an API request:

Let's experiment with different values of the `title` and `year` fields. Notice the pattern in the request. For example for Title = Interstellar and Year = 2014, we get:

```http
http://www.omdbapi.com/?t=Interstellar&y=2014&plot=short&r=xml
```

Try pasting this link into the browser.  Also experiment with `json` and `xml`

How can we create this request in R?


```r
request <- paste0("http://www.omdbapi.com/?t=", "Interstellar", "&", "y=", "2014", "&", "plot=", "short", "&", "r=", "xml")
request
```

```
## [1] "http://www.omdbapi.com/?t=Interstellar&y=2014&plot=short&r=xml"
```

It works, but it's a bit ungainly.  Lets try to abstract that into a function:


```r
omdb <- function(Title, Year, Plot, Format){
  baseurl <- "http://www.omdbapi.com/?"
  params <- c("t=", "y=", "plot=", "r=")
  values <- c(Title, Year, Plot, Format)
  param_values <- Map(paste0, params, values)
  args <- paste0(param_values, collapse = "&")
  paste0(baseurl, args)
}

omdb("Interstellar", "2014", "short", "xml")
```

```
## [1] "http://www.omdbapi.com/?t=Interstellar&y=2014&plot=short&r=xml"
```

Now we have a handy function that returns the API query. We can paste in the link, but we can also obtain data from within R:


```r
request_interstellar <- omdb("Interstellar", "2014", "short", "xml")
answer_xml <- RCurl::getURL(request_interstellar)
answer_xml
```

```
## [1] "<?xml version=\"1.0\" encoding=\"UTF-8\"?><root response=\"True\"><movie title=\"Interstellar\" year=\"2014\" rated=\"PG-13\" released=\"07 Nov 2014\" runtime=\"169 min\" genre=\"Adventure, Sci-Fi\" director=\"Christopher Nolan\" writer=\"Jonathan Nolan, Christopher Nolan\" actors=\"Ellen Burstyn, Matthew McConaughey, Mackenzie Foy, John Lithgow\" plot=\"A group of explorers use a newly discovered wormhole to surpass the limitations on human space travel and conquer an interstellar endeavor.\" language=\"English\" country=\"USA, UK\" awards=\"1 nomination.\" poster=\"http://ia.media-imdb.com/images/M/MV5BMjIxNTU4MzY4MF5BMl5BanBnXkFtZTgwMzM4ODI3MjE@._V1_SX300.jpg\" metascore=\"73\" imdbRating=\"9.1\" imdbVotes=\"114,391\" imdbID=\"tt0816692\" type=\"movie\"/></root>"
```

```r
request_interstellar <- omdb("Interstellar", "2014", "short", "json")
answer_json <- RCurl::getURL(request_interstellar)
answer_json
```

```
## [1] "{\"Title\":\"Interstellar\",\"Year\":\"2014\",\"Rated\":\"PG-13\",\"Released\":\"07 Nov 2014\",\"Runtime\":\"169 min\",\"Genre\":\"Adventure, Sci-Fi\",\"Director\":\"Christopher Nolan\",\"Writer\":\"Jonathan Nolan, Christopher Nolan\",\"Actors\":\"Ellen Burstyn, Matthew McConaughey, Mackenzie Foy, John Lithgow\",\"Plot\":\"A group of explorers use a newly discovered wormhole to surpass the limitations on human space travel and conquer an interstellar endeavor.\",\"Language\":\"English\",\"Country\":\"USA, UK\",\"Awards\":\"1 nomination.\",\"Poster\":\"http://ia.media-imdb.com/images/M/MV5BMjIxNTU4MzY4MF5BMl5BanBnXkFtZTgwMzM4ODI3MjE@._V1_SX300.jpg\",\"Metascore\":\"73\",\"imdbRating\":\"9.1\",\"imdbVotes\":\"114,391\",\"imdbID\":\"tt0816692\",\"Type\":\"movie\",\"Response\":\"True\"}"
```

The get a form of data that is obviously structured. What is it?

## intro to JSON and XML

These are the two common languages of web services: **J**ava**S**cript **O**bject **N**otation and e**X**tensible **M**arkup **L**anguage. 

Here's an example of JSON: from [this wonderful site](https://zapier.com/learn/apis/chapter-3-data-formats/)

```javascript
{
  "crust": "original",
  "toppings": ["cheese", "pepperoni", "garlic"],
  "status": "cooking",
  "customer": {
    "name": "Brian",
    "phone": "573-111-1111"
  }
}
```
And here is XML:

```XML
<order>
    <crust>original</crust>
    <toppings>
        <topping>cheese</topping>
        <topping>pepperoni</topping>
        <topping>garlic</topping>
    </toppings>
    <status>cooking</status>
</order>
```

You can see that both of these data structures are quite easy to read. They are "self-describing". In other words, they tell you how they are meant to be read.

There are easy means of taking these data types and creating R objects.  You've already met the function `fromJSON` in the `jsonlite` package, thanks to Bernard:


```r
library("jsonlite")
```

```
## 
## Attaching package: 'jsonlite'
## 
## The following object is masked from 'package:utils':
## 
##     View
```

```r
fromJSON(answer_json)
```

```
## $Title
## [1] "Interstellar"
## 
## $Year
## [1] "2014"
## 
## $Rated
## [1] "PG-13"
## 
## $Released
## [1] "07 Nov 2014"
## 
## $Runtime
## [1] "169 min"
## 
## $Genre
## [1] "Adventure, Sci-Fi"
## 
## $Director
## [1] "Christopher Nolan"
## 
## $Writer
## [1] "Jonathan Nolan, Christopher Nolan"
## 
## $Actors
## [1] "Ellen Burstyn, Matthew McConaughey, Mackenzie Foy, John Lithgow"
## 
## $Plot
## [1] "A group of explorers use a newly discovered wormhole to surpass the limitations on human space travel and conquer an interstellar endeavor."
## 
## $Language
## [1] "English"
## 
## $Country
## [1] "USA, UK"
## 
## $Awards
## [1] "1 nomination."
## 
## $Poster
## [1] "http://ia.media-imdb.com/images/M/MV5BMjIxNTU4MzY4MF5BMl5BanBnXkFtZTgwMzM4ODI3MjE@._V1_SX300.jpg"
## 
## $Metascore
## [1] "73"
## 
## $imdbRating
## [1] "9.1"
## 
## $imdbVotes
## [1] "114,391"
## 
## $imdbID
## [1] "tt0816692"
## 
## $Type
## [1] "movie"
## 
## $Response
## [1] "True"
```

The output is a named list! A familiar and friendly R structure. Because data frames are lists, and because this list has no nested lists-within-lists, we can coerce it very simply:


```r
answer_list <- fromJSON(answer_json)
kable(data.frame(answer_list))
```



|Title        |Year |Rated |Released    |Runtime |Genre             |Director          |Writer                            |Actors                                                          |Plot                                                                                                                                        |Language |Country |Awards        |Poster                                                                                           |Metascore |imdbRating |imdbVotes |imdbID    |Type  |Response |
|:------------|:----|:-----|:-----------|:-------|:-----------------|:-----------------|:---------------------------------|:---------------------------------------------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------|:--------|:-------|:-------------|:------------------------------------------------------------------------------------------------|:---------|:----------|:---------|:---------|:-----|:--------|
|Interstellar |2014 |PG-13 |07 Nov 2014 |169 min |Adventure, Sci-Fi |Christopher Nolan |Jonathan Nolan, Christopher Nolan |Ellen Burstyn, Matthew McConaughey, Mackenzie Foy, John Lithgow |A group of explorers use a newly discovered wormhole to surpass the limitations on human space travel and conquer an interstellar endeavor. |English  |USA, UK |1 nomination. |http://ia.media-imdb.com/images/M/MV5BMjIxNTU4MzY4MF5BMl5BanBnXkFtZTgwMzM4ODI3MjE@._V1_SX300.jpg |73        |9.1        |114,391   |tt0816692 |movie |True     |

A similar process exists for XML formats:


```r
library(XML)
ans_xml_parsed <- xmlParse(answer_xml)
ans_xml_parsed
```

```
## <?xml version="1.0" encoding="UTF-8"?>
## <root response="True">
##   <movie title="Interstellar" year="2014" rated="PG-13" released="07 Nov 2014" runtime="169 min" genre="Adventure, Sci-Fi" director="Christopher Nolan" writer="Jonathan Nolan, Christopher Nolan" actors="Ellen Burstyn, Matthew McConaughey, Mackenzie Foy, John Lithgow" plot="A group of explorers use a newly discovered wormhole to surpass the limitations on human space travel and conquer an interstellar endeavor." language="English" country="USA, UK" awards="1 nomination." poster="http://ia.media-imdb.com/images/M/MV5BMjIxNTU4MzY4MF5BMl5BanBnXkFtZTgwMzM4ODI3MjE@._V1_SX300.jpg" metascore="73" imdbRating="9.1" imdbVotes="114,391" imdbID="tt0816692" type="movie"/>
## </root>
## 
```
Not exactly the response we were hoping for! This shows us some of the XML document's structure: 

  * a `<root>` node with a single child, `<movie>`. 
  * the information we want is all stored as attributes

From Nolan and Lang 2014:

> The `xmlRoot()` function returns an object of class `XMLInternalElementNode`. This is a regular
XML node and not specific to the root node, i.e., all XML nodes will appear in R with this class
or a more specific class. An object of class XMLInternalElementNode has four fields: name,
attributes, children and value, which we access with the methods xmlName(), xmlAttrs(), xmlChildren(), and xmlValue()

| field | method |
|:-----:|:------:|
| name  | `xmlName()` |
| attributes | `xmlAttrs()` |
| children  | `xmlChildren()` |
| value    | `xmlValue()`




```r
ans_xml_parsed_root <- xmlRoot(ans_xml_parsed)[["movie"]]  # could also use [[1]]
ans_xml_parsed_root
```

```
## <movie title="Interstellar" year="2014" rated="PG-13" released="07 Nov 2014" runtime="169 min" genre="Adventure, Sci-Fi" director="Christopher Nolan" writer="Jonathan Nolan, Christopher Nolan" actors="Ellen Burstyn, Matthew McConaughey, Mackenzie Foy, John Lithgow" plot="A group of explorers use a newly discovered wormhole to surpass the limitations on human space travel and conquer an interstellar endeavor." language="English" country="USA, UK" awards="1 nomination." poster="http://ia.media-imdb.com/images/M/MV5BMjIxNTU4MzY4MF5BMl5BanBnXkFtZTgwMzM4ODI3MjE@._V1_SX300.jpg" metascore="73" imdbRating="9.1" imdbVotes="114,391" imdbID="tt0816692" type="movie"/>
```

```r
ans_xml_attrs <- xmlAttrs(ans_xml_parsed_root)
ans_xml_attrs
```

```
##                                                                                                                                         title 
##                                                                                                                                "Interstellar" 
##                                                                                                                                          year 
##                                                                                                                                        "2014" 
##                                                                                                                                         rated 
##                                                                                                                                       "PG-13" 
##                                                                                                                                      released 
##                                                                                                                                 "07 Nov 2014" 
##                                                                                                                                       runtime 
##                                                                                                                                     "169 min" 
##                                                                                                                                         genre 
##                                                                                                                           "Adventure, Sci-Fi" 
##                                                                                                                                      director 
##                                                                                                                           "Christopher Nolan" 
##                                                                                                                                        writer 
##                                                                                                           "Jonathan Nolan, Christopher Nolan" 
##                                                                                                                                        actors 
##                                                                             "Ellen Burstyn, Matthew McConaughey, Mackenzie Foy, John Lithgow" 
##                                                                                                                                          plot 
## "A group of explorers use a newly discovered wormhole to surpass the limitations on human space travel and conquer an interstellar endeavor." 
##                                                                                                                                      language 
##                                                                                                                                     "English" 
##                                                                                                                                       country 
##                                                                                                                                     "USA, UK" 
##                                                                                                                                        awards 
##                                                                                                                               "1 nomination." 
##                                                                                                                                        poster 
##                                            "http://ia.media-imdb.com/images/M/MV5BMjIxNTU4MzY4MF5BMl5BanBnXkFtZTgwMzM4ODI3MjE@._V1_SX300.jpg" 
##                                                                                                                                     metascore 
##                                                                                                                                          "73" 
##                                                                                                                                    imdbRating 
##                                                                                                                                         "9.1" 
##                                                                                                                                     imdbVotes 
##                                                                                                                                     "114,391" 
##                                                                                                                                        imdbID 
##                                                                                                                                   "tt0816692" 
##                                                                                                                                          type 
##                                                                                                                                       "movie"
```


```r
kable(data.frame(t(ans_xml_attrs)))
```



|title        |year |rated |released    |runtime |genre             |director          |writer                            |actors                                                          |plot                                                                                                                                        |language |country |awards        |poster                                                                                           |metascore |imdbRating |imdbVotes |imdbID    |type  |
|:------------|:----|:-----|:-----------|:-------|:-----------------|:-----------------|:---------------------------------|:---------------------------------------------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------|:--------|:-------|:-------------|:------------------------------------------------------------------------------------------------|:---------|:----------|:---------|:---------|:-----|
|Interstellar |2014 |PG-13 |07 Nov 2014 |169 min |Adventure, Sci-Fi |Christopher Nolan |Jonathan Nolan, Christopher Nolan |Ellen Burstyn, Matthew McConaughey, Mackenzie Foy, John Lithgow |A group of explorers use a newly discovered wormhole to surpass the limitations on human space travel and conquer an interstellar endeavor. |English  |USA, UK |1 nomination. |http://ia.media-imdb.com/images/M/MV5BMjIxNTU4MzY4MF5BMl5BanBnXkFtZTgwMzM4ODI3MjE@._V1_SX300.jpg |73        |9.1        |114,391   |tt0816692 |movie |

### `XPATH`, the scandalously shallow introduction:

There is a special syntax for querying the structure of XML documents, called XPATH, which is an essential skill if you are doing extensive work with XML documents.

```r
movienode <- getNodeSet(ans_xml_parsed, "//movie")
movienode
```

```
## [[1]]
## <movie title="Interstellar" year="2014" rated="PG-13" released="07 Nov 2014" runtime="169 min" genre="Adventure, Sci-Fi" director="Christopher Nolan" writer="Jonathan Nolan, Christopher Nolan" actors="Ellen Burstyn, Matthew McConaughey, Mackenzie Foy, John Lithgow" plot="A group of explorers use a newly discovered wormhole to surpass the limitations on human space travel and conquer an interstellar endeavor." language="English" country="USA, UK" awards="1 nomination." poster="http://ia.media-imdb.com/images/M/MV5BMjIxNTU4MzY4MF5BMl5BanBnXkFtZTgwMzM4ODI3MjE@._V1_SX300.jpg" metascore="73" imdbRating="9.1" imdbVotes="114,391" imdbID="tt0816692" type="movie"/> 
## 
## attr(,"class")
## [1] "XMLNodeSet"
```

## Introducing the Easy Way: `httr`

`httr` is yet another star in the hadleyverse, this one designed to facilitate all things HTTP from within R.  This includes the major HTTP verbs, which are:
    * __GET__: fetch an existing resource. The URL contains all the necessary information the server needs to locate and return the resource.
    * __POST__: create a new resource. POST requests usually carry a payload that specifies the data for the new resource.
    * __PUT__: update an existing resource. The payload may contain the updated data for the resource.
    * __DELETE__: delete an existing resource.
[Source: HTTP made really easy](http://www.jmarshall.com/easy/http/)

HTTP is the foundation for APIs; understanding how it works is the key to interacting with all the diverse APIs out there. An excellent beginning resource for APIs (including HTTP basics) is [this simple guide](https://zapier.com/learn/apis/)

`httr` also facilitates a variety of ___authentication___ protocols.


```r
#devtools::install_github("hadley/httr", build_vignettes = TRUE, dependencies = TRUE)
install.packages("httr")
```

`httr` contains one function for every HTTP verb. The functions have the same names as the verbs (e.g. `GET()`, `POST()`).  They have more informative outputs than simply using `RCurl::getURL()`, and come with some nice convenience functions for working with the output:

```r
library(httr)

interstellar_json <- omdb("Interstellar", "2014", "short", "json")
response_json <- GET(interstellar_json)
content(response_json, as = "parsed", type = "application/json")
```

```
## $Title
## [1] "Interstellar"
## 
## $Year
## [1] "2014"
## 
## $Rated
## [1] "PG-13"
## 
## $Released
## [1] "07 Nov 2014"
## 
## $Runtime
## [1] "169 min"
## 
## $Genre
## [1] "Adventure, Sci-Fi"
## 
## $Director
## [1] "Christopher Nolan"
## 
## $Writer
## [1] "Jonathan Nolan, Christopher Nolan"
## 
## $Actors
## [1] "Ellen Burstyn, Matthew McConaughey, Mackenzie Foy, John Lithgow"
## 
## $Plot
## [1] "A group of explorers use a newly discovered wormhole to surpass the limitations on human space travel and conquer an interstellar endeavor."
## 
## $Language
## [1] "English"
## 
## $Country
## [1] "USA, UK"
## 
## $Awards
## [1] "1 nomination."
## 
## $Poster
## [1] "http://ia.media-imdb.com/images/M/MV5BMjIxNTU4MzY4MF5BMl5BanBnXkFtZTgwMzM4ODI3MjE@._V1_SX300.jpg"
## 
## $Metascore
## [1] "73"
## 
## $imdbRating
## [1] "9.1"
## 
## $imdbVotes
## [1] "114,391"
## 
## $imdbID
## [1] "tt0816692"
## 
## $Type
## [1] "movie"
## 
## $Response
## [1] "True"
```


```r
interstellar_xml <- omdb("Interstellar", "2014", "short", "xml")
response_xml <- GET(interstellar_xml)
content(response_xml, as = "parsed")
```

```
## <?xml version="1.0" encoding="UTF-8"?>
## <root response="True">
##   <movie title="Interstellar" year="2014" rated="PG-13" released="07 Nov 2014" runtime="169 min" genre="Adventure, Sci-Fi" director="Christopher Nolan" writer="Jonathan Nolan, Christopher Nolan" actors="Ellen Burstyn, Matthew McConaughey, Mackenzie Foy, John Lithgow" plot="A group of explorers use a newly discovered wormhole to surpass the limitations on human space travel and conquer an interstellar endeavor." language="English" country="USA, UK" awards="1 nomination." poster="http://ia.media-imdb.com/images/M/MV5BMjIxNTU4MzY4MF5BMl5BanBnXkFtZTgwMzM4ODI3MjE@._V1_SX300.jpg" metascore="73" imdbRating="9.1" imdbVotes="114,391" imdbID="tt0816692" type="movie"/>
## </root>
## 
```

In addition, `httr` gives us access to lots of useful information about the quality of our response. For example, the header:


```r
headers(response_xml)
```

```
## $`cache-control`
## [1] "private, max-age=909"
## 
## $`content-type`
## [1] "text/xml; charset=utf-8"
## 
## $expires
## [1] "Wed, 26 Nov 2014 17:26:14 GMT"
## 
## $`last-modified`
## [1] "Wed, 26 Nov 2014 16:26:14 GMT"
## 
## $vary
## [1] "*"
## 
## $server
## [1] "Microsoft-IIS/7.5"
## 
## $`x-aspnet-version`
## [1] "4.0.30319"
## 
## $`x-powered-by`
## [1] "ASP.NET"
## 
## $`access-control-allow-origin`
## [1] "*"
## 
## $date
## [1] "Wed, 26 Nov 2014 17:11:04 GMT"
## 
## $`content-length`
## [1] "731"
## 
## attr(,"class")
## [1] "insensitive" "list"
```

And also a handy means to extract specifically the HTTP status code:


```r
status_code(response_xml)
```

```
## [1] 200
```

It is very good to [learn your http status codes](https://www.flickr.com/photos/girliemac/sets/72157628409467125).  
The documentation for `httr` includes a vignette of "best practices for writing an API package", which is useful for when you want to bring your favourite web resource into the world of R!

## Scraping

What if data is present on a website, but isn't provided in an API at all? It is possible to grab that information too.  How easy that is to do depends a lot on the quality of the website that we are using.

HTML is a structured way of displaying information. It is very similar in structure to XML (in fact many modern html sites are actually XHTML5, [which is also valid XML](http://www.w3.org/TR/html5/the-xhtml-syntax.html))


Two pieces of equipment

* `rvest`: `devtools::install_github("hadley/rvest")`
* SelectorGadget: [Install in your browser](http://selectorgadget.com/)

Before we go any further, [let's play a game together!](http://flukeout.github.io)


```r
library(rvest)
```

### Obtain a table

Let's make a simple HTML table and then parse it! 

* make a new, empty project
* make a totally empty .Rmd file
* copy this into the body:
```r
---
output: html_document
---

``` r echo=FALSE, results='asis' 
library(gapminder)
knitr::kable(head(gapminder))
```
```
(uncommenting the code chunk)

* knit the document
* click "View in Browser"
* paste the url into the code below:


```r
html("file:///home/andrew/Documents/projects/GapminderHead/GapminderHead.html") %>%
  html_table
```

```
## [[1]]
##       country continent year lifeExp      pop gdpPercap
## 1 Afghanistan      Asia 1952   28.80  8425333     779.4
## 2 Afghanistan      Asia 1957   30.33  9240934     820.9
## 3 Afghanistan      Asia 1962   32.00 10267083     853.1
## 4 Afghanistan      Asia 1967   34.02 11537966     836.2
## 5 Afghanistan      Asia 1972   36.09 13079460     740.0
## 6 Afghanistan      Asia 1977   38.44 14880372     786.1
```

(note that this is also possible with `XML` package)

## scraping text: staRtrek

getting Star Trek species data from [MemoryAlpha](http://en.memory-alpha.org/)

```r
library("magrittr")
library("dplyr")
library("tidyr")

character_data <- function(chname){
  paste0("http://en.memory-alpha.org/wiki/", chname) %>%
    html %>%
    html_nodes(".wiki-sidebar") %>%
    html_table(header = FALSE) %>%
    extract2(1) %>%
    set_colnames(c("trait", "value")) %>%
    mutate(trait = gsub(":", "", trait)) %>%
    filter(trait %in% c("Gender","Species","Affiliation","Rank")) %>%
    mutate(name = chname) %>%
    spread(trait, value)
}

character_data("Worf")
```

```
##   name                         Affiliation Gender                 Rank
## 1 Worf Federation StarfleetHouse of Martok   Male Lieutenant Commander
##   Species
## 1 Klingon
```

### Random observations on scraping

* make sure you've obtained ONLY what you want! scroll over the whole page to ensure that selectorgadget hasn't found too many things
* if you are having trouble parsing, try selecting a smaller subset of the thing you are seeking (ie being more precise)

**MOST IMPORTANT** confirm that there is NO RopenSci package and NO API before you [spend hours scraping](https://rpubs.com/aammd/kivascrape) (the [API was right here](http://build.kiva.org/))

## Extras

## Airports

First go to this website about [Airports](https://www.developer.aero/Airport-API). Follow the link to get your API key (you will need to click a confirmation email)

All the airports of the planet:

```url
https://airport.api.aero/airport/?user_key={yourkey}
```
```
https://airport.api.aero/airport/match/toronto?user_key={yourkey}
```
```
https://airport.api.aero/airport/distance/YVR/LAX?user_key={yourkey}
```

Do you need just the US airports? this API does that [and is free](http://services.faa.gov/docs/services/airport/)

And even simpler API queries very simple data about the airports of the world:

```r
fromJSON(file = "http://airportcode.riobard.com/search?q=Toronto&fmt=JSON")
```

```r
fromJSON(file = "http://airportcode.riobard.com/airport/YVR?fmt=json")
```

perfectly possible to combine these into a handy `data.frame`. One way might be:


```r
library(jsonlite)

tdot_data <- fromJSON("http://airportcode.riobard.com/search?q=Toronto&fmt=JSON")
```


## Extending `gameday`

Does anybody remember this lovely function?

```r
gday <- function(team="canucks") {
  url <- paste0("http://live.nhle.com/GameData/GCScoreboard/", Sys.Date(), ".jsonp")
  grepl(team, RCurl::getURL(url), ignore.case=TRUE)
}
```

Here is the `httr` version:


```r
library(httr)
req <- GET("http://live.nhle.com/GameData/GCScoreboard/2014-11-24.jsonp")
jsonp <- content(req, "text")
json <- gsub('([a-zA-Z_0-9\\.]*\\()|(\\);?$)', "", jsonp, perl = TRUE)
data <- fromJSON(json)

data$games %>%
  kable
```

```
## 
## 
## |atcommon |canationalbroadcasts |ata |rl   | atsog|bs       |htcommon  |        id|atn          | hts|atc    |htn          |usnationalbroadcasts |gcl  |hta | ats|htc    | htsog|bsc   | gs|gcll |
## |:--------|:--------------------|:---|:----|-----:|:--------|:---------|---------:|:------------|---:|:------|:------------|:--------------------|:----|:---|---:|:------|-----:|:-----|--:|:----|
## |PENGUINS |TVA, SN              |PIT |TRUE |    33|FINAL OT |BRUINS    | 2.014e+09|PITTSBURGH   |   2|winner |BOSTON       |NBCSN                |TRUE |BOS |   3|       |    29|final |  5|TRUE |
## |FLYERS   |                     |PHI |TRUE |    21|FINAL SO |ISLANDERS | 2.014e+09|PHILADELPHIA |   1|       |NY ISLANDERS |                     |TRUE |NYI |   0|winner |    46|final |  5|TRUE |
## |SENATORS |                     |OTT |TRUE |    26|FINAL    |RED WINGS | 2.014e+09|OTTAWA       |   4|       |DETROIT      |                     |TRUE |DET |   3|winner |    43|final |  5|TRUE |
## |WILD     |                     |MIN |TRUE |    39|FINAL    |PANTHERS  | 2.014e+09|MINNESOTA    |   1|winner |FLORIDA      |                     |TRUE |FLA |   4|       |    30|final |  5|TRUE |
```
