## ----message=FALSE-------------------------------------------------------
#install_github("ropensci/geonames")
# install.packages(geonames)
library(geonames)
library(dplyr)

## ----eval = FALSE--------------------------------------------------------
## library(geonames)
## options(geonamesUsername="aammd")
## # source(".RProfile")

## ------------------------------------------------------------------------
countryInfo <- GNcountryInfo()

## ----results='asis'------------------------------------------------------
francedata <- countryInfo %>%
	filter(countryName == "France")

frenchcities <-	with(francedata,
                     GNcities(north = north, east = east, south = south,
                              west = west, maxRows = 500))


## ----results='asis'------------------------------------------------------
francebirds <- countryInfo %>%
	filter(countryName == "France")


## ------------------------------------------------------------------------
rio_english <- GNfindNearbyWikipedia(lat = -22.9083, lng = -43.1964,
																		 radius = 20, lang = "en", maxRows = 500)
rio_portuguese <- GNfindNearbyWikipedia(lat = -22.9083, lng = -43.1964,
																				radius = 20, lang = "pt", maxRows = 500)

save(countryInfo, file = "countryInfo.rds")
save(francebirds, file = "francebirds.rds")
save(frenchcities, file = "frenchcities.rds")
save(rio_english, file = "rio_english.rds")
save(rio_portuguese, file = "rio_portuguese.rds")