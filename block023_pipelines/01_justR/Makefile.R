## one script to rule them all

## clean out any previous work
outputs <- c("lotr_clean.tsv",            # 01_filterReorder.R
             "totalWordsByFilmRace.tsv",  # 02_aggregatePlot.R
             list.files(pattern = "*.png$"))
file.remove(outputs)

## run my scripts
source("00_downloadData.R")
source("01_filterReorder.R")
source("02_aggregatePlot.R")
